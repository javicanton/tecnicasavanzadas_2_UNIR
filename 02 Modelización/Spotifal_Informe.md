# Análisis de Datos de Spotifal

## 1. Introducción

Este informe presenta el análisis de datos de usuarios de Spotifal, una plataforma de streaming musical. El objetivo es entender los patrones de uso y abandono de los usuarios, utilizando diferentes técnicas de modelización estadística.

## 2. Configuración del Entorno

El análisis se realizó utilizando R con los siguientes paquetes:

- tidyverse: Para manipulación y visualización de datos
- skimr: Para resúmenes estadísticos
- janitor: Para limpieza de datos
- ggplot2: Para visualizaciones
- ggeffects: Para análisis de efectos marginales
- nnet: Para modelos de redes neuronales
- yardstick: Para métricas de evaluación
- pROC: Para análisis ROC

## 3. Carga y Limpieza de Datos

El dataset se cargó desde el archivo `Dataset_Spotifal.csv`.

### 3.1 Estructura del Dataset

El dataset contiene 500 observaciones y 8 variables:

- 3 variables categóricas (character)
- 5 variables numéricas

No se encontraron valores ausentes en ninguna variable.

### 3.2 Variables Categóricas

- **tipo_suscripcion**: 2 categorías únicas
- **genero_favorito**: 5 categorías únicas
- **sexo**: 3 categorías únicas

### 3.3 Variables Numéricas

- **dias_ultimo_inicio**:
  - Media: 9.53 días
  - Mediana: 7 días
  - Rango: 0-49 días
  - Distribución sesgada a la derecha

- **canciones_por_semana**:
  - Media: 29.8 canciones
  - Mediana: 30 canciones
  - Rango: 14-47 canciones
  - Distribución aproximadamente normal

- **listas_creadas**:
  - Media: 4.98 listas
  - Mediana: 5 listas
  - Rango: 0-12 listas
  - Distribución ligeramente sesgada a la derecha

- **edad**:
  - Media: 41.7 años
  - Mediana: 41 años
  - Rango: 16-69 años
  - Distribución relativamente uniforme

- **abandona** (variable objetivo):
  - Media: 0.21 (21% de abandono)
  - Distribución altamente sesgada (mayoría no abandona)

## 4. Análisis Descriptivo

### 4.1 Distribución de Variables Numéricas

El análisis detallado de las variables numéricas muestra:

- **dias_ultimo_inicio**:
  - 25% de usuarios iniciaron sesión hace 2 días o menos
  - 75% de usuarios iniciaron sesión hace 14 días o menos
  - Valor máximo: 49 días sin iniciar sesión

- **canciones_por_semana**:
  - 25% de usuarios escuchan 25 canciones o menos por semana
  - 75% de usuarios escuchan 33 canciones o menos por semana
  - Rango estrecho: 14-47 canciones, indicando patrones de uso consistentes

- **listas_creadas**:
  - 25% de usuarios han creado 3 listas o menos
  - 75% de usuarios han creado 6 listas o menos
  - Valor máximo: 12 listas creadas

- **edad**:
  - 25% de usuarios tienen 29 años o menos
  - 75% de usuarios tienen 56 años o menos
  - Distribución relativamente uniforme entre 16 y 69 años

### 4.2 Distribución de Variables Categóricas

#### Tipo de Suscripción

- **Gratuita**: 315 usuarios (63%)
- **Premium**: 185 usuarios (37%)

#### Género Favorito

- **Rock**: 126 usuarios (25.2%)
- **Clásica**: 107 usuarios (21.4%)
- **Pop**: 93 usuarios (18.6%)
- **Electrónica**: 90 usuarios (18%)
- **Reguetón**: 84 usuarios (16.8%)

#### Sexo

- **Mujer**: 241 usuarios (48.2%)
- **Hombre**: 230 usuarios (46%)
- **Prefiero no decirlo**: 29 usuarios (5.8%)

