# Generated by Django 5.0.6 on 2024-07-10 20:13

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('restaurant', '0007_remove_menuitem_menu'),
    ]

    operations = [
        migrations.CreateModel(
            name='Menu',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=200)),
                ('restaurant_name', models.OneToOneField(default=None, on_delete=django.db.models.deletion.CASCADE, to='restaurant.restaurant')),
            ],
        ),
        migrations.AddField(
            model_name='menuitem',
            name='menu',
            field=models.ForeignKey(default=None, on_delete=django.db.models.deletion.CASCADE, to='restaurant.menu'),
        ),
    ]
