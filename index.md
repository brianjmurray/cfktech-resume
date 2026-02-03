---
layout: default
title: "Brian J. Murray - Résumé"
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

<section class="donation">
  <h2>Support This Work</h2>
  <p>If you find value in this content, consider supporting my work. Your support helps me continue creating tutorials, sharing insights, and building tools for the data engineering community.</p>
  
  <div class="donation-cta">
    <a href="https://buymeacoffee.com/cfktech" class="btn btn-primary" target="_blank" rel="noopener noreferrer">Buy Me a Coffee ☕</a>
  </div>
  
  <p class="donation-note"><small>100% of contributions go toward content creation and tools development.</small></p>
</section>