#### Abandono

- **No abandona**: 395 usuarios (79%)
- **Abandona**: 105 usuarios (21%)

## 5. Análisis de Correlaciones

### 5.1 Resumen de Correlaciones Diseñadas

| Variable             | Influye en abandona | Tipo de relación         |
|---------------------|--------------------|-----------------------|
| dias_ultimo_inicio   | Sí                | Positiva, lineal      |
| canciones_por_semana| Sí                | Negativa, lineal      |
| listas_creadas      | Sí                | Negativa, lineal      |
| edad                | Parcial (si > 50)  | Ligeramente positiva  |
| tipo_suscripcion    | Sí                | Categórica: gratuita peor |
| genero_favorito     | No                | Sin efecto inicial    |
| sexo                | No                | Sin efecto inicial    |

### 5.2 Análisis de Relaciones

#### Variables con Influencia Significativa

1. **Días desde último inicio (Positiva)**
   - Relación directa con el abandono
   - A más días sin actividad, mayor probabilidad de abandono
   - Efecto más fuerte y consistente en el dataset

2. **Canciones por semana (Negativa)**
   - Relación inversa con el abandono
   - Mayor actividad musical asociada a menor probabilidad de abandono
   - Indicador importante de engagement del usuario

3. **Listas creadas (Negativa)**
   - Relación inversa con el abandono
   - Más listas creadas indican menor probabilidad de abandono
   - Refleja inversión del usuario en la plataforma

#### Variables con Influencia Parcial

4. **Edad**
   - Efecto positivo débil, principalmente en mayores de 50 años
   - No es un predictor fuerte en usuarios más jóvenes
   - Sugiere necesidad de estrategias específicas por edad

5. **Tipo de Suscripción**
   - Factor categórico con influencia clara
   - Usuarios gratuitos muestran mayor tendencia al abandono
   - Variable clave para estrategias de retención

#### Variables sin Influencia Significativa

6. **Género Favorito y Sexo**
   - No muestran relación significativa con el abandono
   - Pueden ser útiles para segmentación pero no para predicción
   - Sugiere que el abandono es independiente de estas características

### 5.3 Implicaciones para el Modelado

1. **Priorización de Variables**:
   - Enfoque principal en días sin actividad y tipo de suscripción
   - Considerar patrones de uso (canciones y listas) como predictores secundarios
   - Edad como variable de control en modelos múltiples

2. **Consideraciones de Diseño**:
   - Explorar interacciones entre variables significativas
   - Evaluar transformaciones para relaciones no lineales
   - Posible exclusión de variables no significativas en modelos parsimoniosos

## 6. Visualizaciones Exploratorias

### 6.1 Patrones de Uso

#### Días desde el Último Inicio de Sesión

El histograma muestra una distribución fuertemente sesgada a la derecha:

- La mayoría de los usuarios (>100) han iniciado sesión en los últimos 2 días
- Hay una disminución exponencial en la frecuencia conforme aumentan los días
- Se observan algunos valores atípicos de usuarios que no han iniciado sesión en más de 40 días

#### Canciones por Semana según Tipo de Suscripción

El boxplot revela patrones de uso similares entre usuarios gratuitos y premium:

- La mediana es prácticamente idéntica (~30 canciones/semana) para ambos tipos
- La dispersión es ligeramente mayor en usuarios gratuitos
- Se observan valores atípicos en ambos grupos, especialmente en el rango superior
- No hay diferencias significativas en el consumo de música entre tipos de suscripción

### 6.2 Patrones de Abandono

#### Proporción de Abandono por Tipo de Suscripción

El gráfico de barras apiladas muestra diferencias claras:

- Los usuarios gratuitos tienen una tasa de abandono significativamente mayor (~30%)
- Los usuarios premium muestran una tasa de abandono mucho menor (~10%)
- La suscripción premium parece ser un factor protector contra el abandono

