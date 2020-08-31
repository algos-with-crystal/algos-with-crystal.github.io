---
title: Algos-with-crystal
description: Learning algorithms using crystal language
---

{% for tag in site.tags %}
    <h3>{{ tag[0] }}</h3>
    <ul>
        {% for post in tag[1] %}
        <li><a href="{{ post.url }}">{{ post.title }}</a></li>
        {% endfor %}
    </ul>
{% endfor %}