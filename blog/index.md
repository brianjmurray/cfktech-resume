---
layout: default
title: Blog
permalink: /blog/
---

<h1>Blog</h1>

<div class="blog-header">
  <p>Explore articles on data engineering, DevOps, and portfolio development.</p>
  <div class="blog-nav-links">
    <a href="/blog/search/" class="nav-link">🔍 Search</a>
    <a href="/blog/tags/" class="nav-link">🏷️ Tags</a>
  </div>
</div>

<div class="blog-posts">
  {% for post in site.posts %}
    <article class="blog-post-preview">
      <h2><a href="{{ post.url }}">{{ post.title }}</a></h2>
      <p class="post-date">{{ post.date | date: "%B %d, %Y" }}</p>
      {% if post.tags %}
        <div class="post-tags">
          {% for tag in post.tags %}
            <a href="/blog/tags/{{ tag | downcase | replace: ' ', '-' | replace: '/', '-' }}/" class="post-tag">{{ tag }}</a>
          {% endfor %}
        </div>
      {% endif %}
      <p class="post-excerpt">{{ post.excerpt }}</p>
      <a href="{{ post.url }}" class="read-more">Read More →</a>
    </article>
  {% endfor %}
</div>

<style>
  .blog-header {
    margin-bottom: 2rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 1rem;
    flex-wrap: wrap;
  }

  .blog-header p {
    margin: 0;
    color: #666;
  }

  .blog-nav-links {
    display: flex;
    gap: 1rem;
  }

  .nav-link {
    display: inline-block;
    padding: 10px 16px;
    background: #0066cc;
    color: white;
    border-radius: 6px;
    text-decoration: none;
    font-weight: 500;
    white-space: nowrap;
    transition: background 0.2s;
  }

  .nav-link:hover {
    background: #0052a3;
  }

  .post-tags {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
    margin: 0.75rem 0;
  }

  .post-tag {
    display: inline-block;
    padding: 4px 12px;
    background: #f0f0f0;
    border-radius: 12px;
    text-decoration: none;
    font-size: 0.85rem;
    color: #333;
    transition: background 0.2s;
  }

  .post-tag:hover {
    background: #e0e0e0;
  }

  @media (max-width: 600px) {
    .blog-header {
      flex-direction: column;
      align-items: flex-start;
    }
    
    .blog-nav-links {
      width: 100%;
    }
  }
</style>
