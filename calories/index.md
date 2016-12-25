---
layout: default
---

{% assign sortedtags = "200-400kcals|400-600kcals|600-800kcals|800-1000kcals" | split:'|' %}

{% for tag in sortedtags %}
<h3 id="{{ tag }}">{{ tag }}</h3>
{% for post in site.posts %} 
{% if post.calorierange == tag %}
<a href="{{ site.url }}/{{ post.url }}"><img src="{{ site.url }}/images/{{ post.image.thumb }}" width="10%"></a>&nbsp;&nbsp;<a href="{{ site.url }}/{{ post.url }}">{{ post.title }}</a>
{% endif %}
{% endfor %} 
{% endfor %}


