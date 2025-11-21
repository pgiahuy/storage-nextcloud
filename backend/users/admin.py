from django.contrib import admin
from .models import CustomUser
from django.contrib.auth.admin import UserAdmin
from django.template.defaultfilters import filesizeformat

@admin.register(CustomUser)
class CustomUserAdmin(UserAdmin):
    list_display = (
        'id', 'username', 'email', 'full_name', 'role',
        'is_staff', 'is_active', 'used_storage_display'
    )
    list_filter = ('role', 'is_staff', 'is_active')
    search_fields = ('username', 'email', 'full_name')

    def used_storage_display(self, obj):
        return filesizeformat(obj.used_storage)

    used_storage_display.short_description = 'Used Storage'
