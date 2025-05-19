
# Predicción de Fallos en Androides Nexus-5

Este directorio contiene un ejemplo completo de modelización con redes neuronales en R, aplicado a un caso simulado basado en los androides Nexus-5 de la Tyrell Corporation (universo Blade Runner). El objetivo es enseñar el funcionamiento básico de estos modelos a estudiantes de técnicas cuantitativas avanzadas.

## Archivos incluidos

- `nexus5_datos_1000_decimal.csv`: dataset simulado con 1000 observaciones.
- `modelo_nexus5_nn.R`: script comentado para ejecutar paso a paso el modelo en R.
- `informe_nexus5_nn.Rmd`: versión en R Markdown para generar un informe HTML interactivo.

## Requisitos

Para ejecutar correctamente el análisis necesitas tener instalado en R:

- `nnet`
- `dplyr`
- `ggplot2`
- `caret`
- `pROC`
- `e1071`
- `knitr` (si deseas compilar el .Rmd)

## Instrucciones de uso

### Opción 1: Ejecutar paso a paso en R

1. Abre el archivo `modelo_nexus5_nn.R` en RStudio.
2. Ejecuta los bloques uno a uno para ver el preprocesamiento, modelado y evaluación.
3. Modifica los parámetros como `size`, `maxit`, `decay` para experimentar con diferentes arquitecturas.

### Opción 2: Generar un informe automático

1. Abre el archivo `informe_nexus5_nn.Rmd` en RStudio.
2. Asegúrate de tener todos los paquetes instalados.
3. Haz clic en “Knit” para compilar un informe HTML con gráficos, métricas y explicaciones.

## Objetivo didáctico

Este ejemplo permite entender:
- Cómo se preparan los datos para redes neuronales.
- Cómo se entrena y ajusta un modelo básico con `nnet`.
- Cómo se evalúan los resultados (matriz de confusión, AUC, visualizaciones).
- Qué papel juegan las variables latentes o encubiertas en un modelo realista.