#### Relación entre Uso y Abandono

El gráfico de dispersión revela patrones interesantes:

- Existe una clara relación entre días sin iniciar sesión y abandono
- Los usuarios que abandonan (puntos turquesa) tienden a tener más días sin iniciar sesión
- No se observa una relación clara entre el número de canciones por semana y el abandono
- La mayoría de los abandonos ocurren después de los 10 días sin actividad

### 6.3 Conclusiones Preliminares

1. El tiempo sin iniciar sesión es un fuerte predictor del abandono
2. La suscripción premium reduce significativamente la probabilidad de abandono
3. El nivel de uso (canciones por semana) no parece ser un factor determinante
4. Existe una ventana de oportunidad crítica en los primeros 10 días de inactividad

## 7. Modelización

### 7.1 Modelo Lineal Simple

Como primera aproximación, se ajustó un modelo lineal simple para predecir el abandono en función de los días desde el último inicio de sesión.

#### Resultados del Modelo

```r
Call:
lm(formula = abandona ~ dias_ultimo_inicio, data = df)

Coefficients:
                   Estimate Std. Error t value Pr(>|t|)    
(Intercept)        0.060303   0.023663   2.548   0.0111 *  
dias_ultimo_inicio 0.015708   0.001736   9.047   <2e-16 ***
```

#### Interpretación

1. **Relación Significativa**:
   - El coeficiente para `dias_ultimo_inicio` es altamente significativo (p < 2e-16)
   - Por cada día adicional sin iniciar sesión, la probabilidad de abandono aumenta en 0.016 (1.6%)

2. **Ajuste del Modelo**:
   - R² ajustado = 0.1394 (13.94% de la varianza explicada)
   - El ajuste modesto sugiere que existen otros factores importantes no considerados

3. **Limitaciones**:
   - El modelo lineal no es el más apropiado para una variable de respuesta binaria
   - No tiene en cuenta la naturaleza no lineal de la relación
   - Puede predecir probabilidades fuera del rango [0,1]

### 7.2 Modelo Logístico Simple

Para abordar las limitaciones del modelo lineal, se ajustó un modelo logístico que es más apropiado para variables de respuesta binaria.

#### Resultados del Modelo

```r
Call:
glm(formula = abandona ~ dias_ultimo_inicio, family = "binomial", data = df)

Coefficients:
                   Estimate Std. Error z value Pr(>|z|)    
(Intercept)        -2.30166    0.18772 -12.261  < 2e-16 ***
dias_ultimo_inicio  0.08542    0.01147   7.447 9.51e-14 ***
```

#### Interpretación

1. **Efecto del Tiempo sin Actividad**:
   - El coeficiente positivo (0.08542) indica que la probabilidad de abandono aumenta con los días de inactividad
   - Por cada día adicional sin iniciar sesión, el log-odds de abandono aumenta en 0.085
   - En términos de odds ratio: exp(0.08542) = 1.089, lo que significa que las probabilidades de abandono aumentan un 8.9% por cada día sin actividad

2. **Significancia Estadística**:
   - La relación es altamente significativa (p < 9.51e-14)
   - El intercepto negativo (-2.30166) refleja la baja probabilidad base de abandono

3. **Ajuste del Modelo**:
   - Reducción en la devianza: de 513.96 a 450.81
   - AIC: 454.81
   - El modelo muestra un ajuste significativamente mejor que el modelo nulo

4. **Implicaciones Prácticas**:
   - El modelo confirma cuantitativamente que el tiempo sin actividad es un predictor robusto del abandono
   - Permite estimar la probabilidad de abandono basada únicamente en los días de inactividad
   - Puede usarse para identificar usuarios en riesgo de abandono

### 7.3 Modelo Logístico Múltiple

Para mejorar la capacidad predictiva, se ajustó un modelo que incluye múltiples variables predictoras.

#### Resultados del Modelo

