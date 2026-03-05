# Ejercicio 4 - Tarea 1: Mercado Laboral en México



## Marco Conceptual para resolver ejercicio 4 sobre la Matriz de Hussmanns

## Introducción

La Matriz de Hussmanns, desarrollada por Ralf Hussmanns para la Organización Internacional del Trabajo (OIT), constituye el marco analítico estándar para la medición estadística de la informalidad laboral. Su innovación radica en la distinción entre la naturaleza de la unidad económica (la empresa) y la naturaleza de la relación laboral.

## Dimensiones de la matriz

#### Dimensión Institucional (Unidad de Producción)

Se refiere al entorno organizacional donde se desarrolla la actividad económica. Se clasifica habitualmente en tres categorías:

* **Sector Formal:** Unidades económicas constituidas legalmente, con registros contables y cumplimiento de normativas fiscales y administrativas.
* **Sector Informal:** Unidades de producción de mercado que operan a baja escala, sin registros legales o contables suficientes, cuya finalidad primordial es la generación de ingresos y empleo para los individuos involucrados.
* **Hogares:** Unidades de producción no orientadas al mercado, dedicadas principalmente al trabajo doméstico remunerado y actividades de subsistencia.

#### Dimensión Laboral (Naturaleza del Empleo)

Se refiere al vínculo jurídico y de protección del trabajador, independientemente de la unidad de producción:

* **Empleo Formal:** Relaciones laborales que cuentan con acceso efectivo a la seguridad social, contratos escritos y prestaciones de ley.
* **Empleo Informal:** Trabajadores que carecen de protección social y derechos laborales básicos, ya sea por elusión de la normativa en el sector formal o por la naturaleza intrínseca del sector informal.

## Estructura de la Matriz (Modelo 3x2)

| Unidad de Producción | Empleo Informal                  | Empleo Formal               |
| -------------------- | -------------------------------- | --------------------------- |
| **Sector Formal**    | Informalidad en el sector formal | Empleo formal pleno         |
| **Sector Informal**  | Empleo en el sector informal     | No aplicable (Cero teórico) |
| **Hogares**          | Trabajo doméstico no protegido   | Trabajo doméstico protegido |

La intersección entre "Sector Informal" y "Empleo Formal" se considera un conjunto vacío o estadísticamente nulo. El acceso a la formalidad laboral (registro en seguridad social) requiere que el empleador posea registros legales y fiscales previos, lo cual, por definición, desplaza a la unidad económica hacia el Sector Formal.

## Relevancia de la Categoría "Hogares"

La segregación de los hogares como una unidad de producción diferenciada es imperativa por tres factores:

1. **Ausencia de Producción Mercantil:** A diferencia de las empresas, los hogares consumen el servicio internamente sin una transacción de mercado final.
2. **Especificidad del Entorno:** La privacidad del espacio doméstico dificulta la inspección laboral y la aplicación de estándares industriales.
3. **Diferenciación Jurídica:** El trabajo doméstico suele estar sujeto a regímenes de seguridad social y marcos regulatorios especiales en la legislación nacional.

## Implementación Empírica en México (INEGI)

En la práctica estadística de México, a través de la Encuesta Nacional de Ocupación y Empleo (ENOE), el INEGI adapta el modelo teórico de Hussmanns para capturar con mayor precisión las dinámicas del mercado laboral nacional. La principal modificación es la desagregación de la dimensión institucional en **cuatro categorías** en lugar de tres.

#### La Incorporación del Ámbito Agropecuario

A diferencia del modelo teórico estándar, el INEGI separa el **Ámbito Agropecuario** como una unidad de producción independiente del Sector Informal Urbano. Esta distinción es crítica por las siguientes razones:

1. **Naturaleza de Subsistencia:** Gran parte de la actividad agropecuaria en México está orientada al autoconsumo o es de subsistencia, con dinámicas de "trabajo familiar no remunerado" que difieren del sector informal comercial o de servicios.
2. **Estacionalidad y Volatilidad:** Al aislar el sector primario, se evita que los ciclos agrícolas (siembras y cosechas) generen fluctuaciones artificiales en las tasas de informalidad del sector secundario y terciario.
3. **Especificidad de Política Pública:** Los mecanismos para formalizar a un pequeño productor agrícola son distintos a los requeridos para un micronegocio urbano.

#### Estructura Empírica de 4 Sectores (ENOE)

Bajo esta lógica, la matriz de la ENOE clasifica las unidades de producción de la siguiente manera:

* **Sector Informal (No Agropecuario):** Micronegocios y autoempleo urbano no registrados.
* **Sector Formal:** Empresas constituidas, instituciones públicas y organizaciones sociales.
* **Trabajo Doméstico Remunerado:** Empleo realizado dentro de los hogares.
* **Ámbito Agropecuario:** Unidades de producción agrícola, ganadera, forestal y pesquera.

