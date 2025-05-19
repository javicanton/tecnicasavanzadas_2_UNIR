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

#### Regresión No Lineal

- [Tyrell Corporation - Análisis de Crecimiento de Replicantes](02%20Modelización/Regresion_No_Lineal/Tyrell_Corp_1.Rmd)
  - Modelo logístico para el análisis de crecimiento
- [Tyrell Corporation - Análisis de Crecimiento de Replicantes (Módulo B)](02%20Modelización/Regresion_No_Lineal/Tyrell_Corp_2.Rmd)
  - Modelo de Gompertz para el análisis de crecimiento

#### Dependencias Múltiples

- [Análisis SEM del T-800](02%20Modelización/Dependencias%20multiples/T800/informe_T800_SEM.Rmd)
  - Análisis de Ecuaciones Estructurales aplicado a unidades T-800
- [Análisis SEM Educativo](02%20Modelización/Dependencias%20multiples/educativo/informe_modelo_educativo_SEM.Rmd)
  - Análisis de Ecuaciones Estructurales en contexto educativo

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

- `01 Introduccion/`: Conceptos básicos y presentación
- `02 Modelizacion/`: Análisis detallados
  - Regresión no lineal
  - Análisis de streaming
  - Modelos corporativos
  - Dependencias múltiples (SEM)
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

# Análisis de Fallos en Nexus-5

Este repositorio contiene el análisis de fallos en los replicantes Nexus-5 de la Tyrell Corporation, utilizando diferentes técnicas de aprendizaje automático.

## Estructura del Proyecto

```
.
├── 01_Datos/
│   ├── nexus5_datos_1000.csv
│   └── README.md
├── 02_Modelizacion/
│   ├── Arboles_Decision/
│   │   ├── informe_nexus5_arboles.Rmd
│   │   └── README.md
│   ├── Random_Forest/
│   │   ├── informe_nexus5_rf.Rmd
│   │   └── README.md
│   └── Redes_Neuronales/
│       ├── informe_nexus5_nn.Rmd
│       └── README.md
└── README.md
```

## Contenido

### 1. Datos
- Conjunto de datos de 1000 replicantes Nexus-5
- Variables incluidas: energía restante, contacto con Blade Runner, antigüedad, experiencia acumulada, sexo, rebeldía y fallo

### 2. Modelización

#### 2.1 Árboles de Decisión
- Implementación de árboles de decisión para clasificación
- Análisis de la importancia de variables
- Visualización de árboles y métricas de rendimiento

#### 2.2 Random Forest
- Implementación de Random Forest
- Optimización de hiperparámetros
- Comparación con árboles de decisión simples

#### 2.3 Redes Neuronales
- Implementación de redes neuronales básicas
- Optimización mediante validación cruzada
- Comparación con otros modelos de clasificación

## Requisitos

- R >= 4.0.0
- Paquetes R:
  - rpart
  - randomForest
  - nnet
  - caret
  - ggplot2
  - pROC
  - dplyr
  - tidyr

## Uso

1. Clonar el repositorio
2. Instalar las dependencias necesarias
3. Ejecutar los informes Rmd en el orden deseado

## Resultados

Los resultados detallados de cada análisis se encuentran en los respectivos informes Rmd:

- [Informe Árboles de Decisión](02_Modelizacion/Arboles_Decision/informe_nexus5_arboles.Rmd)
- [Informe Random Forest](02_Modelizacion/Random_Forest/informe_nexus5_rf.Rmd)
- [Informe Redes Neuronales](02_Modelizacion/Redes_Neuronales/informe_nexus5_nn.Rmd)

## Contribuciones

Este proyecto es parte de la investigación interna de la Tyrell Corporation. Para contribuir, por favor contactar con la División Analítica Experimental.

## Licencia

Derechos reservados © Tyrell Corporation