```r
Call:
glm(formula = abandona ~ dias_ultimo_inicio + canciones_por_semana + 
    listas_creadas + edad + tipo_suscripcion, family = "binomial", data = df)

Coefficients:
                         Estimate Std. Error z value Pr(>|z|)    
(Intercept)             -0.262640   0.828717  -0.317   0.7513    
dias_ultimo_inicio       0.101747   0.013075   7.782 7.15e-15 ***
canciones_por_semana    -0.054695   0.022478  -2.433   0.0150 *  
listas_creadas          -0.105692   0.057026  -1.853   0.0638 .  
edad                     0.010643   0.008451   1.259   0.2079    
tipo_suscripcionpremium -2.213695   0.368425  -6.009 1.87e-09 ***
```

#### Interpretación

1. **Variables Significativas**:
   - `dias_ultimo_inicio`: Efecto positivo muy significativo (p < 7.15e-15)
   - `tipo_suscripcionpremium`: Fuerte efecto protector (p < 1.87e-09)
   - `canciones_por_semana`: Efecto protector moderado (p = 0.0150)
   - `listas_creadas`: Efecto protector marginalmente significativo (p = 0.0638)

2. **Magnitud de los Efectos**:
   - Por cada día sin actividad, el log-odds de abandono aumenta en 0.102
   - Tener suscripción premium reduce el log-odds de abandono en 2.214
   - Cada canción adicional por semana reduce el log-odds de abandono en 0.055
   - Cada lista creada reduce el log-odds de abandono en 0.106

3. **Ajuste del Modelo**:
   - Reducción significativa en la devianza: de 513.96 a 389.39
   - AIC: 401.39 (mejor que el modelo simple)
   - Mayor capacidad predictiva que los modelos anteriores

### 7.4 Modelo con Interacciones

Para explorar si el efecto del tiempo sin actividad varía según el tipo de suscripción, se ajustó un modelo con interacciones.

#### Resultados del Modelo

```r
Call:
glm(formula = abandona ~ dias_ultimo_inicio * tipo_suscripcion + 
    canciones_por_semana + listas_creadas + edad, family = "binomial", data = df)

Coefficients:
                                            Estimate Std. Error z value Pr(>|z|)    
(Intercept)                                -0.179957   0.833343  -0.216   0.8290    
dias_ultimo_inicio                          0.095638   0.014742   6.487 8.74e-11 ***
tipo_suscripcionpremium                    -2.654939   0.678039  -3.916 9.02e-05 ***
canciones_por_semana                       -0.055277   0.022441  -2.463   0.0138 *  
listas_creadas                             -0.103321   0.056941  -1.815   0.0696 .  
edad                                        0.010410   0.008445   1.233   0.2177    
dias_ultimo_inicio:tipo_suscripcionpremium  0.025402   0.030947   0.821   0.4118    
```

#### Interpretación

1. **Interacción No Significativa**:
   - La interacción entre días sin actividad y tipo de suscripción no es significativa (p = 0.4118)
   - Esto sugiere que el efecto del tiempo sin actividad es similar para usuarios gratuitos y premium

2. **Efectos Principales**:
   - Los efectos principales mantienen su significancia y dirección
   - El efecto protector de la suscripción premium es incluso más fuerte en este modelo
   - Los efectos de uso (canciones y listas) mantienen su significancia marginal

3. **Comparación de Modelos**:
   - AIC ligeramente mayor (402.69) que el modelo sin interacción
   - La inclusión de la interacción no mejora sustancialmente el ajuste

### 7.5 Modelo de Red Neuronal

Para capturar relaciones no lineales más complejas entre las variables, se implementó una red neuronal.

#### Estructura del Modelo

```r
a 7-5-1 network with 46 weights
inputs: dias_ultimo_inicio canciones_por_semana listas_creadas edad tipo_suscripcion genero_favorito sexo 
output(s): abandona 
options were - decay=0.01
```

