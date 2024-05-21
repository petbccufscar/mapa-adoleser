


from django.contrib import admin
from .models import Usuario, ProfissionalSaude, LocalAtendimento, AvaliacaoLocal, ProblemaLocalAtendimento, ProblemaSite

# Register your models here.

admin.site.register(Usuario)
admin.site.register(ProfissionalSaude)
admin.site.register(LocalAtendimento)
admin.site.register(AvaliacaoLocal)
admin.site.register(ProblemaSite)
admin.site.register(ProblemaLocalAtendimento)
