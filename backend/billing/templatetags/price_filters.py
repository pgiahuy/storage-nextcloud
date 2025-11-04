# backend/billing/templatetags/price_filters.py
from django import template

register = template.Library()

@register.filter
def format_price(value):
    """
    Định dạng số tiền: 80 → 80.000đ
    """
    if value is None or value == 0:
        return "0đ"
    try:
        value = float(value) * 1000  # 80 → 80000
        value = int(round(value))
        return f"{value:,}".replace(",", ".") + "đ"
    except (ValueError, TypeError):
        return "0đ"