---
layout: archive
title: "The Recipes"
tags: [blog,recipes,cooking,food,vegetarian,vegan]
comments: false
toc: true
image:
  feature: recipe_1600x500.jpg
---
## Fuss-free food for one or two

All my recipes are for _full meals_ for two people. All recipes are my own creation unless credited.


<form style="margin:0px;margin-top:1.0em" action="{{ site.url }}/search.html" ><label id="tipue_search_label_inline" for="tipue_search_input_inline"><span class="quick-access">Search by ingredient:&nbsp;</span></label>
<input type="search" name="q" id="tipue_search_input_inline" autocomplete="off" required><div class="form-group"></div></form>
<!-- <p class="quick-access">Browse recipes:</p> -->
<p  style="margin:0px;" class="quick-access">Browse recipes:</p>
<ul class="quick-access">
<li>By category:&nbsp;
<a href="{{site.url}}/recipes/#quick">Quick</a>&nbsp;&bull;
<a href="{{site.url}}/recipes/#Japanese">Japanese</a>&nbsp;&bull;
<a href="{{site.url}}/recipes/#special">Festive special</a>
</li>
<li>By preparation time:&nbsp;
<!--<a href="{{site.url}}/times/#10-minutes">10 minutes</a>-->
<a href="{{site.url}}/times/#15-minutes">15 minutes</a>&nbsp;&bull;
<a href="{{site.url}}/times/#20-minutes">20 minutes</a>&nbsp;&bull;
<a href="{{site.url}}/times/#30-minutes">30 minutes</a>&nbsp;&bull;
<a href="{{site.url}}/times/#45-minutes">45 minutes</a>
</li>
<li>By calories per person:&nbsp;
<a href="{{site.url}}/calories/#400-600kcals"><img src="{{ site.url }}/images/battery_lvl_2.png" style="height:1.0em;">&nbsp;light</a>&nbsp;&bull;
<a href="{{site.url}}/calories/#600-800kcals"><img src="{{ site.url }}/images/battery_lvl_3.png" style="height:1.0em;">&nbsp;sustaining</a>&nbsp;&bull;
<a href="{{site.url}}/calories/#800-1000kcals"><img src="{{ site.url }}/images/battery_lvl_4.png" style="height:1.0em;">&nbsp;filling</a>
</li>
</ul>

<h3 id="quick">Quick recipes</h3>
<div class="tiles">
{% for post in site.categories.recipes %}
{% if post.subset == "quick-recipes" %}
{% include post-grid-recipes.html %}
{% endif %}

{% endfor %}
</div><!-- /.tiles -->

<div class="spacer"  style="float:left;width:100%;">
<h3 id="Japanese">Japanese recipes</h3>
</div>

<div class="tiles">
{% for post in site.categories.recipes %}
{% if post.subset == "japanese" %}
  {% include post-grid-recipes.html %}
{% endif %}
{% endfor %}
</div><!-- /.tiles -->

<div class="spacer"  style="float:left;width:100%;">
<h3 id="special">Festive special</h3>
</div>

<div class="tiles">
{% for post in site.categories.recipes %}
{% if post.subset == "special" %}
  {% include post-grid-recipes.html %}
{% endif %}
{% endfor %}
</div><!-- /.tiles -->
