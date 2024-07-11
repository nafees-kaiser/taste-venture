# Generated by Django 5.0.6 on 2024-07-10 19:54

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Tourspot',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=200)),
                ('manager_name', models.CharField(max_length=200)),
                ('contact', models.CharField(max_length=200, unique=True)),
                ('email', models.EmailField(max_length=254, unique=True)),
                ('opening_time', models.CharField(max_length=70)),
                ('closing_time', models.CharField(max_length=70)),
                ('description', models.TextField()),
                ('address', models.CharField(max_length=200)),
                ('password', models.CharField(max_length=200)),
                ('entry_fee', models.CharField(max_length=50)),
                ('wifi', models.CharField(max_length=50)),
                ('parking', models.CharField(max_length=50)),
                ('food', models.CharField(max_length=50)),
                ('pool', models.CharField(max_length=50)),
                ('other_services', models.TextField()),
            ],
        ),
    ]
