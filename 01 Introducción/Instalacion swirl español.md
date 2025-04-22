# Instalación de Swirl en Español

## Descripción

Este script automatiza la instalación y configuración de Swirl, una plataforma interactiva para aprender R, en español. Swirl es una herramienta educativa que permite aprender R directamente desde la consola de R.

## Requisitos Previos

Antes de comenzar, asegúrate de tener:

- R instalado en el sistema
- Conexión a internet
- Acceso a GitHub

## 1. Instalación de Paquetes Necesarios

Primero, necesitamos instalar y cargar los paquetes necesarios:

```R
# Instalación de paquetes necesarios
if (!require("devtools")) install.packages("devtools")
if (!require("bitops")) install.packages("bitops")
if (!require("RCurl")) install.packages("RCurl")
if (!require("stringi")) install.packages("stringi")
if (!require("httr")) install.packages("httr")
if (!require("swirl")) install.packages("swirl")

# Carga de las librerías
library(devtools)
library(bitops)
library(RCurl)
library(httr)
library(swirl)
```

## 2. Configuración de SSL

Para evitar problemas de conexión con GitHub, configuramos SSL:

```R
# Configuración de SSL para evitar problemas de verificación
set_config(config(ssl_verifypeer = 0L))
```

## 3. Instalación del Curso en Español

Ahora procedemos a instalar el curso en español:

```R
# Verificar si el curso ya está instalado y desinstalarlo si es necesario
if (file.exists("/opt/R/home/library/swirl/Courses/Programando_en_R")) {
  uninstall_course("Programando_en_R")
}

# Instalar el curso desde GitHub
install_course_github('josersosa','Programando_en_R')
```

## 4. Configuración del Idioma

Configuramos Swirl para que use el español:

```R
# Seleccionar el idioma español
select_language(language = "spanish")
```

## 5. Inicio de Swirl

Finalmente, iniciamos Swirl:

```R
# Iniciar Swirl
swirl()
```

## Uso de Swirl

Una vez iniciado Swirl:

1. Se te solicitará un nombre para identificarte
2. Selecciona el curso "Programando en R"
3. Sigue las instrucciones interactivas

## Notas Importantes

- Las primeras informaciones aparecerán en inglés (propias del paquete swirl)
- Una vez seleccionado el curso, todo el contenido estará en español
- Se puede pausar el curso en cualquier momento
- El progreso se guarda automáticamente

## Solución de Problemas

Si encuentras algún error:

1. Verifica tu conexión a internet
2. Asegúrate de tener permisos de escritura en el directorio de R
3. Intenta ejecutar R como administrador
4. Verifica que todos los paquetes se instalaron correctamente

## Recursos Adicionales

- [Documentación oficial de Swirl](https://swirlstats.com/)
- [Repositorio del curso en español](https://github.com/josersosa/Programando_en_R)
- [Foro de la comunidad de Swirl](https://swirlstats.com/forum/)
