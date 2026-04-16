from rest_framework import permissions

class IsAdminOrSuperOrReadOnly(permissions.BasePermission):
    """"
    permissoes referentes a criação de activities e locatino
    Permite leitura(GET) para todos
     POST apenas para ADMIN ou SUPER
    """

    message = "Apenas administradores podem realizar esta ação."

    def has_permission(self, request, view):
        #  Permite se for leitura (GET, HEAD, OPTONS)
        if request.method in permissions.SAFE_METHODS:
            return True

        #caso não seja safe method (POST, PUT, DELETE), verifica role
        return ( request.user.is_authenticated and
                request.user.role in ['ADMIN', 'SUPER'] )


class IsOwnerOrSuperOrReadOnly(permissions.BasePermission):
    """"
    permissoes referentes aa edicao de objs ja criados
    Todos podem Ler
    Apenas Dono do obj/SUPER editar ( PUT DELETE)
    """

    message = "Você não tem permissão para editar/apagar este item porque ele pertence a outro usuário."

    def has_object_permission(self, request, view, obj):
        #  leitura (GET)
        if request.method in permissions.SAFE_METHODS:
            return True

        # se for SUPER:
        if request.user.is_authenticated and request.user.role == 'SUPER':
            return True

        #verifica se o editor eh o criador do obj
        owner = None

        if hasattr(obj, 'created_by'):
            owner = obj.created_by
        elif hasattr(obj, 'user'):
            owner = obj.user

        return owner == request.user

