from django.test import TestCase
from django.urls import reverse
from rest_framework import status
from .models import User

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
        self.assertIn("acess", response.data) 
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
    # CRIA USUARIO
    def test_registration_sucess(self):
        self.assertEqual(User.objects.count(), 0)

        url = reverse("user-register")
        data = {
            "username": "teste",
            "email": "teste@gmail.com",
            "password": "12345678A@",
            "password2": "12345678A@",
            "nome": "test",
            "data_aniversario": "2000-02-02"
        }

        response = self.client.post(url, data, format='json')

        self.assertEqual(response.status_code, 201)
        self.assertEqual(User.objects.count(), 1)
        # VERIFICA DADOS 
        user = User.objects.get(username="teste")
        self.assertEqual(user.email, "teste@gmail.com")
        
    # ERRO CASO SENHAS NÃO COINCIDAM
    def test_registration_fails_if_passwords_mismatch(self):
        url = reverse("user-register")
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
        url = reverse("user-profile")
        response = self.client.get(url)
        # VERIFICA
        self.assertEqual(response.status_code, 200)

    # TESTE PERFIL NAO AUTENTICADO
    def test_user_profile_view_requires_auth(self):
        url = reverse("user-profile")
        response = self.client.get(url)

        self.assertEqual(response.status_code, 401)