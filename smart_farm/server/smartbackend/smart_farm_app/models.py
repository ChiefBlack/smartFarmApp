from django.db import models
from django.contrib.auth.models import AbstractUser, Group, Permission
import random
import string

from django.contrib.auth.models import AbstractUser
from django.db import models

class CustomUser(AbstractUser):
    phone_number = models.CharField(max_length=15, unique=True)
    is_verified = models.BooleanField(default=False)

    # Override related_name to avoid clashes with default auth.User groups and permissions
    groups = models.ManyToManyField(
        Group,
        related_name='smart_farm_app_user_set',  # Custom related_name
        blank=True,
        help_text='The groups this user belongs to.',
        verbose_name='groups',
    )

    user_permissions = models.ManyToManyField(
        Permission,
        related_name='smart_farm_app_user_permissions',  # Custom related_name
        blank=True,
        help_text='Specific permissions for this user.',
        verbose_name='user permissions',
    )

    def __str__(self):
        return self.username

