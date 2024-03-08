from django.shortcuts import render, get_object_or_404
from .models import Usuario, LocalAtendimento, AvaliacaoLocal

# Função para listar todos os usuários
def lista_usuarios(request):
    # Obtém todos os objetos do modelo Usuario do banco de dados
    usuarios = Usuario.objects.all()
    # Renderiza a página HTML 'lista_usuarios.html' e passa o conjunto de usuários para a página
    return render(request, 'lista_usuarios.html', {'usuarios': usuarios})

# Função para exibir detalhes de um usuário específico
def detalhes_usuario(request, usuario_id):
    # Obtém o objeto Usuario com o ID fornecido, ou retorna uma página de erro 404 se não existir
    usuario = get_object_or_404(Usuario, pk=usuario_id)
    # Renderiza a página HTML 'detalhes_usuario.html' e passa o objeto de usuário para a página
    return render(request, 'detalhes_usuario.html', {'usuario': usuario})

# Função para listar todos os locais de atendimento
def lista_locais_atendimento(request):
    # Obtém todos os objetos do modelo LocalAtendimento do banco de dados
    locais_atendimento = LocalAtendimento.objects.all()
    # Renderiza a página HTML 'lista_locais_atendimento.html' e passa o conjunto de locais de atendimento para a página
    return render(request, 'lista_locais_atendimento.html', {'locais_atendimento': locais_atendimento})

# Função para exibir detalhes de um local de atendimento específico
def detalhes_local_atendimento(request, local_id):
    # Obtém o objeto LocalAtendimento com o ID fornecido, ou retorna uma página de erro 404 se não existir
    local = get_object_or_404(LocalAtendimento, pk=local_id)
    # Renderiza a página HTML 'detalhes_local_atendimento.html' e passa o objeto de local de atendimento para a página
    return render(request, 'detalhes_local_atendimento.html', {'local': local})

# Função para listar todas as avaliações de um local de atendimento
def avaliacoes_locais(request, local_id):
    # Obtém o objeto LocalAtendimento com o ID fornecido, ou retorna uma página de erro 404 se não existir
    local = get_object_or_404(LocalAtendimento, pk=local_id)
    # Filtra todas as avaliações relacionadas a esse local de atendimento
    avaliacoes = AvaliacaoLocal.objects.filter(local_atendimento=local)
    # Renderiza a página HTML 'avaliacoes_locais.html' e passa o objeto de local de atendimento e a lista de avaliações relacionadas para a página
    return render(request, 'avaliacoes_locais.html', {'local': local, 'avaliacoes': avaliacoes})
