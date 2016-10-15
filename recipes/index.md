---
layout: archive
title: "The Recipes"
tags: [blog,recipes,cooking,food,vegetarian,vegan]
excerpt: "Fuss-free food for one or two"
comments: false
toc: true
image:
  feature: recipe_1600x500.jpg
---

All my recipes are for _full meals_ for two people. All recipes are my own creation unless credited.

<form  action="{{ site.url }}/search.html" ><label id="tipue_search_label_inline" for="tipue_search_input_inline">Search by ingredient:&nbsp;</label>
<input type="search" name="q" id="tipue_search_input_inline" autocomplete="off" required><div class="form-group"></div></form>

### Quick recipes

<div class="tiles">
{% for post in site.categories.recipes %}
{% if post.subset == "quick-recipes" %}
{% include post-grid.html %}
{% endif %}

{% endfor %}
</div><!-- /.tiles -->

<div class="spacer"  style="float:left;width:100%;">
<h3>Japanese recipes</h3>
</div>

<div class="tiles">
{% for post in site.categories.recipes %}
{% if post.subset == "japanese" %}
  {% include post-grid.html %}
{% endif %}
{% endfor %}
</div><!-- /.tiles -->
