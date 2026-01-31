---
layout: default
title: Blog
permalink: /blog/
---

<h1>Blog</h1>

<div class="blog-header">
  <p>Explore articles on data engineering, DevOps, and portfolio development.</p>
  <a href="/blog/search/" class="search-link">🔍 Search Posts</a>
</div>

<div class="blog-posts">
  {% for post in site.posts %}
    <article class="blog-post-preview">
      <h2><a href="{{ post.url }}">{{ post.title }}</a></h2>
      <p class="post-date">{{ post.date | date: "%B %d, %Y" }}</p>
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
  }

  .blog-header p {
    margin: 0;
    color: #666;
  }

  .search-link {
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

  .search-link:hover {
    background: #0052a3;
  }

  @media (max-width: 600px) {
    .blog-header {
      flex-direction: column;
      align-items: flex-start;
    }
  }
</style>
