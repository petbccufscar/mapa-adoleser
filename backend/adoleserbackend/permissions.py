from rest_framework.persmissions import BasePermission, SAFE_METHODS
from .models import Role

class IsSuper(BasePermission):
    def has_permission(self, request, view):
        return request.user.is_authenticated and request.user.role == Role.SUPER

    def has_object_permission(self, request, view, obj):
        return self.has_permission(request, view)
    
class IsOwnerReviewOrReadOnly(BasePermission):
    #USER/ADMIN podem alterar/excluir própria review
    def has_object_permission(self, request, view, obj):
        if not request.user.is_authenticated:
            return False

        if request.user.role == Role.SUPER:
            return True

        if request.method in SAFE_METHODS:
            return True

        return obj.user == request.user 
    
class IsOwnerLocationOrReadOnly (BasePermission):
    #ADMIN pode alterar/excluir sua própria location
    def has_object_permission(self, request, view, obj):
        if not request.user.is_authenticated:
            return False
        
        if request.user.role == Role.SUPER:
            return True
        
        if request.method in SAFE_METHODS:
            return True
        
        if request.user.role == Role.ADMIN:
            return obj.created_by == request.user
        
        return False
