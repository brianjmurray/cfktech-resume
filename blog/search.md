---
layout: default
title: Blog Search
permalink: /blog/search/
---

<h1>Blog Search</h1>

<div id="search-container">
  <input type="text" id="search-input" placeholder="Search posts by title or content..." class="search-box" autofocus>
  <div id="search-results"></div>
</div>

<script>
  const postsData = [];
  
  // Load posts
  fetch('/search.json')
    .then(response => response.json())
    .then(data => {
      postsData.push(...data);
      setupSearch();
    });

  function setupSearch() {
    const searchInput = document.getElementById('search-input');
    searchInput.addEventListener('keyup', performSearch);
  }

  function performSearch(e) {
    const query = e.target.value.toLowerCase().trim();
    const resultsContainer = document.getElementById('search-results');
    
    if (query.length === 0) {
      resultsContainer.innerHTML = '';
      return;
    }

    const results = postsData.filter(post => {
      const titleMatch = post.title.toLowerCase().includes(query);
      const excerptMatch = post.excerpt.toLowerCase().includes(query);
      const contentMatch = post.content.toLowerCase().includes(query);
      return titleMatch || excerptMatch || contentMatch;
    });

    if (results.length === 0) {
      resultsContainer.innerHTML = '<p class="no-results">No posts found matching your search.</p>';
      return;
    }

    let html = '<div class="search-results">';
    results.forEach(post => {
      html += `
        <article class="blog-post-preview">
          <h2><a href="${post.url}">${highlightQuery(post.title, query)}</a></h2>
          <p class="post-date">${post.date}</p>
          <p class="post-excerpt">${highlightQuery(post.excerpt, query)}</p>
          <a href="${post.url}" class="read-more">Read More →</a>
        </article>
      `;
    });
    html += '</div>';
    
    resultsContainer.innerHTML = html;
  }

  function highlightQuery(text, query) {
    const regex = new RegExp(`(${query})`, 'gi');
    return text.replace(regex, '<mark>$1</mark>');
  }
</script>

<style>
  #search-container {
    margin-bottom: 2rem;
  }

  .search-box {
    width: 100%;
    max-width: 600px;
    padding: 12px 16px;
    font-size: 16px;
    border: 2px solid #ddd;
    border-radius: 8px;
    font-family: inherit;
    transition: border-color 0.2s;
    margin-bottom: 2rem;
  }

  .search-box:focus {
    outline: none;
    border-color: #0066cc;
  }

  .search-results {
    display: flex;
    flex-direction: column;
    gap: 1.5rem;
  }

  .no-results {
    color: #666;
    font-style: italic;
    padding: 1rem;
  }

  mark {
    background: #fff3cd;
    padding: 2px 4px;
    border-radius: 2px;
    font-weight: 600;
  }
</style>
