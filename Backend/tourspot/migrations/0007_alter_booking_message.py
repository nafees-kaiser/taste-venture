# Generated by Django 5.0.6 on 2024-07-17 11:28

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('tourspot', '0006_booking_subtotal'),
    ]

    operations = [
        migrations.AlterField(
            model_name='booking',
            name='message',
            field=models.TextField(blank=True, null=True),
        ),
    ]