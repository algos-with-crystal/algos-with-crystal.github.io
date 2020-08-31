---
title: Easy
---
### Easy

{% for p in site.tags.easy %}
  [{{p.title}}]({{ p.url }})
{% endfor %}
