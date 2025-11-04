from rest_framework import serializers
from .models import Plans, Subscriptions, Payments, Invoices

class PlanSerializer(serializers.ModelSerializer):
    class Meta:
        model = Plans
        fields = '__all__'

class SubscriptionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Subscriptions
        fields = '__all__'

class PaymentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Payments
        fields = '__all__'

class InvoiceSerializer(serializers.ModelSerializer):
    class Meta:
        model = Invoices
        fields = '__all__'
