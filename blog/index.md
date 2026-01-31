---
layout: default
title: Blog
permalink: /blog/
---

<h1>Blog</h1>

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
