# Importa as classes e funcionalidades necessárias do Django
# para criar modelos de banco de dados
# e lidar com autenticação de usuários
from django.db import models
from django.contrib.auth.models import AbstractUser, Group, Permission



# Define o modelo Usuario, que herda de AbstractUser, fornecendo funcionalidades de usuário comuns
class Usuario(AbstractUser):
    # Adiciona campos específicos para o modelo Usuario
    nome = models.CharField(max_length=255)
    email = models.EmailField(unique=True)
    data_nascimento = models.DateField()

    # Adiciona campos de relacionamento muitos-para-muitos com os modelos Group e Permission,
    # permitindo que um usuário pertença a vários grupos e tenha várias permissões.
    groups = models.ManyToManyField(Group, related_name='usuario_groups', blank=True)
    user_permissions = models.ManyToManyField(Permission, related_name='usuario_user_permissions', blank=True)

    def __str__(self):
        return self.nome


# Define o modelo LocalAtendimento, que representa um local de atendimento.
# Ele tem campos para armazenar o nome, latitude e longitude do local.
class LocalAtendimento(models.Model):
    nome = models.CharField(max_length=255)
    latitude = models.DecimalField(max_digits=10, decimal_places=8)
    longitude = models.DecimalField(max_digits=11, decimal_places=8)

    def __str__(self):
        return self.nome


# Define o modelo ProfissionalSaude, que representa um profissional de saúde.
# Ele possui um campo de chave estrangeira (ForeignKey) para LocalAtendimento,
# indicando que um profissional de saúde pode estar associado a um local de atendimento.
class ProfissionalSaude(models.Model):
    local_atendimento = models.ForeignKey(LocalAtendimento, on_delete=models.CASCADE, null=True, blank=True)

    def __str__(self):
        # Retorna o nome do local de atendimento associado ao profissional de saúde
        return f'{self.local_atendimento.nome if self.local_atendimento else "Sem Local de Atendimento"}'


# Define o modelo AvaliacaoLocal, que representa uma avaliação de um local de atendimento feita por um usuário.
# Ele possui campos de chave estrangeira (ForeignKey) para os modelos Usuario e LocalAtendimento,
# além de um campo para armazenar a pontuação da avaliação.
class AvaliacaoLocal(models.Model):
    usuario = models.ForeignKey(Usuario, on_delete=models.CASCADE)
    local_atendimento = models.ForeignKey(LocalAtendimento, on_delete=models.CASCADE)
    pontuacao = models.IntegerField()

    def __str__(self):
        # Retorna uma representação em string da avaliação, incluindo o nome do usuário e do local de atendimento
        return f'{self.usuario.nome} - {self.local_atendimento.nome}'