## 

## Resolución del ejercicio

## (a) Obtenga laMatriz Hussmans para México, del INEGI, para algún trimestre 2024

Elegí el cuarto trimestre: 2024 Q4

Desglose General de la Matriz (Millones de personas)

| Sector (Unidad de Producción) | Empleo Formal | Empleo Informal | Total |
|:----------------------------- |:-------------:|:---------------:|:-----:|
| **Sector Informal**           | 0.00          | 17.20           | 17.20 |
| **Empresas, Gob. e Inst.**    | 26.07         | 7.81            | 33.88 |
| **Trabajo Doméstico**         | 0.11          | 2.30            | 2.41  |
| **Ámbito Agropecuario**       | 0.91          | 5.48            | 6.39  |
| **TOTAL**                     | 27.09         | 32.79           | 59.90 |

**Población Ocupada Total:** 59,901,799 personas.



### (b) A partir de la tabla, averigüe qué proporción de los trabajadores trabaja en el sector informal de la economía.

- **Total de trabajadores:** 59,901,799 personas.

- **Total Sector Informal:** 17,206,339 personas

- **Proporcion Sector Informal:** (total_sector_informal / total_trabajadores) * 100 = **28.72 %**

Este porcentaje representa a los trabajadores que operan en unidades económicas no registradas (micronegocios, autoempleo de subsistencia).



<img src="file:///C:/Users/Brenda/Documents/ProjectoEconomia/grafico_b_sectores_pay.png" title="" alt="grafico_b_sectores_pay" style="zoom:25%;">

### (c) A partir de la tabla, averigüe qué proporción de los trabajadores del sector formal son informales.

* **Empleos informales en Sector Formal:** 7,810,069 personas.

* **Total Sector Formal:** 33,880,267 personas

* **Proporcion Trabajadores Informales en sector Formal:** (empleos_informales_sector_formal / total_sector_formal) * 100 = **23 %**

Este porcentaje representa la proporción de trabajadores informales dentro de empresas, gobierno e instituciones (unidades formales). Carecen de seguridad social y prestaciones de ley.



<img src="file:///C:/Users/Brenda/Documents/ProjectoEconomia/grafico_c_composicion_formal_pay.png" title="" alt="" style="zoom:25%;">

## (d) Averigüe con datos del INEGI cuáles son las industrias formales con mayor proporción de trabajadores informales y los estados de la república con mayor proporción de trabajadores informales.

**Industrias Formales con MAYOR Informalidad:**

1. Agricultura, ganadería, pesca y caza: **85.70%**
2. Otros servicios (excepto actividades gubernamentales): **82.96%**
3. No especificado: **80.76%**
4. Construcción: **78.45%**
5. Servicios de hospedaje y preparación de alimentos: **70.71%**

**Grafica que muestra la tasa de informalidad por industria**

<img src="file:///C:/Users/Brenda/Documents/ProjectoEconomia/grafico_d_industria.png" title="" alt="grafico_d_industria" style="zoom:25%;">

**Entidades federativas con MAYOR informalidad:**

1. Oaxaca: 78.36%
2. Guerrero: 78.09%
3. Chiapas: 77.73%
4. Puebla: 71.20%
5. Hidalgo: 71.04%

**Grafica que muestra la tasa de informalidad por estado**

<img src="file:///C:/Users/Brenda/Documents/ProjectoEconomia/grafico_d_estado.png" title="" alt="grafico_d_estado" style="zoom:25%;">

## (e) Obtenga una medida de salario por industria y grafique el nivel de informalidad contra el salario.

En esta sección se analiza cómo la informalidad se relaciona con los niveles salariales promedio de cada industria.

Salario promedio y tasa de informalidad por industria.

| Industria           | Salario Mensual Promedio | Tasa de Informalidad |
|:------------------- |:------------------------:|:--------------------:|
| Agropecuario        | $6,583.24                | 83.25%               |
| Otros Servicios     | $7,602.86                | 80.85%               |
| No especificado     | $7,926.68                | 79.30%               |
| Comercio Minor      | $8,212.26                | 59.33%               |
| Hospedaje/Alimentos | $8,590.21                | 68.03%               |
| Apoyo a Negocios    | $9,392.61                | 33.77%               |
| Manufacturas        | $10,175.89               | 34.60%               |
| Esparcimiento       | $10,697.69               | 63.39%               |
| Construcción        | $11,823.89               | 74.45%               |
| Comercio Mayor      | $12,251.29               | 23.98%               |
| Transportes         | $13,068.31               | 49.82%               |
| Educativos          | $13,170.60               | 16.07%               |
| Gobierno            | $14,005.36               | 16.64%               |
| Medios Masivos      | $14,167.94               | 12.62%               |
| Inmobiliarios       | $14,367.71               | 47.63%               |
| Salud/Asistencia    | $14,465.77               | 22.47%               |
| Electricidad/Agua   | $15,748.61               | 12.03%               |
| Prof/Científicos    | $15,795.94               | 33.41%               |
| Financieros         | $16,017.34               | 14.58%               |
| Minería             | $20,265.88               | 10.67%               |
| Corporativos        | $21,774.54               | 2.97%                |

