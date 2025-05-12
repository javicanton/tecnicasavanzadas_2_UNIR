# Análisis de Dependencias Múltiples

Este directorio contiene ejemplos de Análisis de Ecuaciones Estructurales (SEM), una técnica estadística avanzada que permite analizar relaciones complejas entre variables observadas y latentes.

## Estructura del Directorio

```text
Dependencias multiples/
├── README.md                 # Este archivo
│
├── T800/                     # Análisis SEM de unidades T-800
│   ├── informe_T800_SEM.Rmd  # Informe completo del análisis
│   ├── modelo_T800_SEM.R     # Código R del análisis
│   ├── T800 data.csv        # Dataset original
│   └── img/                 # Imágenes y gráficos del análisis
│
└── educativo/               # Análisis SEM en contexto educativo
    ├── informe_modelo_educativo_SEM.Rmd  # Informe completo
    ├── modelo_educativo_SEM.R            # Código R del análisis
    ├── datos_educativos.csv             # Dataset original
    └── img/                             # Imágenes y gráficos
```

## Contenido Detallado

### 1. Análisis SEM del T-800

- **Descripción**: Análisis de la eficiencia operativa de unidades T-800 usando SEM.
- **Técnicas utilizadas**:
  - Análisis de Ecuaciones Estructurales
  - Modelos de medida
  - Visualización de modelos SEM
- **Resultados**:
  - Análisis de la eficiencia operativa
  - Evaluación de indicadores
  - Visualización de relaciones causales

### 2. Análisis SEM Educativo

- **Descripción**: Estudio de la influencia del apoyo docente en la motivación y el rendimiento.
- **Contenido**:
  - Modelos de medida
  - Análisis de relaciones causales
  - Evaluación de constructos latentes
  - Visualización de resultados

## Requisitos Técnicos

Para ejecutar los análisis se requieren los siguientes paquetes de R:

```r
install.packages(c(
  "lavaan",    # Análisis de Ecuaciones Estructurales
  "semPlot",   # Visualización de modelos SEM
  "psych",     # Análisis psicométricos
  "knitr",     # Generación de informes
  "ggplot2"    # Visualización de datos
))
```

## Uso

1. Abrir el archivo RMarkdown deseado en RStudio
2. Instalar las dependencias si no están presentes
3. Compilar el documento (Knit) para generar el informe HTML
4. Los archivos HTML generados se pueden visualizar directamente en GitHub

## Notas Importantes

- Todos los datasets originales están incluidos en sus respectivos directorios
- Los archivos .R contienen el código fuente completo
- Los archivos .Rmd contienen informes detallados de los análisis
- Las imágenes y gráficos se encuentran en el directorio `img/` correspondiente
- Se recomienda revisar los README.md específicos de cada subdirectorio para más detalles

## Contribuciones

Las contribuciones son bienvenidas. Por favor, seguir las guías de estilo establecidas.

## Licencia

Este proyecto está bajo la licencia MIT. 