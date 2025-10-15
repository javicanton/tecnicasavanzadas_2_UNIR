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
  - Comparación de diferentes técnicas de modelización
  - Visualización de resultados y métricas de rendimiento

#### Regresión Lineal

- [Regresión Lineal Androides](02%20Modelización/Regresion_Lineal/Androides/RegresionLineal_Androides.md)
  - Modelo de regresión lineal aplicado a análisis de androides
- [Regresión Lineal Bacterias](02%20Modelización/Regresion_Lineal/Bacterias/RegresionLineal_Bacterias.md)
  - Análisis de crecimiento bacteriano mediante regresión lineal

#### Regresión No Lineal

- [Tyrell Corporation - Análisis de Crecimiento de Replicantes (Módulo A)](02%20Modelización/Regresion_No_Lineal/Tyrell_Corp_1.Rmd)
  - Modelo logístico para el análisis de crecimiento de replicantes Nexus-4
  - [Visualización HTML](02%20Modelización/Regresion_No_Lineal/html_output/Tyrell_Corp_1.html)
- [Tyrell Corporation - Análisis de Crecimiento de Replicantes (Módulo B)](02%20Modelización/Regresion_No_Lineal/Tyrell_Corp_2.Rmd)
  - Modelo de Gompertz para el análisis de crecimiento de replicantes Nexus-4
  - [Visualización HTML](02%20Modelización/Regresion_No_Lineal/html_output/Tyrell_Corp_2.html)

#### Dependencias Múltiples (SEM)

- [Análisis SEM del T-800](02%20Modelización/Dependencias_multiples/T800/html_output/informe_T800_SEM.html)
  - Análisis de Ecuaciones Estructurales aplicado a unidades T-800
  - Evaluación de eficiencia operativa y constructos latentes
- [Análisis SEM Educativo](02%20Modelización/Dependencias_multiples/educativo/html_output/informe_modelo_educativo_SEM.html)
  - Análisis de Ecuaciones Estructurales en contexto educativo
  - Estudio de relaciones entre apoyo docente, motivación y rendimiento

#### Análisis Corporativo

- [Tyrell Corporation - Análisis de Eliminaciones](02%20Modelización/Analisis_Tyrell_Corp/TyrellCorporation.md)
  - Análisis estadístico de patrones de eliminación en Tyrell Corporation

#### Redes Neuronales

- [Análisis de Fallos en Nexus-5 mediante Redes Neuronales](02%20Modelización/Redes_Neuronales/html_output/informe_nexus5_nn.html)
  - Implementación de redes neuronales para la predicción de fallos
  - Optimización mediante validación cruzada
  - Análisis de rendimiento y métricas de clasificación
- [Taller de Ajuste de Redes Neuronales](02%20Modelización/Redes_Neuronales/html_output/taller_ajuste_redes_nexus5.html)
  - Taller práctico de optimización de hiperparámetros
  - Evaluación comparativa de diferentes configuraciones
  - Casos prácticos de ajuste de modelos

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
    "corrplot",   # Visualización de correlaciones
    "lavaan",     # Análisis de Ecuaciones Estructurales
    "semPlot",    # Visualización de modelos SEM
    "psych"       # Análisis psicométricos
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

- `01 Introducción/`: Conceptos básicos y presentación de R
- `02 Modelización/`: Análisis detallados y casos de estudio
  - **Análisis_Spotifal/**: Análisis de abandono en plataforma de streaming
  - **Analisis_Tyrell_Corp/**: Análisis estadístico corporativo
  - **Dependencias_multiples/**: Análisis SEM (T-800 y educativo)
  - **Redes_Neuronales/**: Talleres y análisis de fallos en Nexus-5
  - **Regresion_Lineal/**: Modelos lineales (androides y bacterias)
  - **Regresion_No_Lineal/**: Modelos no lineales (crecimiento de replicantes)
- **Documentos HTML**: Generados automáticamente para visualización web
- **Enlaces de interés**: Recursos adicionales y referencias

## Navegación Web

Para una mejor experiencia, visita la [versión web del repositorio](https://javicanton.github.io/tecnicasavanzadas_2_UNIR/) donde encontrarás:

- Acceso directo a todos los análisis
- Visualización de documentos HTML
- Navegación organizada por categorías
- Enlaces a resultados interactivos

## Contribuciones

Las contribuciones son bienvenidas. Por favor:

1. Hacer fork del repositorio
2. Crear una rama para tu feature
3. Hacer commit de los cambios
4. Crear un Pull Request

## Licencia

Este proyecto está bajo la licencia MIT.
