import random
import string
from datetime import datetime, timedelta
from django.core.mail import send_mail
from django.conf import settings
from django.utils import timezone

def generate_reset_code():
    #Gera um código de reset de 6 dígitos
    return ''.join(random.choices(string.digits, k=6))

def send_password_reset_email(user, reset_code):
    #Envia email com código de reset de senha
    subject = 'Recuperação de Senha - Mapa Adoleser'
    
    message = f"""
Olá {user.name or user.username},

Você solicitou a recuperação de sua senha no Mapa Adoleser.

Seu código de verificação é: {reset_code}

Este código é válido por 15 minutos.

Se você não solicitou a recuperação de senha, ignore este email.

Atenciosamente,
Equipe PET-BCC
    """
    
    html_message = f"""
    <html>
    <body>
        <h2>Recuperação de Senha - Mapa Adoleser</h2>
        
        <p>Olá <strong>{user.name or user.username}</strong>,</p>
        
        <p>Você solicitou a recuperação de sua senha no Mapa Adoleser.</p>
        
        <div style="background-color: #f0f0f0; padding: 20px; text-align: center; margin: 20px 0;">
            <h3>Seu código de verificação é:</h3>
            <h1 style="color: #007bff; font-size: 32px; letter-spacing: 5px;">{reset_code}</h1>
        </div>
        
        <p><strong>Este código é válido por 15 minutos.</strong></p>
        
        <p>Se você não solicitou a recuperação de senha, ignore este email.</p>
        
        <hr>
        <p><em>Atenciosamente,<br>Equipe PET-BCC</em></p>
    </body>
    </html>
    """
    
    try:
        send_mail(
            subject=subject,
            message=message,
            from_email=settings.DEFAULT_FROM_EMAIL,
            recipient_list=[user.email],
            html_message=html_message,
            fail_silently=False,
        )
        return True
    except Exception as e:
        print(f"Erro ao enviar email: {e}")
        return False

def set_password_reset_code(user):
    #Define um código de reset para o usuário com expiração de 15 minutos
    reset_code = generate_reset_code()
    user.password_reset_code = reset_code
    user.password_reset_code_expires_at = timezone.now() + timedelta(minutes=15)
    user.save()
    return reset_code

def is_reset_code_valid(user, code):
    #Verifica se o código de reset é válido e não expirouu
    return(
        user.password_reset_code == code and
        timezone.now() <= user.password_reset_code_expires_at
    )

def clear_reset_code(user):
    #Remove o código de reset do usuário
    user.password_reset_code = None
    user.password_reset_code_expires_at = None
    user.save()