Grafica de la tabla.



<img title="" src="file:///C:/Users/Brenda/Documents/ProjectoEconomia/grafico_e_salario.png" alt="" style="zoom:50%;">

Existe una **correlación negativa clara**: las industrias con mayores niveles de informalidad tienden a ofrecer los salarios más bajos.

La formalidad actúa como un vehículo para mejores remuneraciones. El sector Agropecuario es el más vulnerable con el salario más bajo y la mayor informalidad. Mientras que sectores como Corporativos y Mineria son los mejor remunerados y con menos informalidad



### (f) Obtenga una medida de la edad promedio de los trabajadores por industria y grafique la edad contra el salario.

Edad promedio y el salario promedio por industria.

| Industria           | Salario Mensual Promedio | Edad Promedio |
|:------------------- |:------------------------:|:-------------:|
| Agropecuario        | $6,583.24                | 43.84 años    |
| Otros Servicios     | $7,602.86                | 41.80 años    |
| No especificado     | $7,926.68                | 37.09 años    |
| Comercio Minor      | $8,212.26                | 40.04 años    |
| Hospedaje/Alimentos | $8,590.21                | 37.86 años    |
| Apoyo a Negocios    | $9,392.61                | 41.95 años    |
| Manufacturas        | $10,175.89               | 38.35 años    |
| Esparcimiento       | $10,697.69               | 37.12 años    |
| Construcción        | $11,823.89               | 40.20 años    |
| Comercio Mayor      | $12,251.29               | 38.67 años    |
| Transportes         | $13,068.31               | 41.28 años    |
| Educativos          | $13,170.60               | 42.19 años    |
| Gobierno            | $14,005.36               | 42.79 años    |
| Medios Masivos      | $14,167.94               | 36.57 años    |
| Inmobiliarios       | $14,367.71               | 40.66 años    |
| Salud/Asistencia    | $14,465.77               | 39.45 años    |
| Electricidad/Agua   | $15,748.61               | 42.21 años    |
| Prof/Científicos    | $15,795.94               | 39.56 años    |
| Financieros         | $16,017.34               | 37.41 años    |
| Minería             | $20,265.88               | 41.16 años    |
| Corporativos        | $21,774.54               | 37.35 años    |

Grafica de la tabla

