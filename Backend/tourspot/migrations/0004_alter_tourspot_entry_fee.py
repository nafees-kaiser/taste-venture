# Generated by Django 5.0.6 on 2024-07-17 10:31

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('tourspot', '0003_alter_tourspot_entry_fee'),
    ]

    operations = [
        migrations.AlterField(
            model_name='tourspot',
            name='entry_fee',
            field=models.IntegerField(),
        ),
    ]