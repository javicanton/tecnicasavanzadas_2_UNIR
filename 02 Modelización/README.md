# Modelización Estadística

Este directorio contiene los ejercicios y análisis de modelización estadística realizados durante el curso.

## Estructura del Directorio

```
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