![](file:///C:/Users/Brenda/Documents/ProjectoEconomia/grafico_f_edad.png)

La relación entre la edad y el salario muestra que los sectores con salarios más altos no necesariamente tienen la fuerza laboral más vieja, sino que se concentran en un rango de madurez profesional (37-42 años).

Sectores dinámicos como "Medios Masivos" o "Corporativos" atraen talento joven con altas remuneraciones, mientras que el sector "Agropecuario" retiene a población de mayor edad con los salarios más bajos.



### (g) Obtenga una medida de la composición por género de los trabajadores por industria y grafique dicha composición contra el salario.

Salario promedio y composisción por género de cada industria.

| Industria           | Salario Mensual Promedio | % Mujeres | % Hombres |
|:------------------- |:------------------------:|:---------:|:---------:|
| Agropecuario        | $6,583.24                | 14.70%    | 85.30%    |
| Otros Servicios     | $7,602.86                | 56.84%    | 43.16%    |
| No especificado     | $7,926.68                | 28.79%    | 71.21%    |
| Comercio Minor      | $8,212.26                | 57.71%    | 42.29%    |
| Hospedaje/Alimentos | $8,590.21                | 59.42%    | 40.58%    |
| Apoyo a Negocios    | $9,392.61                | 35.20%    | 64.80%    |
| Manufacturas        | $10,175.89               | 40.36%    | 59.64%    |
| Esparcimiento       | $10,697.69               | 29.93%    | 70.07%    |
| Construcción        | $11,823.89               | 5.18%     | 94.82%    |
| Comercio Mayor      | $12,251.29               | 26.43%    | 73.57%    |
| Transportes         | $13,068.31               | 11.30%    | 88.70%    |
| Educativos          | $13,170.60               | 62.88%    | 37.12%    |
| Gobierno            | $14,005.36               | 45.44%    | 54.56%    |
| Medios Masivos      | $14,167.94               | 35.22%    | 64.78%    |
| Inmobiliarios       | $14,367.71               | 38.63%    | 61.37%    |
| Salud/Asistencia    | $14,465.77               | 66.15%    | 33.85%    |
| Electricidad/Agua   | $15,748.61               | 23.54%    | 76.46%    |
| Prof/Científicos    | $15,795.94               | 42.49%    | 57.51%    |
| Financieros         | $16,017.34               | 54.08%    | 45.92%    |
| Minería             | $20,265.88               | 14.75%    | 85.25%    |
| Corporativos        | $21,774.54               | 44.55%    | 55.45%    |

Grafica de la tabla

![](file:///C:/Users/Brenda/Documents/ProjectoEconomia/grafico_g_stacked.png)

El análisis muestra una segregación ocupacional marcada por género. Sectores como: Salud, Educación, hospedaje; están altamente feminizados, mientras que Construcción, Transportes y Agropecuario son actividades dominadas por hombres. 

Algunos sectores de alto salario, como Corporativos y Financieros, presentan una participación de mujeres cercana a la paridad (44-54%), mientras que otros como Minería también presenta un salario promedio alto pero está más masculinizada

No se ve alguna correlacion entre salario y género.



## (h) Enuncie algunas conclusiones tentativas sobre los resultados que obtuvo, relacionándolas con los modelos discutidos en clase.

A partir de los hallazgos empíricos de la ENOE 2024 Q4, se presenta la interpretación de los datos bajo los marcos teóricos de los modelos de mercado laboral vistos en clase:

#### Salarios de Eficiencia (Solow, Summers, Shapiro-Stiglitz)

La disparidad observada en los salarios entre sectores como Corporativos (\$21,774) y el Sector Agropecuario (\$6,583) es evidencia de la fijación de salarios por encima del equilibrio de mercado:

- **Modelos de Solow y Generalizado:** Las industrias de alta productividad mantienen salarios elevados para incentivar el esfuerzo y retener talento, lo que explica por qué la informalidad es mínima en sectores de alta especialización (Minería 10.7%, Financieros 14.6%).
- **Modelo de Shapiro-Stiglitz (Shirking):** La informalidad estructural funciona como el "estado de castigo" en México. La diferencia salarial de más de $14,000 entre un empleo formal corporativo y uno informal agropecuario representa un incentivo suficientemente alto para que los empleados formales teman ser despedidos, garantiza la no holgazanería y se podría interpretar como la sobrprima de incentivo al esfuerzo.

#### Modelos de Contratos Implícitos

Como vimos en el modelo, las empresas en sectores estables (Gobierno, Educación) actúan como "aseguradoras" para trabajadores adversos al riesgo, ofreciendo seguridad social y estabilidad a través de contratos de largo plazo. Sin embargo, La proporción de 23.05% de informalidad en el sector formal muestra una fractura en la cobertura de riesgos, donde se desplaza el riesgo económico totalmente hacia el trabajador. 

La falta de cobertura del riesgo es del 100% en el sector informal, cuyos empleados aceptan la informalidad ante la incapacidad de la empresa de garantizar un flujo de ingresos estable.

El empleo formal (43.44% de los trabajadores) es donde el contrato implícito es exitoso; la empresa absorbe las fluctuaciones del mercado y garantiza seguridad social (seguro de salud/retiro) a cambio de retener a su capital humano. Industrias como Corporativos o Minería tienen bajísima informalidad, mientras que la Construcción o el Sector Agropecuario tienen tasas altísimas.

En industrias volátiles, la incertidumbre es tan alta que las empresas no pueden actuar como aseguradoras sin quebrar. Al no poder ofrecer un contrato implícito de largo plazo, el mercado se desplaza hacia la informalidad, que funciona como un mercado walrasiano,  donde el salario fluctúa libremente y no hay compromiso de permanencia.

#### Modelos de Búsqueda y Emparejamiento (Search and Matching)

La diferencia regional de la informalidad entre Nuevo León (33.5% informal) y Oaxaca (78.4% informal) refleja que las fricciones de búsqueda son menores en el norte del país, donde el "match" formal es más probable.

En el sur, la desarticulación del mercado laboral y la falta de infraestructura de búsqueda incentivan emparejamientos rápidos pero informales, perpetuando una trampa de baja productividad y bajos salarios.

## Conclusión

El mercado laboral mexicano en 2024 no es un mercado de competencia perfecta, sino uno segmentado donde la formalidad es un bien escaso reservado para sectores que pueden sostener salarios de eficiencia y contratos de largo plazo, dejando a la mayoría (el resto de la población) en un equilibrio de informalidad (mercado walrasiano).


