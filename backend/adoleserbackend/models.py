from django.contrib.auth.models import AbstractUser
from django.db import models
from django.core.validators import MinValueValidator, MaxValueValidator
from django.utils import timezone
import uuid


# Create your models here.
class Role(models.TextChoices):
    USER = 'USER', 'User'
    ADMIN = 'ADMIN', 'Admin'


class User(AbstractUser):
    # username, id, password, email são herdados de AbstractUser
    name = models.CharField("Full Name", max_length=255, blank=True)
    birth_date = models.DateField("Birth date", null=True, blank=True)
    password_reset_code = models.CharField("Password Reset Code", max_length=6, blank=True, null=True)
    password_reset_code_expires_at = models.DateTimeField("Password Reset Code Expiry", blank=True, null=True)

    role = models.CharField(
        "Role",
        max_length=10,
        choices=Role.choices,
        default=Role.USER
    )

    def __str__(self):
        return self.username


class Location(models.Model):
    id = models.UUIDField(primary_key=True,
        default=uuid.uuid4, editable=False)
    name = models.CharField(max_length=255)
    description = models.TextField(max_length=1023)
    nota = models.IntegerField(validators=[
        MinValueValidator(0), MaxValueValidator(10)], default=5)

    def __str__(self):
        return self.name

class Activity(models.Model):
    id = models.UUIDField(primary_key=True,
        default=uuid.uuid4, editable=False)
    name = models.CharField(max_length=255)
    description = models.TextField(max_length=1023)
    nota = models.IntegerField(validators=[
        MinValueValidator(0), MaxValueValidator(10)], default=5)
    location = models.ForeignKey(Location, on_delete=models.CASCADE)
    horario = models.DateTimeField("Start Time", default=timezone.now)

    def __str__(self):
        return self.name

# classe abstrata
class Review(models.Model):
    id = models.UUIDField(primary_key=True,
        default=uuid.uuid4, editable=False)
    name = models.CharField(max_length=255)
    description = models.TextField(max_length=1023)
    nota = models.IntegerField(validators=[
        MinValueValidator(0), MaxValueValidator(10)], default=5)
    user = models.ForeignKey(User, on_delete=models.CASCADE)

    class Meta:
        abstract = True
    def __str__(self):
        return f"{self.name} {self.nota}"


class LocationReview(Review):  # Herda da classe abstrata Review
    location = models.ForeignKey(Location, on_delete=models.CASCADE)

# descomentar quando model activity for implementado
class ActivityReview(Review):  # Herda da classe abstrata Review
    activity = models.ForeignKey(Activity, on_delete=models.CASCADE)
