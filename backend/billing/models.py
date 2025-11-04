from django.db import models
from django.conf import settings


class Plans(models.Model):
    name = models.CharField(max_length=100)
    description = models.TextField(blank=True, null=True)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    storage_limit = models.BigIntegerField()
    duration_days = models.IntegerField()
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'plans'


class Payments(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.DO_NOTHING)
    plan = models.ForeignKey(Plans, on_delete=models.DO_NOTHING, null=True, blank=True)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    method = models.CharField(max_length=20, blank=True, null=True)
    status = models.CharField(max_length=20, blank=True, null=True)
    transaction_id = models.CharField(max_length=100, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'payments'

class Invoices(models.Model):
    payment = models.ForeignKey(Payments, on_delete=models.DO_NOTHING)
    invoice_number = models.CharField(unique=True, max_length=50)
    issue_date = models.DateField()
    due_date = models.DateField(blank=True, null=True)
    total = models.DecimalField(max_digits=10, decimal_places=2)
    status = models.CharField(max_length=20, blank=True, null=True)

    class Meta:
        db_table = 'invoices'


class Subscriptions(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.DO_NOTHING)
    plan = models.ForeignKey(Plans, on_delete=models.DO_NOTHING)
    start_date = models.DateField()
    end_date = models.DateField()
    status = models.CharField(max_length=20, blank=True, null=True)

    class Meta:
        db_table = 'subscriptions'
