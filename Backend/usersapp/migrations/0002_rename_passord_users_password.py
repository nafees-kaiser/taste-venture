# Generated by Django 5.0.6 on 2024-07-03 19:41

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('usersapp', '0001_initial'),
    ]

    operations = [
        migrations.RenameField(
            model_name='users',
            old_name='passord',
            new_name='password',
        ),
    ]
