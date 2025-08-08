from django.apps import AppConfig


class AdoleserbackendConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'adoleserbackend'

    def ready(self):
        from . import signals