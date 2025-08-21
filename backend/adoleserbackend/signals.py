#isso eh  usado para calcular a media das notas
from django.db.models.signals import post_save, post_delete
from django.dispatch import receiver
from django.db.models import Avg

from .models import LocationReview, ActivityReview, Location, Activity


# função será chamada sempre que uma LocationReview for salva ou deletada
@receiver([post_save, post_delete], sender=LocationReview)
def update_location_rating(sender, instance, **kwargs):

    # Pega a 'location' associada à avaliação que disparou o sinal
    location = instance.location

    # Calcula a média de todas as notas para essa location.
    # O .aggregate() retorna um dicionário, como: {'nota__avg': 8.5}
    average = LocationReview.objects.filter(location=location).aggregate(Avg('nota'))

    #Pega o valor da média do dicionário. Se não houver avaliações (retorna None),
    # usamos 0.0 como padrão.
    location.nota = average['nota__avg'] if average['nota__avg'] is not None else 0.0
    location.save()


# Esta função será chamada sempre que uma ActivityReview for salva ou deletada
@receiver([post_save, post_delete], sender=ActivityReview)
def update_activity_rating(sender, instance, **kwargs):
    activity = instance.activity
    average = ActivityReview.objects.filter(activity=activity).aggregate(Avg('nota'))
    activity.nota = average['nota__avg'] if average['nota__avg'] is not None else 0.0
    activity.save()