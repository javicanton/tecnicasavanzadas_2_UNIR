# Materiales de la asignatura de Técnicas Avanzadas para el Análisis de Datos Cuantitativos II

Repositorio de materiales, ejercicios, etc. para la asignatura de Técnicas Avanzadas para el Análisis de Datos Cuantitativos, del Máster en Métodos y Técnicas de Investigación Social Aplicada de UNIR.

## Índice de contenidos

### 01 Introducción

- [Introducción a R](01%20Introducción/Introduccion.md)
  - [Script R](01%20Introducción/Introduccion.R)
- [Instalación de Swirl en Español](01%20Introducción/Instalacion%20swirl%20español.md)
  - [Script R](01%20Introducción/Instalacion%20swirl%20español.R)
- [Análisis de Datos con R](01%20Introducción/Analisis%20ejemplo.md)
  - [Script R](01%20Introducción/Analisis%20ejemplo.R)
- [El Datasaurus](01%20Introducción/Datasaurus.md)
  - [Script R](01%20Introducción/Datasaurus.R)

### 02 Modelización

- [Regresión Lineal Androides](02%20Modelización/Tema%203%20Regresion%20Lineal%20Androides.md)
  - [Script R](02%20Modelización/Tema%203%20Regresion%20Lineal%20Androides.R)
- [Regresión Lineal Bacterias](02%20Modelización/Tema%203%20Regresion%20Lineal%20Bacterias.md)
  - [Script R](02%20Modelización/Tema%203%20Regresion%20Lineal%20Bacterias.R)
- [Tyrell Corporation - Análisis de Eliminaciones](02%20Modelización/Tema%203%20Tyrell%20Corporation.md)
  - [Script R](02%20Modelización/Tema%203%20Tyrell%20Corporation.R)
  - [Script R Output](02%20Modelización/Tema%203%20Tyrell%20Corporation%20Output.R)
- [Spotifal - Análisis de Abandono de Usuarios](02%20Modelización/Spotifal_Informe.md)
  - [Script R](02%20Modelización/Spotifal.r)
  - Análisis completo de patrones de abandono usando modelos lineales, logísticos y redes neuronales

### Otros recursos

- [Enlaces Interesantes](enlaces_interesantes.md)

## Requisitos

### Sistema

- R instalado en el sistema
- Conexión a internet para instalar paquetes
- Git (opcional, para control de versiones)

### Paquetes R

#### Paquetes Básicos (necesarios)

```R
install.packages(c(
    "tidyverse",  # Conjunto de paquetes para análisis de datos
    "readr",      # Lectura eficiente de datos
    "ggplot2",    # Visualización de datos
    "dplyr",      # Manipulación de datos
    "stats"       # Funciones estadísticas básicas
))
```

#### Paquetes Recomendados (según necesidades)

```R
install.packages(c(
    "skimr",      # Resúmenes estadísticos
    "janitor",    # Limpieza de datos
    "ggthemes",   # Temas adicionales para ggplot
    "forcats",    # Manejo de factores
    "corrplot"    # Visualización de correlaciones
))
```

## Instalación

1. Clona este repositorio
2. Abre RStudio
3. Navega al directorio del repositorio
4. Ejecuta los scripts en orden

## Uso

Cada carpeta contiene:

- Un archivo Markdown con la documentación y explicaciones
- Un archivo R con el código ejecutable

Se recomienda:

1. Leer primero la documentación en Markdown
2. Revisar el código en el archivo R
3. Ejecutar el código y experimentar con él

## Contribuir

Las contribuciones son bienvenidas. Por favor:

1. Haz fork del repositorio
2. Crea una rama para tu feature
3. Haz commit de tus cambios
4. Push a la rama
5. Crea un Pull Request
