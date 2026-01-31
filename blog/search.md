---
layout: default
title: Blog Search
permalink: /blog/search/
---

<h1>Blog Search</h1>

<div id="search-form">
  <input type="text" id="search-input" placeholder="Search blog posts..." class="search-box">
  <div id="search-results"></div>
</div>

<script src="https://lunrjs.com/lunr.js"></script>
<script>
  // Load the search index
  let idx;
  let posts = [];

  fetch('/search.json')
    .then(response => response.json())
    .then(data => {
      posts = data;
      
      // Build the search index
      idx = lunr(function() {
        this.field('title', { boost: 10 });
        this.field('excerpt', { boost: 5 });
        this.field('tags');
        this.field('content');
        this.ref('id');
        
        data.forEach(post => {
          this.add(post);
        });
      });
      
      // Set up search event listener
      document.getElementById('search-input').addEventListener('keyup', performSearch);
    });

  function performSearch(e) {
    const query = e.target.value.trim();
    const resultsContainer = document.getElementById('search-results');
    
    if (query.length === 0) {
      resultsContainer.innerHTML = '';
      return;
    }
    
    const results = idx.search(query + '*');
    
    if (results.length === 0) {
      resultsContainer.innerHTML = '<p class="search-no-results">No posts found. Try different keywords.</p>';
      return;
    }
    
    let html = '<div class="search-results-list">';
    results.forEach(result => {
      const post = posts.find(p => p.id == result.ref);
      if (post) {
        html += `
          <article class="blog-post-preview">
            <h2><a href="${post.url}">${post.title}</a></h2>
            <p class="post-date">${post.date}</p>
            <p class="post-excerpt">${post.excerpt}</p>
            <a href="${post.url}" class="read-more">Read More →</a>
          </article>
        `;
      }
    });
    html += '</div>';
    
    resultsContainer.innerHTML = html;
  }
</script>

<style>
  #search-form {
    margin-bottom: 2rem;
  }
  
  .search-box {
    width: 100%;
    max-width: 500px;
    padding: 12px 16px;
    font-size: 16px;
    border: 2px solid #ddd;
    border-radius: 8px;
    font-family: inherit;
    transition: border-color 0.2s;
  }
  
  .search-box:focus {
    outline: none;
    border-color: #0066cc;
  }
  
  .search-results-list {
    margin-top: 2rem;
  }
  
  .search-no-results {
    color: #666;
    font-style: italic;
    padding: 1rem;
  }
</style>
