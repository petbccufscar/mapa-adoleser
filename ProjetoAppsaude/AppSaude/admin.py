


from django.contrib import admin
from .models import Usuario
from .models import ProfissionalSaude
from .models import LocalAtendimento
from .models import AvaliacaoLocal

# Register your models here.

admin.site.register(Usuario)
admin.site.register(ProfissionalSaude)
admin.site.register(LocalAtendimento)
admin.site.register(AvaliacaoLocal)