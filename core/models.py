import short_url

from django.db import models
from django.db.models.signals import post_save

from model_utils.models import TimeStampedModel


class ShortenUrl(TimeStampedModel):
    original_url = models.TextField()
    shorten_url = models.CharField(max_length=100)
