# Técnicas Avanzadas para el Análisis de Datos Cuantitativos II

Repositorio de materiales para la asignatura de Técnicas Avanzadas para el Análisis de Datos Cuantitativos, del Máster en Métodos y Técnicas de Investigación Social Aplicada de UNIR.

## Contenidos

### 01 Introducción

- [Introducción a R](01%20Introducción/Introduccion.md)
- [Instalación de Swirl en Español](01%20Introducción/Instalacion%20swirl%20español.md)
- [Análisis de Datos con R](01%20Introducción/Analisis%20ejemplo.md)
- [El Datasaurus](01%20Introducción/Datasaurus.md)

### 02 Modelización

#### Análisis de Streaming

- [Spotifal - Análisis de Abandono de Usuarios](02%20Modelización/Analisis_Spotifal/Spotifal_Informe.md)
  - Análisis de patrones de abandono usando modelos lineales, logísticos y redes neuronales

#### Regresión Lineal

- [Regresión Lineal Androides](02%20Modelización/Regresion_Lineal/Androides/RegresionLineal_Androides.md)
- [Regresión Lineal Bacterias](02%20Modelización/Regresion_Lineal/Bacterias/RegresionLineal_Bacterias.md)

#### Análisis Corporativo

- [Tyrell Corporation - Análisis de Eliminaciones](02%20Modelización/Analisis_Tyrell_Corp/TyrellCorporation.md)

### Recursos Adicionales

- [Enlaces Interesantes](enlaces_interesantes.md)

## Requisitos

### Software

- R (versión 4.0 o superior)
- RStudio
- Git (opcional)

### Paquetes R

#### Paquetes Básicos

```R
install.packages(c(
    "tidyverse",  # Análisis y visualización de datos
    "readr",      # Lectura de datos
    "ggplot2",    # Visualización
    "dplyr",      # Manipulación de datos
    "stats"       # Estadísticas básicas
))
```

#### Paquetes Recomendados

```R
install.packages(c(
    "skimr",      # Resúmenes estadísticos
    "janitor",    # Limpieza de datos
    "ggthemes",   # Temas para ggplot
    "forcats",    # Manejo de factores
    "corrplot"    # Visualización de correlaciones
))
```

## Instalación y Uso

1. Clonar el repositorio
2. Abrir RStudio
3. Navegar al directorio del repositorio
4. Instalar los paquetes necesarios
5. Ejecutar los scripts en orden
6. Los documentos HTML generados se pueden visualizar directamente en GitHub

Cada sección contiene:

- Documentación en formato Markdown
- Scripts R ejecutables
- Resultados y análisis
- Versiones HTML para visualización en GitHub

## Estructura del Proyecto

El proyecto está organizado en:

- `01 Introduccion/`: Conceptos básicos y presentación
- `02 Modelizacion/`: Análisis detallados
  - Regresión no lineal
  - Análisis de streaming
  - Modelos corporativos
- `html_output/`: Documentos HTML generados para visualización en GitHub
  - `Tyrell_Corp_1.html`: Análisis de crecimiento de replicantes (Modelo Logístico)
  - `Tyrell_Corp_2.html`: Análisis de crecimiento de replicantes (Modelo de Gompertz)

## Contribuciones

Las contribuciones son bienvenidas. Por favor:

1. Hacer fork del repositorio
2. Crear una rama para tu feature
3. Hacer commit de los cambios
4. Crear un Pull Request

## Licencia

Este proyecto está bajo la licencia MIT.
