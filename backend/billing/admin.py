from django.contrib import admin
from .models import Plans, Subscriptions, Payments, Invoices

@admin.register(Plans)
class PlansAdmin(admin.ModelAdmin):
    list_display = ('id', 'name', 'price', 'duration_days')
    search_fields = ('name',)

@admin.register(Subscriptions)
class SubscriptionsAdmin(admin.ModelAdmin):
    list_display = ('id', 'user', 'plan', 'status', 'start_date', 'end_date')
    list_filter = ('status', 'plan')
    search_fields = ('user__username', 'plan__name')

@admin.register(Payments)
class PaymentsAdmin(admin.ModelAdmin):
    list_display = ('id', 'user', 'plan', 'amount', 'method', 'status', 'transaction_id', 'created_at')
    list_filter = ('status', 'method')
    search_fields = ('user__username', 'transaction_id')

@admin.register(Invoices)
class InvoicesAdmin(admin.ModelAdmin):
    list_display = ('id', 'payment', 'invoice_number', 'status', 'issue_date', 'due_date')
    list_filter = ('status',)
    search_fields = ('invoice_number', 'payment__transaction_id')
