---
layout: default
title: "cfk tech"
---

<section class="hero">
  <div class="hero-content">
    <h1>Enterprise Data Architecture</h1>
    <p class="tagline">Designing secure, scalable data platforms with Databricks, Unity Catalog, Terraform, and modern DevOps practices.</p>
    <p class="subtitle">I help organizations turn fragmented data ecosystems into governed platforms for analytics, reporting, and AI-ready data products.</p>
    <div class="hero-cta">
      <a href="#about" class="btn btn-primary">Learn More</a>
      <a href="/blog" class="btn btn-secondary">Read My Blog</a>
    </div>
  </div>
</section>

<section id="about" class="about">
  <h2>About</h2>
  
  <p>I'm a Senior Data Architect with deep experience building production-grade data platforms on Databricks and Azure. My work spans enterprise architecture, platform engineering, governance, CI/CD, and hands-on data engineering for regulated insurance data environments.</p>
  
  <h3>Specializations</h3>
  <ul>
    <li><strong>Enterprise Data Platforms</strong>: Databricks workspace strategy, medallion architecture, cross-brand data sharing, and Unity Catalog governance</li>
    <li><strong>Infrastructure as Code</strong>: Terraform, Databricks Asset Bundles, Azure DevOps CI/CD, service-principal deployments, and environment promotion controls</li>
    <li><strong>Data Governance</strong>: PII classification, masking policies, catalog permissions, Purview alignment, and analyst/engineering access models</li>
    <li><strong>Data Engineering</strong>: PySpark, SQL, DLT/Lakeflow, Delta Lake, streaming and batch pipelines, and performance-focused ETL/ELT patterns</li>
    <li><strong>Architecture Strategy</strong>: Databricks, Microsoft Fabric/OneLake, Power BI, Snowflake/dbt integration, and AI-ready data platform planning</li>
  </ul>
  
  <h3>Recent Focus</h3>
  <p>Currently leading data architecture work for a multi-brand insurance platform: secure Databricks infrastructure, Unity Catalog governance, reusable Terraform patterns, and CI/CD guardrails for enterprise data products.</p>
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
  <p>Have questions about Databricks architecture, Unity Catalog governance, data platform CI/CD, or infrastructure automation? I'm open to collaborations, technical discussions, and consulting opportunities.</p>
  
  <div class="contact-links">
    <a href="mailto:brian@cfktech.com" class="contact-link">Email</a>
    <a href="https://github.com/brianjmurray" class="contact-link">GitHub</a>
    <a href="https://www.linkedin.com/in/brianjmurray/" class="contact-link">LinkedIn</a>
  </div>
</section>

<section class="donation">
  <h2>Support This Work</h2>
  <p>If you find value in this content, consider supporting my work. Your support helps me continue creating tutorials, sharing insights, and building tools for the data engineering community.</p>
  
  <div class="donation-cta">
    <a href="https://buymeacoffee.com/cfktech" class="btn btn-primary" target="_blank" rel="noopener noreferrer">Buy Me a Coffee ☕</a>
  </div>
  
  <p class="donation-note"><small>100% of contributions go toward content creation and tools development.</small></p>
</section>
