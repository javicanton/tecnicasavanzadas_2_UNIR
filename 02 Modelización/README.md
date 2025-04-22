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
└── Analisis_Tyrell_Corp/     # Análisis de datos de Tyrell Corporation
    ├── TyrellCorporation.R
    ├── TyrellCorporation_Output.R
    ├── TyrellCorporation.md
    └── datos_tyrell.csv
```

## Contenido Detallado

### 1. Análisis de Streaming (Spotifal)

- **Descripción**: Análisis completo de datos de usuarios de una plataforma de streaming musical.
- **Contenido**:
  - Análisis descriptivo de datos
  - Modelización predictiva del abandono de usuarios
  - Comparación de diferentes modelos estadísticos
  - Evaluación de rendimiento y métricas
- **Técnicas utilizadas**:
  - Regresión logística
  - Redes neuronales
  - Análisis ROC
  - Métricas de evaluación (Accuracy, Kappa)

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

### 3. Análisis Tyrell Corporation

- **Descripción**: Análisis de datos de Tyrell Corporation.
- **Contenido**:
  - Análisis exploratorio de datos
  - Modelización estadística
  - Visualización de resultados
  - Interpretación de hallazgos

## Recursos Adicionales

- Todos los datasets originales están incluidos en sus respectivos directorios
- Los archivos .R contienen el código fuente completo
- Los archivos .md contienen informes detallados de los análisis
- Las imágenes y gráficos se encuentran en el directorio `img/` correspondiente

## Notas

- Los archivos están organizados por similitud temática
- Cada directorio contiene su propio conjunto de datos y código
- Los informes están escritos en formato Markdown para fácil lectura
- Se recomienda revisar los README.md específicos de cada directorio para más detalles

## Contenido

Este directorio contiene análisis y modelos estadísticos aplicados a diferentes escenarios:

1. **Regresión No Lineal** (`Regresion_no_lineal.Rmd`)
   - Análisis del crecimiento de replicantes Nexus-4 en módulos de privación sensorial
   - Comparación de diferentes modelos de regresión:
     - Modelo lineal
     - Modelo polinomial (grados 2 y 3)
     - Modelo logístico
     - Modelo de splines
   - Evaluación de métricas de ajuste (R², AIC, BIC)
   - Interpretación matemática de cada modelo
   - Visualización de resultados

2. **Modelo de Crecimiento de Bacterias** (`modelo_crecimiento_bacterias.Rmd`)
   - Análisis del crecimiento bacteriano en diferentes condiciones
   - Modelización de la dinámica poblacional
   - Evaluación de factores ambientales

## Estructura

```
02 Modelización/
├── README.md
├── Regresion_no_lineal.Rmd
└── modelo_crecimiento_bacterias.Rmd
```

## Requisitos

Para ejecutar los análisis se requieren los siguientes paquetes de R:

```r
install.packages(c("ggplot2", "nls2", "splines"))
```

## Uso

1. Abrir el archivo RMarkdown deseado en RStudio
2. Instalar las dependencias si no están presentes
3. Compilar el documento (Knit) para generar el informe HTML

## Resultados

Los análisis generan informes HTML con:

- Visualizaciones interactivas
- Tablas de resultados
- Interpretaciones estadísticas
- Conclusiones y recomendaciones

## Contribuciones

Este trabajo forma parte de la investigación de Tyrell Corporation en el análisis de dinámicas poblacionales en entornos controlados.
