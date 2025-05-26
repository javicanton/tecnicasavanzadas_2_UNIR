# Taller de Ajuste de Redes Neuronales - Caso Nexus-5

Este taller se centra en el ajuste de parámetros de redes neuronales para predecir fallos en androides Nexus-5.

## Estructura de Archivos

- `taller_ajuste_redes_nexus5.Rmd`: Documento principal del taller con instrucciones y explicaciones
- `taller_ajuste_redes_nexus5.R`: Código base para el entrenamiento del modelo inicial
- `taller_ajuste_redes_nexus5_evalmodelos.R`: Código para la evaluación comparativa de modelos
- `nexus5_datos_1000.csv`: Dataset con información de androides Nexus-5
- `modelo_nexus5_nn.R`: Implementación completa del modelo (referencia)
- `informe_nexus5_nn.Rmd`: Informe detallado del caso de estudio

## Flujo de Trabajo

1. **Preparación Inicial**:
   - Ejecutar `taller_ajuste_redes_nexus5.R` para:
     - Cargar y preparar los datos
     - Entrenar el modelo inicial
     - Evaluar el rendimiento base

2. **Ajuste de Parámetros**:
   - Modificar los parámetros en `taller_ajuste_redes_nexus5.R`:
     - `size`: Número de neuronas en la capa oculta
     - `decay`: Penalización para evitar sobreajuste
     - `maxit`: Número máximo de iteraciones

3. **Evaluación Comparativa**:
   - Ejecutar `taller_ajuste_redes_nexus5_evalmodelos.R` para:
     - Probar diferentes combinaciones de parámetros
     - Comparar rendimiento entre modelos
     - Visualizar resultados

## Requisitos

- R >= 4.0.0
- Paquetes necesarios:
  - nnet
  - dplyr
  - ggplot2
  - caret
  - pROC
  - e1071

## Notas

- El archivo `modelo_nexus5_nn.R` sirve como referencia para una implementación completa
- `informe_nexus5_nn.Rmd` contiene un análisis detallado del caso de estudio
- Los resultados pueden variar debido a la aleatoriedad en el entrenamiento
