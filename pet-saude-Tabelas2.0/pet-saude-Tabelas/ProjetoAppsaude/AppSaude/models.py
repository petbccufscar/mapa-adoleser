# Importa as classes e funcionalidades necessárias do Django
# para criar modelos de banco de dados
# e lidar com autenticação de usuários
from django.db import models
from django.contrib.auth.models import AbstractUser, Group, Permission
import re
from django.core.exceptions import ValidationError
from django.contrib.postgres.fields import ArrayField
from django.utils import timezone


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
    
    # Campo para locais favoritos
    locais_favoritos = models.ManyToManyField('LocalAtendimento', related_name='usuarios_favoritos', blank=True)
    
    #Cadastro de locais pelo usuário
    locais_cadastrados = models.ManyToManyField('LocalAtendimento', related_name='usuarios_cadastrados', blank=True)

    def __str__(self):
        return self.nome


class Imagem(models.Model):
    imagem = models.ImageField(upload_to='locais/')

    def __str__(self):
        return self.imagem.name
    

def validate_telefone(value):
    """
    Valida o formato do número de telefone.
    O número deve conter apenas dígitos e ter entre 8 e 20 caracteres.
    """
    telefone_pattern = re.compile(r'^\d{8,20}$')
    if not telefone_pattern.match(value):
        raise ValidationError('Número de telefone inválido. O número deve conter apenas dígitos e ter entre 8 e 20 caracteres.')


class Telefone(models.Model):
    numero = models.CharField(max_length=20)

    def clean(self):
        validate_telefone(self.numero)

    def __str__(self):
        return self.numero
#Clase endereço para local de atendimento
class Endereco(models.Model):
    rua = models.CharField(max_length=255)
    numero = models.CharField(max_length=20)
    cidade = models.CharField(max_length=100)
    estado = models.CharField(max_length=100)
    cep = models.CharField(max_length=10)

    def __str__(self):
        return f"{self.rua}, {self.numero}, {self.cidade}, {self.estado}, {self.cep}"
    
#def default_planos_saude():
    # Retorna uma lista de planos de saúde predefinidos
    #return ['Plano1', 'Plano2', 'Plano3']
# Define o modelo LocalAtendimento, que representa um local de atendimento.
class LocalAtendimento(models.Model):
    nome = models.CharField(max_length=255)
    latitude = models.DecimalField(max_digits=10, decimal_places=8)
    longitude = models.DecimalField(max_digits=11, decimal_places=8)
    # chave estrangeira que 
    endereco = models.OneToOneField(Endereco, on_delete=models.CASCADE)
    descricao = models.TextField()
    CATEGORIAS_CHOICES = (
        ('clinica', 'Clínica'),
        ('parque', 'Parque'),
        ('centro_apoio', 'Centro de Apoio'),
        # Adicione outras categorias conforme necessário
    )
    categoria = models.CharField(max_length=50, choices=CATEGORIAS_CHOICES)
    FAIXA_ETARIA_CHOICES = (
        ('criancas', 'Crianças'),
        ('adolescentes', 'Adolescentes'),
        ('adultos', 'Adultos'),
        ('idosos', 'Idosos'),
        # Adicione outras faixas etárias conforme necessário
    )
    faixa_etaria_recomendada = models.CharField(max_length=50, choices=FAIXA_ETARIA_CHOICES)
    SERVICOS_CHOICES = (
        ('psicoterapia', 'Psicoterapia'),
        ('grupos_apoio', 'Grupos de Apoio'),
        ('atividades_fisicas', 'Atividades Físicas'),
        # Adicione outros serviços conforme necessário
    )
    servicos_oferecidos = models.CharField(max_length=255, choices=SERVICOS_CHOICES)
    email = models.EmailField()
    telefones = models.ManyToManyField(Telefone, blank=True)
    site = models.URLField()
    imagens = models.ManyToManyField(Imagem, related_name='locais',blank=True)
    validado = models.BooleanField(default=True)
    valor_medio = models.DecimalField(max_digits=10, decimal_places=2, null=True, blank=True)
     # Adiciona um campo para armazenar os planos de saúde aceitos neste local
    planos_saude = models.TextField(blank=True)  # Campo para armazenar os planos de saúde como uma string separada
    
    def __str__(self):
        return self.nome
    

class HorarioFuncionamento(models.Model):
    DIA_CHOICES = (
        ('segunda', 'Segunda-feira'),
        ('terca', 'Terça-feira'),
        ('quarta', 'Quarta-feira'),
        ('quinta', 'Quinta-feira'),
        ('sexta', 'Sexta-feira'),
        ('sabado', 'Sábado'),
        ('domingo', 'Domingo'),
    )
    local = models.ForeignKey(LocalAtendimento, related_name='horarios_funcionamento', on_delete=models.CASCADE)
    dia_semana = models.CharField(max_length=10, choices=DIA_CHOICES)
    horario_abertura = models.TimeField()
    horario_fechamento = models.TimeField()

    #class Meta:
        # Garante que um mesmo local não pode ter dois horários diferentes para o mesmo dia
        #unique_together = ('local', 'dia_semana')

    def __str__(self):
        return f"{self.local.nome} - {self.dia_semana}"


# Define o modelo ProfissionalSaude, que representa um profissional de saúde.
# Ele possui um campo de chave estrangeira (ForeignKey) para LocalAtendimento,
# indicando que um profissional de saúde pode estar associado a um local de atendimento.
class ProfissionalSaude(models.Model):
    usuario = models.OneToOneField('Usuario', on_delete=models.CASCADE, primary_key=True, related_name='profissional_saude')
    local_atendimento = models.ForeignKey(LocalAtendimento, on_delete=models.CASCADE, null=True, blank=True)
    registro_profissional = models.CharField(max_length=128)

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
    
    def save(self, *args, **kwargs):
        if self.nota is None:
            raise ValidationError('Nota não pode ser nula')
        super().save(*args, **kwargs)


class ProblemaSite(models.Model):
    usuario = models.ForeignKey(Usuario, on_delete=models.CASCADE)
    descricao = models.TextField()
    data_criacao = models.DateTimeField(auto_now_add=True)
    resolvido = models.BooleanField(default=False)
    print = models.ImageField(upload_to='prints/')

    def __str__(self):
        return f"Problema no site relatado por {self.usuario.nome}"


class ProblemaLocalAtendimento(models.Model):
    usuario = models.ForeignKey(Usuario, on_delete=models.CASCADE)
    local_atendimento = models.ForeignKey(LocalAtendimento, on_delete=models.CASCADE)
    descricao = models.TextField()
    data_criacao = models.DateTimeField(auto_now_add=True)
    resolvido = models.BooleanField(default=False)

    def __str__(self):
        return f"Problema no local de atendimento {self.local_atendimento.nome} relatado por {self.usuario.nome}"
