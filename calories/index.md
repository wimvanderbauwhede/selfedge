---
layout: default
---
{% capture tags %}
  {% for post in site.posts %}
      {{ post.calorierange  }}
  {% endfor %}
{% endcapture %}
{% assign sortedtags = tags | split:' ' | uniq | sort %}

{% for tag in sortedtags %}
<h3 id="{{ tag }}">{{ tag }}</h3>
{% for post in site.posts %} 
{% if post.calorierange == tag %}
<a href="{{ site.url }}/{{ post.url }}"><img src="{{ site.url }}/images/{{ post.image.thumb }}" width="10%"></a>&nbsp;&nbsp;<a href="{{ site.url }}/{{ post.url }}">{{ post.title }}</a>
{% endif %}
{% endfor %} 
{% endfor %}


