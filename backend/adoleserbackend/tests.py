from django.test import TestCase
from django.urls import reverse
from rest_framework.test import APIClient
from rest_framework import status
from .models import User, Activity, Instance, Address, Category
from django.utils import timezone
import datetime

# Create your tests here.

# AUTENTICAÇÃO USUARIO
class UserLoginTest(TestCase):
    # CRIA USUARIO NO BANCO DE TESTES
    def setUp(self):
        self.user = User.objects.create_user(
            username= "teste",
            email = "teste@gmail.com",
            password = "12345678A@"
        )

    # REQUISIÇÃO DO USUARIO
    def test_login_success(self):
        url = reverse("token_obtain_pair")
        response = self.client.post(url, {
            "username": "teste",
            "password": "12345678A@"
        })

        # VERIFICA STATUS E TOKENS
        self.assertEqual(response.status_code, 200) 
        self.assertIn("access", response.data) 
        self.assertIn("refresh", response.data)
        self.assertIn("user", response.data)
    
    # VERIFICA SENHA ERRADA
    def test_wrong_password(self):
        url = reverse("token_obtain_pair")
        response = self.client.post(url, {
            "username": "teste",
            "password": "errada",
        })
        # BLOQUEIO DO LOGIN
        self.assertEqual(response.status_code, 401)
    
    # VERIFICA USUARIO INEXISTENTE
    def test_noexistent_user(self):
        url = reverse("token_obtain_pair")
        response = self.client.post(url, {
            "username": "usuario_inexistente",
            "password": "qualquer_senha"
        })

        self.assertEqual(response.status_code, 401)

# TELA CADASTRO E PERFIL
class UserAccountTest(TestCase):
    def setUp(self):
        self.client = APIClient()

    # CRIA USUARIO
    def test_registration_sucess(self):
        self.assertEqual(User.objects.count(), 0)

        url = reverse("user_register")
        data = {
            "username": "teste",
            "email": "teste@gmail.com",
            "password": "12345678A@",
            "password2": "12345678A@",
            "name": "test",
            "birth_date": "2000-02-02"
        }

        response = self.client.post(url, data, format='json')

        self.assertEqual(response.status_code, 201)
        self.assertEqual(User.objects.count(), 1)
        # VERIFICA DADOS 
        user = User.objects.get(username="teste")
        self.assertEqual(user.email, "teste@gmail.com")
        
    # ERRO CASO SENHAS NÃO COINCIDAM
    def test_registration_fails_if_passwords_mismatch(self):
        url = reverse("user_register")
        data = {
            "username": "teste",
            "email": "teste@gmail.com",
            "password": "12345678A@",
            "password2": "SENHA_INCORRETA",
        }

        response = self.client.post(url, data, format='json')

        self.assertEqual(response.status_code, 400)
        self.assertEqual(User.objects.count(), 0)
    
    # TESTE PERFIL AUTENTICADO
    def test_user_authenticated_user_can_view_profile(self):
        # USUARIO DE TESTE
        user = User.objects.create_user(username='logado', password='@A87654321')
        # FORÇA AUTENTICAÇÃO
        self.client.force_authenticate(user=user)
        # REQUISIÇÃO
        url = reverse("user_profile")
        response = self.client.get(url)
        # VERIFICA
        self.assertEqual(response.status_code, 200)

    # TESTE PERFIL NAO AUTENTICADO
    def test_user_profile_view_requires_auth(self):
        url = reverse("user_profile")
        response = self.client.get(url)

        self.assertEqual(response.status_code, 401)

class ActivityFilterTest(TestCase):
    def setUp(self):
        self.client = APIClient()
        self.user = User.objects.create_user(username="testuser", password="123")
        
        # Addresses
        self.addr1 = Address.objects.create(cep="13560-000", street="Street A", number="10")
        self.addr2 = Address.objects.create(cep="13560-111", street="Street B", number="20")
        
        # Instances
        self.inst1 = Instance.objects.create(name="Inst 1", address=self.addr1, latitude=10.0, longitude=20.0, created_by=self.user)
        self.inst2 = Instance.objects.create(name="Inst 2", address=self.addr2, latitude=30.0, longitude=40.0, created_by=self.user)
        
        # Categories
        self.cat1 = Category.objects.create(name="Esporte")
        self.cat2 = Category.objects.create(name="Musica")
        
        # Activities
        morning_time = timezone.make_aware(datetime.datetime(2023, 1, 1, 9, 0))
        evening_time = timezone.make_aware(datetime.datetime(2023, 1, 1, 19, 0))
        
        self.act1 = Activity.objects.create(
            name="Futebol", description="Jogar bola", instance=self.inst1,
            horario=morning_time, target_age=15, created_by=self.user
        )
        self.act1.categories.add(self.cat1)
        
        self.act2 = Activity.objects.create(
            name="Aula de violao", description="Aprender musica", instance=self.inst2,
            horario=evening_time, target_age=18, created_by=self.user
        )
        self.act2.categories.add(self.cat2)

    def test_activity_list_serializer_fields(self):
        url = reverse('activity-list')
        response = self.client.get(url)
        self.assertEqual(response.status_code, 200)
        data = response.data
        self.assertEqual(len(data), 2)
        # Check serializers
        act1_data = next(item for item in data if item["name"] == "Futebol")
        self.assertEqual(float(act1_data["latitude"]), 10.0)
        self.assertEqual(float(act1_data["longitude"]), 20.0)
        self.assertEqual(act1_data["instance_address"], "Street A, 10 - 13560-000")
        self.assertEqual(act1_data["target_age"], 15)

    def test_filter_by_search(self):
        url = reverse('activity-list')
        response = self.client.get(url, {'search': 'bola'})
        self.assertEqual(len(response.data), 1)
        self.assertEqual(response.data[0]["name"], "Futebol")

    def test_filter_by_target_age(self):
        url = reverse('activity-list')
        response = self.client.get(url, {'target_age': '18'})
        self.assertEqual(len(response.data), 1)
        self.assertEqual(response.data[0]["name"], "Aula de violao")

    def test_filter_by_cep(self):
        url = reverse('activity-list')
        response = self.client.get(url, {'cep': '13560-000'})
        self.assertEqual(len(response.data), 1)
        self.assertEqual(response.data[0]["instance_name"], "Inst 1")

    def test_filter_by_category(self):
        url = reverse('activity-list')
        response = self.client.get(url, {'category': 'esporte'})
        self.assertEqual(len(response.data), 1)
        self.assertEqual(response.data[0]["name"], "Futebol")

    def test_filter_by_period(self):
        url = reverse('activity-list')
        response_manha = self.client.get(url, {'period': 'manha'})
        self.assertEqual(len(response_manha.data), 1)
        self.assertEqual(response_manha.data[0]["name"], "Futebol")

        response_noite = self.client.get(url, {'period': 'noite'})
        self.assertEqual(len(response_noite.data), 1)
        self.assertEqual(response_noite.data[0]["name"], "Aula de violao")