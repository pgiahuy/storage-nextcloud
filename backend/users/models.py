from django.db import models
from django.conf import settings
from django.contrib.auth.models import AbstractUser
from billing.models import Subscriptions

class CustomUser(AbstractUser):
    full_name = models.CharField(max_length=150, blank=True, null=True)
    phone = models.CharField(max_length=20, blank=True, null=True)
    role = models.CharField(max_length=5, blank=True, null=True)
    used_storage = models.BigIntegerField(default=0)  # lưu lượng đã dùng (bytes)

    class Meta:
        db_table = 'users'

    @property
    def quota(self):
        """Quota dựa trên gói active"""
        active_sub = Subscriptions.objects.filter(user=self, status='active').first()
        if active_sub and active_sub.plan:
            return active_sub.plan.storage_limit
        return 1073741824  # fallback 1GB

    @property
    def remaining_storage(self):
        return max(self.quota - self.used_storage, 0)



class ActivityLogs(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.DO_NOTHING, blank=True, null=True)
    action = models.CharField(max_length=255, blank=True, null=True)
    ip_address = models.CharField(max_length=45, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    class Meta:
        db_table = 'activity_logs'
