# billing/templatetags/custom_filters.py
from django import template

register = template.Library()

@register.filter
def percentage(used, total):
    try:
        return round((used / total) * 100, 2)
    except:
        return 0
