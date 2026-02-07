---
layout: post
title: "Reusable Azure DevOps Pipeline Templates for Databricks Asset Bundles"
date: 2026-02-07
tags: [DevOps, Databricks, CI/CD, Azure, Automation]
---

## The Problem: Repeating CI/CD Setup Across Projects

If you've worked on multiple Databricks projects, you've probably experienced the tedium of setting up CI/CD pipelines for each one. Every project needs:

- Python environment setup
- Databricks CLI installation and configuration
- Bundle validation
- Deployment to multiple environments
- Job execution
- Unit test integration

Copy-pasting pipeline YAML between projects leads to drift, inconsistencies, and maintenance headaches. When you need to update authentication logic or add a new step, you're touching dozens of files across repositories.

## The Solution: Centralized Pipeline Templates

I created [devops-databricks-asset-bundles](https://github.com/brianjmurray/devops-databricks-asset-bundles)—a repository of reusable Azure DevOps pipeline templates that standardize Databricks deployments across all projects.

### Architecture

```
devops-databricks-asset-bundles/
├── databricks-bundle-pipeline-template.yml   # Main template
└── steps/
    ├── checkout-self.yml                     # Repository checkout
    ├── setup-python.yml                      # Python + pytest
    ├── install-databricks-cli.yml            # CLI installation
    ├── configure-databricks-cli.yml          # Azure auth + CLI config
    ├── run-unit-tests.yml                    # Dynamic test discovery
    ├── validate-databricks-bundle.yml        # Bundle validation
    ├── deploy-databricks-bundle.yml          # Deployment with auto-approve
    └── run-databricks-jobs.yml               # Job execution
```

Each step template handles one specific concern. The main template orchestrates them into a complete CI/CD pipeline with validation, staging, and production stages.

## How It Works

### 1. Import Once, Use Everywhere

Import the template repository into your Azure DevOps organization once. Then reference it as a resource in any project:

```yaml
resources:
  repositories:
    - repository: templates
      type: git
      name: YourOrg/devops-databricks-asset-bundles

extends:
  template: databricks-bundle-pipeline-template.yml@templates
  parameters:
    projectName: 'MyDataPipeline'
    workingDirectory: 'databricks'
    azureSubscription: 'Azure-Prod-Connection'
    jobNames: ['DailyETL', 'WeeklyAggregation']
    devVariableGroup: 'databricks-dev'
    stagingVariableGroup: 'databricks-staging'
    prodVariableGroup: 'databricks-prod'
```

That's it. Your project now has a complete CI/CD pipeline with:
- Validation on feature branches
- Deployment to staging on `dev` branch
- Deployment to production on `main` branch
- Automatic job execution post-deployment

### 2. Azure AD Authentication

One of the trickier parts of Databricks CI/CD is authentication. The template handles this using Azure service connections:

```yaml
# From configure-databricks-cli.yml
- task: AzureCLI@2
  inputs:
    azureSubscription: ${{ parameters.azureSubscription }}
    scriptType: "bash"
    inlineScript: |
      DATABRICKS_TOKEN=$(az account get-access-token \
        --resource 2ff814a6-3304-4ab8-85cb-cd0e6f879c1d \
        --query "accessToken" -o tsv)
      echo "##vso[task.setvariable variable=DATABRICKS_TOKEN]$DATABRICKS_TOKEN"
```

The magic number `2ff814a6-3304-4ab8-85cb-cd0e6f879c1d` is the Azure Databricks resource ID. This approach uses your existing Azure service connection to generate short-lived Databricks tokens—no need to manage separate Databricks PATs.

### 3. Automatic Unit Test Discovery

Tests are discovered and executed automatically if they exist:

```yaml
# From run-unit-tests.yml
if [ -d "tests" ] && [ "$(find tests -name 'test_*.py' -o -name '*_test.py' | wc -l)" -gt 0 ]; then
  python -m pytest tests/ -v --junitxml=test-results.xml --cov=. --cov-report=xml
fi
```

No tests? The pipeline continues. Have tests? They run automatically with coverage reports published to Azure DevOps. Failed tests block deployment.

### 4. Smart Stage Conditions

The template is designed to avoid redundant work:

```yaml
stages:
  - stage: Validate
    # Only validate on feature branches (not main/dev)
    condition: |
      and(
        ne(variables['Build.SourceBranch'], 'refs/heads/main'),
        ne(variables['Build.SourceBranch'], 'refs/heads/dev')
      )
    
  - stage: toStaging
    # Deploy to staging only from dev branch
    condition: eq(variables['Build.SourceBranch'], 'refs/heads/dev')
    dependsOn: []  # Run in parallel, don't wait for Validate
```

Why skip validation on `main` and `dev`? Because those branches run the full deployment which includes validation. Running validation separately would mean setting up Python and the CLI twice.

## Key Features

### Auto-Approve for Automated Pipelines

Databricks bundle deployments can prompt for confirmation when making destructive changes. For automated CI/CD, you often want to bypass this:

```yaml
extends:
  template: databricks-bundle-pipeline-template.yml@templates
  parameters:
    autoApprove: true  # Adds --auto-approve flag
    # ...
```

Use with caution in production—this will automatically approve resource deletions.

### Wait (or Don't) for Jobs

Some Databricks jobs run for hours. Waiting for them would timeout your pipeline:

```yaml
extends:
  template: databricks-bundle-pipeline-template.yml@templates
  parameters:
    jobNames: ['LongRunningETL']
    waitForJobs: false  # Trigger and continue
    # ...
```

When `waitForJobs: false`, the job is triggered with `--no-wait` and the pipeline succeeds immediately. Check the Databricks UI for actual job status.

### Environment Variables via Variable Groups

Each environment (dev, staging, prod) uses its own Azure DevOps variable group:

```yaml
parameters:
  devVariableGroup: 'databricks-dev'       # Contains DATABRICKS_HOST for dev
  stagingVariableGroup: 'databricks-staging'
  prodVariableGroup: 'databricks-prod'
```

Variable groups typically contain:
- `DATABRICKS_HOST`: Workspace URL
- `env`: Target name matching your `databricks.yml` targets

## Example Project Structure

Here's how a Databricks project looks when using these templates:

```
my-databricks-project/
├── azure-pipelines.yml           # References the template
├── databricks/
│   ├── databricks.yml            # Databricks bundle config
│   ├── src/
│   │   ├── main.py
│   │   └── transformations.py
│   └── resources/
│       └── jobs.yml
└── tests/
    ├── __init__.py
    ├── test_transformations.py
    └── test_main.py
```

The `azure-pipelines.yml` is minimal:

```yaml
trigger:
  branches:
    include: [main, dev]

pr:
  branches:
    include: [main]

resources:
  repositories:
    - repository: templates
      type: git
      name: MyOrg/devops-databricks-asset-bundles

extends:
  template: databricks-bundle-pipeline-template.yml@templates
  parameters:
    projectName: 'my-databricks-project'
    workingDirectory: 'databricks'
    azureSubscription: 'Azure-Production'
    jobNames: ['daily_etl']
    devVariableGroup: 'databricks-dev'
    stagingVariableGroup: 'databricks-staging'
    prodVariableGroup: 'databricks-prod'
```

## Why Not GitHub Actions?

This template is Azure DevOps-specific because:

1. **Enterprise adoption**: Most organizations using Databricks on Azure are already invested in Azure DevOps
2. **Service connections**: Azure DevOps service connections integrate seamlessly with Azure AD authentication
3. **Variable groups**: Centralized secret management across environments
4. **Template extends**: Azure DevOps `extends` keyword provides clean template inheritance

A GitHub Actions version would require different authentication patterns (OIDC, service principals) and secret management. That's a potential future project.

## Getting Started

1. **Import the repository** into your Azure DevOps organization:
   - Go to Repos → Import
   - URL: `https://github.com/brianjmurray/devops-databricks-asset-bundles.git`

2. **Set up variable groups** for each environment with `DATABRICKS_HOST` and `env`

3. **Create an Azure service connection** with access to your Databricks workspaces

4. **Reference the template** in your project's `azure-pipelines.yml`

## Future Improvements

Ideas for expanding the templates:

- **Artifact publishing**: Wheel/egg builds for library projects
- **Integration tests**: Post-deployment validation against real data
- **Rollback support**: Automatic rollback on job failures
- **Notifications**: Slack/Teams integration for deployment status
- **Multi-workspace**: Deploy same bundle to multiple workspaces

## Conclusion

Centralizing CI/CD templates eliminates the "copy-paste pipeline" anti-pattern. Update authentication logic once, and all projects benefit. Add a new step (like security scanning), and it rolls out everywhere.

The [devops-databricks-asset-bundles](https://github.com/brianjmurray/devops-databricks-asset-bundles) repository is open source. Feel free to fork it, adapt it to your needs, or contribute improvements back.

---

*Repository: [github.com/brianjmurray/devops-databricks-asset-bundles](https://github.com/brianjmurray/devops-databricks-asset-bundles)*
