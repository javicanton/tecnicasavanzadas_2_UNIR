# Modelización Estadística

Este directorio contiene los ejercicios y análisis de modelización estadística realizados durante el curso.

## Estructura del Directorio

```text
02 Modelización/
├── README.md                 # Este archivo (índice descriptivo)
│
├── Analisis_Spotifal/        # Análisis de datos de streaming
│   ├── Spotifal_Informe.md   # Informe completo del análisis
│   ├── Spotifal.r           # Código R del análisis
│   ├── Dataset_Spotifal.csv # Dataset original
│   └── img/                 # Imágenes y gráficos del análisis
│
├── Regresion_Lineal/         # Ejercicios de regresión lineal
│   ├── Bacterias/           # Análisis de datos de bacterias
│   │   ├── RegresionLineal_Bacterias.R
│   │   └── RegresionLineal_Bacterias.md
│   │
│   └── Androides/           # Análisis de datos de androides
│       ├── RegresionLineal_Androides.R
│       └── RegresionLineal_Androides.md
│
├── Regresion_No_Lineal/      # Análisis de regresión no lineal
│   ├── Tyrell_Corp_1.Rmd    # Análisis con modelo logístico
│   ├── Tyrell_Corp_2.Rmd    # Análisis con modelo de Gompertz
│   └── html_output/         # Versiones HTML para GitHub
│       ├── Tyrell_Corp_1.html
│       └── Tyrell_Corp_2.html
│
└── Analisis_Tyrell_Corp/     # Análisis de datos de Tyrell Corporation
    ├── TyrellCorporation.R
    ├── TyrellCorporation_Output.R
    ├── TyrellCorporation.md
    └── datos_tyrell.csv
```

## Contenido Detallado

### 1. Análisis de Streaming (Spotifal)

- **Descripción**: Análisis completo de datos de usuarios de una plataforma de streaming musical.
- **Técnicas utilizadas**:
  - Regresión logística
  - Redes neuronales
  - Análisis ROC
  - Métricas de evaluación (Accuracy, Kappa)
- **Resultados**:
  - Análisis descriptivo de datos
  - Modelización predictiva del abandono de usuarios
  - Comparación de diferentes modelos estadísticos
  - Evaluación de rendimiento y métricas

### 2. Regresión Lineal

#### 2.1 Análisis de Bacterias

- **Descripción**: Estudio de la relación entre variables en datos de bacterias.
- **Contenido**:
  - Modelos de regresión lineal
  - Análisis de residuos
  - Validación de supuestos
  - Interpretación de resultados

#### 2.2 Análisis de Androides

- **Descripción**: Modelización de características de androides.
- **Contenido**:
  - Regresión lineal múltiple
  - Selección de variables
  - Diagnóstico del modelo
  - Predicciones y validación

### 3. Regresión No Lineal

- **Descripción**: Análisis del crecimiento de replicantes Nexus-4 en módulos de privación sensorial.
- **Contenido**:
  - Comparación de diferentes modelos de regresión:
    - Modelo lineal
    - Modelo polinomial (grados 2 y 3)
    - Modelo logístico
    - Modelo de Gompertz
    - Modelo de splines
  - Evaluación de métricas de ajuste (R², AIC, BIC)
  - Interpretación matemática de cada modelo
  - Visualización de resultados
  - Versiones HTML para visualización en GitHub

### 4. Análisis Tyrell Corporation

- **Descripción**: Análisis de datos de Tyrell Corporation.
- **Contenido**:
  - Análisis exploratorio de datos
  - Modelización estadística
  - Visualización de resultados
  - Interpretación de hallazgos

## Requisitos Técnicos

Para ejecutar los análisis se requieren los siguientes paquetes de R:

```r
install.packages(c(
  "ggplot2",    # Visualización de datos
  "nls2",       # Regresión no lineal
  "splines",    # Modelos de splines
  "caret",      # Entrenamiento de modelos
  "pROC",       # Curvas ROC
  "neuralnet",  # Redes neuronales
  "rmarkdown"   # Generación de documentos
))
```

## Uso

1. Abrir el archivo RMarkdown deseado en RStudio
2. Instalar las dependencias si no están presentes
3. Compilar el documento (Knit) para generar el informe HTML
4. Los archivos HTML generados se pueden visualizar directamente en GitHub
5. Para generar los archivos HTML, ejecutar:
   ```R
   rmarkdown::render('02 Modelización/Regresion_No_Lineal/Tyrell_Corp_1.Rmd', output_dir = 'html_output')
   rmarkdown::render('02 Modelización/Regresion_No_Lineal/Tyrell_Corp_2.Rmd', output_dir = 'html_output')
   ```

## Notas Importantes

- Todos los datasets originales están incluidos en sus respectivos directorios
- Los archivos .R contienen el código fuente completo
- Los archivos .md contienen informes detallados de los análisis
- Las imágenes y gráficos se encuentran en el directorio `img/` correspondiente
- Se recomienda revisar los README.md específicos de cada directorio para más detalles
- Los archivos HTML generados se pueden visualizar directamente en GitHub

## Contribuciones

Este trabajo forma parte de la investigación de Tyrell Corporation en el análisis de dinámicas poblacionales en entornos controlados.
