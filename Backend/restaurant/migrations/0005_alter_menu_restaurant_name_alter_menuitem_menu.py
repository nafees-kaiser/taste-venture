# Generated by Django 5.0.6 on 2024-07-10 20:03

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('restaurant', '0004_menuitem_menu_menu'),
    ]

    operations = [
        migrations.AlterField(
            model_name='menu',
            name='restaurant_name',
            field=models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to='restaurant.restaurant'),
        ),
        migrations.AlterField(
            model_name='menuitem',
            name='menu',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='restaurant.menu'),
        ),
    ]
