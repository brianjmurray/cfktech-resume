---
layout: home
title: "Data Architecture & Engineering"
---

<section class="hero">
  <div class="hero-content">
    <h1>Data Architecture & Engineering</h1>
    <p class="tagline">Building scalable data platforms with Databricks, infrastructure as code, and modern DevOps practices.</p>
    <p class="subtitle">I help organizations design, build, and optimize data ecosystems that scale.</p>
    <div class="hero-cta">
      <a href="#about" class="btn btn-primary">Learn More</a>
      <a href="/blog" class="btn btn-secondary">Read My Blog</a>
    </div>
  </div>
</section>

<section id="about" class="about">
  <h2>About</h2>
  
  <p>I'm a Senior Data Engineer and emerging Data Architect with deep expertise in building production-grade data platforms on Databricks. With 8+ years in data engineering, I've evolved from writing SQL and building pipelines to designing multi-environment data architectures that power business intelligence and analytics at scale.</p>
  
  <h3>Specializations</h3>
  <ul>
    <li><strong>Data Platforms</strong>: Designing scalable Databricks workspaces, Delta Lake architectures, Unity Catalog implementations</li>
    <li><strong>Infrastructure as Code</strong>: Terraform, Databricks Asset Bundles, Azure DevOps CI/CD for data infrastructure</li>
    <li><strong>Data Engineering</strong>: PySpark optimization, medallion architectures (Bronze/Silver/Gold), ETL/ELT patterns</li>
    <li><strong>DevOps & AI</strong>: Automated deployments, monitoring, AI-assisted data optimization, LLM integration for data tasks</li>
  </ul>
  
  <h3>Recent Focus</h3>
  <p>Currently exploring the intersection of AI and data engineering—using LLMs to accelerate data documentation, optimization, and infrastructure automation.</p>
</section>

<section class="featured">
  <h2>Featured Work</h2>
  <p>Sharing what I'm building and learning in data architecture, infrastructure as code, and modern DevOps.</p>
  
  <div class="featured-grid">
    {% for post in site.posts limit:3 %}
      <article class="featured-card">
        <h3><a href="{{ post.url }}">{{ post.title }}</a></h3>
        <p class="post-date">{{ post.date | date: "%B %d, %Y" }}</p>
        <p>{{ post.excerpt }}</p>
        <a href="{{ post.url }}" class="read-more">Read More →</a>
      </article>
    {% endfor %}
  </div>
  
  <p class="featured-link"><a href="/blog">View all posts →</a></p>
</section>

<section class="cta">
  <h2>Let's Connect</h2>
  <p>Have questions about data architecture, Databricks workspace design, or infrastructure automation? I'm open to collaborations, technical discussions, and consulting opportunities.</p>
  
  <div class="contact-links">
    <a href="mailto:brian@cfktech.com" class="contact-link">Email</a>
    <a href="https://github.com/brianjmurray" class="contact-link">GitHub</a>
    <a href="https://www.linkedin.com/in/brianjmurray/" class="contact-link">LinkedIn</a>
  </div>
</section>
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