#### Características del Modelo

- **Arquitectura**:
  - 7 variables de entrada
  - 5 neuronas en la capa oculta
  - 1 neurona de salida (predicción de abandono)
  - Total de 46 pesos (parámetros entrenables)

- **Parámetros de Entrenamiento**:
  - Regularización (decay = 0.01) para prevenir sobreajuste
  - Variables de entrada normalizadas
  - Función de activación logística para la clasificación binaria

#### Resultados y Predicciones

El gráfico de predicciones de la red neuronal muestra:

- Clara separación entre las predicciones para usuarios gratuitos (1) y premium (2)
- Mayor probabilidad de abandono para usuarios gratuitos
- Tendencia no lineal en la relación entre días sin actividad y probabilidad de abandono
- Capacidad del modelo para capturar patrones complejos en los datos

## 8. Evaluación Comparativa del Rendimiento

### 8.1 Métricas de Rendimiento

Se evaluaron todos los modelos utilizando dos métricas principales:

- **Accuracy**: Proporción de predicciones correctas. Esta métrica indica el porcentaje total de casos que el modelo clasifica correctamente, tanto abandonos como no abandonos. Un accuracy de 0.85 significa que el 85% de las predicciones son correctas.

- **Kappa**: Concordancia ajustada por azar. Esta métrica corrige el accuracy teniendo en cuenta la probabilidad de acierto por puro azar. Un Kappa de 0 indica que el modelo no es mejor que el azar, mientras que un Kappa de 1 indica concordancia perfecta. Valores por encima de 0.4 se consideran moderadamente buenos.

#### Tabla Comparativa

| Modelo                    | Accuracy | Kappa    |
|--------------------------|----------|----------|
| Lineal simple            | 0.804    | 0.225    |
| Logístico simple         | 0.800    | 0.216    |
| Logístico múltiple       | 0.834    | 0.396    |
| Logístico con interacción| 0.838    | 0.411    |
| Red neuronal             | 0.856    | 0.482    |

### 8.2 Análisis Comparativo

1. **Evolución del Rendimiento**:
   - Mejora progresiva desde modelos simples hasta más complejos
   - La red neuronal alcanza el mejor rendimiento en ambas métricas
   - Los modelos logísticos superan al modelo lineal simple

2. **Comparación de Accuracy**:
   - Modelo lineal simple: 80.4%
   - Modelo logístico simple: 80.0%
   - Modelo logístico múltiple: 83.4%
   - Modelo con interacciones: 83.8%
   - Red neuronal: 85.6%

3. **Comparación de Kappa**:
   - Mejora sustancial en el estadístico Kappa:
   - Modelos simples: ~0.22
   - Modelos logísticos múltiples: ~0.40
   - Red neuronal: 0.482

4. **Balance Complejidad-Rendimiento**:
   - La red neuronal ofrece la mejor precisión pero es más compleja
   - Los modelos logísticos múltiples ofrecen un buen balance entre interpretabilidad y rendimiento
   - La ganancia en rendimiento es modesta al aumentar la complejidad

### 8.3 Análisis de Curvas ROC

Las curvas ROC (Receiver Operating Characteristic) son una herramienta fundamental para evaluar el rendimiento de modelos de clasificación binaria. Representan la relación entre la tasa de verdaderos positivos (sensibilidad) y la tasa de falsos positivos (1 - especificidad) para diferentes umbrales de clasificación.

#### Conceptos Clave

- **Sensibilidad**: Proporción de abandonos correctamente identificados
- **Especificidad**: Proporción de no abandonos correctamente identificados
- **Área Bajo la Curva (AUC)**: Medida global del rendimiento del modelo
  - AUC = 1.0: Clasificación perfecta
  - AUC = 0.5: Clasificación aleatoria (línea diagonal)

#### Interpretación de las Curvas

