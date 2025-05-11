from django.contrib.auth.models import AbstractUser
from django.db import models

# Create your models here.
class Role(models.TextChoices):
    USER = 'USER', 'User'
    ADMIN = 'ADMIN', 'Admin'

class User(AbstractUser):
    # username, id, password, email são herdados de AbstractUser
    name = models.CharField("Full Name", max_length=255, blank=True)
    birth_date = models.DateField("Birth date", null=True, blank=True)
    #password_reset_code = models.CharField("Password Reset Code", max_length=10, blank=True, null=True)
    #password_reset_code_expires_at = models.DateTimeField("Password Reset Code Expiry", blank=True, null=True)
    role = models.CharField(
        "Role",
        max_length=10,
        choices=Role.choices,
        default=Role.USER
    )
    def __str__(self):
        return self.username
