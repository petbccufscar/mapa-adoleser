#isso eh  usado para calcular a media das notas
from django.db.models.signals import post_save, post_delete
from django.dispatch import receiver
from django.db.models import Avg

from .models import InstanceReview, ActivityReview, Instance, Activity


# função será chamada sempre que uma instanceReview for salva ou deletada
@receiver([post_save, post_delete], sender=InstanceReview)
def update_instance_rating(sender, instance, **kwargs):

    # Pega a 'instance' associada à avaliação que disparou o sinal
               #= review.instance
    current_instance = instance.instance

    # Calcula a média de todas as notas para essa instance.
    # O .aggregate() retorna um dicionário, como: {'nota__avg': 8.5}
    average = InstanceReview.objects.filter(instance=current_instance).aggregate(Avg('nota'))

    #Pega o valor da média do dicionário. Se não houver avaliações (retorna None),
    # usamos 0.0 como padrão.
    current_instance.nota = average['nota__avg'] if average['nota__avg'] is not None else 0.0
    current_instance.save()


# Esta função será chamada sempre que uma ActivityReview for salva ou deletada
@receiver([post_save, post_delete], sender=ActivityReview)
def update_activity_rating(sender, instance, **kwargs):
    activity = instance.activity
    average = ActivityReview.objects.filter(activity=activity).aggregate(Avg('nota'))
    activity.nota = average['nota__avg'] if average['nota__avg'] is not None else 0.0
    activity.save()