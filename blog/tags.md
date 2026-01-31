---
layout: default
title: Blog Tags
permalink: /blog/tags/
---

<h1>Blog Tags</h1>

<p>Browse articles by topic:</p>

<div class="tags-cloud">
  {% assign tags = site.posts | map: 'tags' | join: ','  | split: ',' | uniq | sort %}
  {% for tag in tags %}
    {% assign count = site.posts | where_exp: "post", "post.tags contains tag" | size %}
    <a href="/blog/tags/{{ tag | downcase | replace: ' ', '-' | replace: '/', '-' }}/" class="tag-link" data-count="{{ count }}">
      {{ tag }} <span class="tag-count">({{ count }})</span>
    </a>
  {% endfor %}
</div>

<style>
  .tags-cloud {
    display: flex;
    flex-wrap: wrap;
    gap: 1rem;
    margin-top: 2rem;
  }

  .tag-link {
    display: inline-block;
    padding: 10px 16px;
    background: #f0f0f0;
    border: 1px solid #ddd;
    border-radius: 20px;
    text-decoration: none;
    font-size: 0.95rem;
    transition: all 0.2s;
    color: #333;
  }

  .tag-link:hover {
    background: #0066cc;
    color: white;
    border-color: #0066cc;
  }

  .tag-count {
    font-size: 0.85em;
    opacity: 0.7;
  }

  .tag-link:hover .tag-count {
    opacity: 1;
  }
</style>
