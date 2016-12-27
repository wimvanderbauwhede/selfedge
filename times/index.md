---
layout: default
---

{% assign numtags = "10|15|20|30|45" | split:'|' %}
{% assign sortedtags = "10 minutes|15 minutes|20 minutes|30 minutes|45 minutes" | split:'|' %}

{% for numtag in numtags %}
{% capture tag %}{{numtag}} minutes{% endcapture %}
{% capture idtag %}{{numtag}}-minutes{% endcapture %}
<h3 id="{{ idtag }}">{{ tag }}</h3>
{% for post in site.posts %}
{% if post.preptime == tag %}
<a href="{{ site.url }}/{{ post.url }}"><img src="{{ site.url }}/images/{{ post.image.thumb }}" width="10%"></a>&nbsp;&nbsp;<a href="{{ site.url }}/{{ post.url }}">{{ post.title }}</a>
{% endif %}
{% endfor %}
{% endfor %}