1. **Comparación General**:
   - La red neuronal (línea naranja) muestra el mejor rendimiento global, con una curva más alejada de la diagonal
   - Los modelos logísticos múltiple y con interacción (líneas verde y morada) tienen rendimiento similar entre sí
   - El modelo logístico simple (línea azul) muestra un rendimiento inferior pero aceptable
   - El modelo lineal simple (línea gris punteada) tiene el peor rendimiento, aunque supera la clasificación aleatoria

2. **Análisis por Regiones**:
   - **Alta Especificidad (> 0.8)**:
     - La red neuronal destaca en identificar correctamente los casos de no abandono
     - Útil cuando queremos minimizar falsos positivos (evitar alarmas innecesarias)

   - **Alta Sensibilidad (> 0.8)**:
     - Todos los modelos logran buena detección de abandonos reales
     - La red neuronal mantiene mejor especificidad en esta región

3. **Implicaciones para el Negocio**:
   - **Punto de Operación Óptimo**:
     - Para alertas tempranas: priorizar alta sensibilidad (>0.8)
     - Para intervenciones costosas: priorizar alta especificidad (>0.8)

   - **Selección del Modelo**:
     - Red neuronal: mejor opción para decisiones críticas que requieren máxima precisión
     - Modelos logísticos: buena alternativa cuando se requiere interpretabilidad
     - Modelo simple: útil para monitoreo básico y screening inicial

4. **Balance Sensibilidad-Especificidad**:
   - La red neuronal logra el mejor equilibrio global:
     - Mantiene alta sensibilidad sin sacrificar especificidad
     - Especialmente efectiva en la región de alta especificidad (>0.8)

   - Los modelos logísticos múltiples:
     - Ofrecen un buen compromiso entre rendimiento e interpretabilidad
     - Mantienen rendimiento consistente en diferentes umbrales

   - El modelo lineal simple:
     - Muestra limitaciones en ambos extremos de la curva
     - Puede ser útil como baseline o referencia

5. **Consideraciones Prácticas**:
   - La elección del umbral dependerá del costo relativo de los errores:
     - Falsos positivos: recursos invertidos en retener usuarios no en riesgo
     - Falsos negativos: pérdida de usuarios que podrían haberse retenido

   - Se recomienda:
     - Usar la red neuronal para sistemas automatizados de scoring
     - Mantener los modelos logísticos para explicar decisiones a stakeholders
     - Ajustar umbrales según recursos disponibles para intervenciones

## 9. Conclusiones y Recomendaciones

### 9.1 Hallazgos Principales

1. Los días sin actividad son el predictor más importante del abandono
2. La suscripción premium reduce significativamente la probabilidad de abandono
3. El nivel de uso (canciones y listas) tiene un efecto protector moderado
4. No hay interacción significativa entre tipo de suscripción y tiempo sin actividad

### 9.2 Recomendaciones Prácticas

1. **Prevención Temprana**:
   - Implementar sistema de alertas para usuarios inactivos > 7 días
   - Priorizar intervenciones en usuarios gratuitos inactivos

2. **Estrategia de Retención**:
   - Promover activamente la conversión a suscripción premium
   - Incentivar la creación de listas de reproducción
   - Desarrollar campañas personalizadas según patrones de uso

3. **Monitoreo y Seguimiento**:
   - Utilizar el modelo de red neuronal para predicciones en tiempo real
   - Mantener un sistema de puntuación de riesgo de abandono
   - Evaluar periódicamente la efectividad de las intervenciones

### 9.3 Limitaciones y Trabajo Futuro

1. **Limitaciones**:
   - Dataset relativamente pequeño (500 usuarios)
   - No se consideran factores estacionales
   - Posible sesgo de selección en la muestra

2. **Mejoras Propuestas**:
   - Incorporar más variables predictoras (ej. dispositivos usados, horarios)
   - Desarrollar modelos específicos por segmento de usuario
   - Implementar técnicas de validación cruzada más robustas
