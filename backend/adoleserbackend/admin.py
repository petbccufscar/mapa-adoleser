from django.contrib import admin
from django.contrib.auth.admin import UserAdmin

from .models import User, Location, Activity, LocationReview, ActivityReview
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


@admin.register(Location)
class LocationAdmin(admin.ModelAdmin):

    list_display = ('name', 'nota',)
    readonly_fields = ('nota', 'created_by')
    search_fields = ('name', 'description')

    # método que salva o usuário que criou a activity
    def save_model(self, request, obj, form, change):
        if not change:
            obj.created_by = request.user
        super().save_model(request, obj, form, change)

@admin.register(Activity)

class ActivityAdmin(admin.ModelAdmin):

    list_display = ('name', 'location', 'nota')
    readonly_fields = ('nota', 'created_by')
    search_fields = ('name', 'description')
    list_filter = ('location',)

    #método que salva o usuário que criou a activity
    def save_model(self, request, obj, form, change):
        if not change:
            obj.created_by = request.user
        super().save_model(request, obj, form, change)




@admin.register(LocationReview)
class LocationReviewAdmin(admin.ModelAdmin):

    list_display = ('name', 'location', 'user', 'nota')
    list_filter = ('nota', 'user', 'location')
    search_fields = ('name', 'description')

@admin.register(ActivityReview)
class ActivityReviewAdmin(admin.ModelAdmin):

    list_display = ('name', 'activity', 'user', 'nota')
    list_filter = ('nota', 'user', 'activity')
    search_fields = ('name', 'description')