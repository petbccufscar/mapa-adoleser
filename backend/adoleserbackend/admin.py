from django.contrib import admin
from django.contrib.auth.admin import UserAdmin

from .models import User
# Register your models here.
class CustomUserAdmin(UserAdmin):
    # Add your custom fields to fieldsets or list_display
    fieldsets = UserAdmin.fieldsets + (
        (None, {'fields': ('name', 'birth_date', 'role')}),
    )
    add_fieldsets = UserAdmin.add_fieldsets + (
        (None, {'fields': ('name', 'birth_date', 'role')}),
    )
    list_display = ('username', 'email', 'name', 'role')

    list_filter = UserAdmin.list_filter + ('role',)


admin.site.register(User, CustomUserAdmin)