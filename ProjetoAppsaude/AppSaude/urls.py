
from django.urls import path
from . import views

#as rotas
urlpatterns = [
    path('usuarios/', views.lista_usuarios, name='lista_usuarios'),
    path('usuarios/<int:usuario_id>/', views.detalhes_usuario, name='detalhes_usuario'),
    path('locais_atendimento/', views.lista_locais_atendimento, name='lista_locais_atendimento'),
    path('locais_atendimento/<int:local_id>/', views.detalhes_local_atendimento, name='detalhes_local_atendimento'),
    path('locais_atendimento/<int:local_id>/avaliacoes/', views.avaliacoes_locais, name='avaliacoes_locais'),
]
