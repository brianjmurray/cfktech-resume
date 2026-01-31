---
title: ""
author: Brian J. Murray
date: January 25, 2026 — Updated
geometry: margin=0.75in
fontsize: 11pt
titlepage: false
---

# BRIAN J. MURRAY

brian@cfktech.com · LinkedIn: https://www.linkedin.com/in/brianjmurray/

## PROFESSIONAL EXPERIENCE

### Independence Pet Holdings

#### Senior Data Engineer (04/2023–Present)
- Designed and operated Databricks lakehouse pipelines across Bronze/Silver/Gold tiers using Unity Catalog, Delta Live Tables, and Delta Lake for multiple domains (CRM, Quote, Phone, Salesforce, Marketing).
- Built parameterized, reusable ETL frameworks and notebooks for incremental loads (cron-driven windows), deduplication via windowing, and Delta MERGE upserts; added Teams webhooks and job health rules for reliability.
- Implemented dynamic DLT materialized views for Embrace domain by introspecting information_schema and generating managed tables with deletion vectors and row tracking.
- Delivered Quote Event pipelines with streaming ingestion and downstream Gold facts/dimensions (e.g., visit attribution) and integrated SDtatsig data for experimentation analytics.
- Stood up scheduled partner exports, hardening jobs with retries, SLAs, and idempotent writes.
- Standardized multi-environment CI/CD using Databricks Asset Bundles and Azure DevOps: validate → deploy → run across dev/rc/prod with service-principal run-as, Key Vault integration, and optional auto-approve for controlled rollouts.
- Introduced per-developer isolation strategies in dev (user-suffixed schemas/catalogs) and Photon/serverless configurations to improve query performance and reduce cost.
- Refactored legacy jobs into bundle-managed resources, parameterized catalogs/schemas, and consolidated schedules via Quartz cron; added centralized logging/metrics and alerting.
- Tech: Python (PySpark), SQL, Delta Lake/DLT, Unity Catalog, Databricks CLI, Azure DevOps, Azure CLI, Databricks Asset Bundles.

### Independence Pet Group

#### Manager, Data Development (08/2021–04/2023)
- Lead and train team responsible for ETL/ELT processes to transactional database, warehouse, Salesforce and partners.
- Migrate on-premises database to Azure SQL Database, maintaining multiple cloud environments.
- Set up CI/CD process using Azure DevOps, automating the promotion of Azure Data Factory from Dev—>UAT—>Production environments.
- Automate DBA tasks via Azure CLI.
- Gather requirements other areas of the business to support their data needs; including, but not limited to, reporting and data science, marketing, partner services and finance. Translating business rules into automated production data processes.
- Led proof-of-concept project for converting on-prem MSSSQL Server to AWS Aurora Postgres compatible via AWS DMS.
- Work closely with Marketing to migrate from Redpoint to Salesforce Marketing Cloud setting up ETL pipelines, SFMC Data Extensions and Automations through implementation.
- Architect parameterized ADF data pipelines to ingest from multiple MSSQL, Postgres, Redshift, Excel, Delimited text and API to parquet on data lake storage.
- Built Snowflake stored procedures to automate creation of tables, stages, initial loads and snow pipes to ingest parquet files from data lake storage.
- Build Snowflake stored procedures to analyze data in staged files and dynamically create stored procedures for merging data into tables.

#### Senior Database Developer (09/2012–08/2021)
- Collaborated with stakeholders to gather requirements, design solutions, manage the distribution of work, test cases and ensure the timely completion of project deliverables.
- Provided technical guidance and design including best practices for data development, ETL pipelines and deployment.
- Communicated technical concepts to diverse audiences in a clear and compelling way through project write-ups, presentations and meetings.
- Managed all areas related to SDLC related to data elements.
- Reduced onboarding of new partners from weeks to hours through creation of custom C# source via SSIS process to ingest and export multiple flat file formats, delimited and fixed width, to exchange with partners maintainIng configuration in database.
- Researched and made recommendations on the adoption of new tools for data strategies, data solutions and code management.
- Automated process for ingesting data from third party financial system to make available for other internal teams, alleviating the need to contact the finance team for status.
- Worked with corporate finance team to generate monthly financial reports for compliance.
- Ran proof-of-concept project for migration from Microsoft SQL Server to Postgres.
- Assisted reporting team with troubleshooting of SQL Server Reporting Services (SSRS) and Tableau Dashboards.
- Data cleansing, analysis and merging of full and incremental data sets from disparate data sources.

### OEConnection LLC

#### Associate Software Engineer (03/2011–09/2012)
- Wrote design documentation outlining the technical solutions needed to meet business requirements.
- Managed projects through development, testing and production environments. Set timelines, delegated tasks and ensured the software development life cycle policies were adhered to.
- Quickly troubleshot and developed solutions for production issues, twice winning an award presented by customer service for this task.
- Led review of design and test plan documentation and code implementation.
- Built web user interface for commonly used queries that streamlined workflow for tier 2 customer service.
- Automated manual data deploy process using SSIS, SQL jobs and a web user interface for scheduling and configuration of SSIS package.

## CERTIFICATIONS

**Databricks Data Engineer Associate** (June 2025)

## EDUCATION

**Macomb Community College**, Warren, Michigan  
Associate of Applied Science – Networking Specialist (May 2003)



