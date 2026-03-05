# --- CONFIGURACIÓN INICIAL Y LIBRERÍAS ---
if (!require("RSQLite", quietly = TRUE)) install.packages("RSQLite", repos = "https://cloud.r-project.org")
if (!require("data.table", quietly = TRUE)) install.packages("data.table", repos = "https://cloud.r-project.org")
if (!require("ggplot2", quietly = TRUE)) install.packages("ggplot2", repos = "https://cloud.r-project.org")

library(RSQLite)
library(data.table)
library(ggplot2)

# Estilo visual estandarizado
tema_con_marco <- theme_minimal() + 
  theme(
    plot.background = element_rect(colour = "black", fill="white", linewidth=1.5),
    plot.title = element_text(hjust = 0.5, face = "bold", size = 14),
    axis.title = element_text(face = "bold"),
    panel.grid.minor = element_blank()
  )

# --- PREPARACIÓN DE LA BASE DE DATOS
# Convierte los mocrodatos de la ENOE en una base de datos .db

csv_path <- "input/enoe_2024_4t_limpio.csv"
db_path <- "output/Datos.db"

if (!dir.exists("data")) dir.create("data")

cols_interes <- c("ent", "sex", "eda", "ingocup", "fac_tri", 
                  "mh_fil2", "mh_col", "scian", "clase2", "clase1")

print("Leyendo CSV...")
df_raw <- fread(csv_path, select = cols_interes, encoding = "Latin-1")

# Limpieza básica: convertir a numérico
df_raw[, (cols_interes) := lapply(.SD, function(x) as.numeric(as.character(x))), .SDcols = cols_interes]
df_raw[is.na(df_raw)] <- 0

print("Guardando en SQLite (Datos.db)...")
con <- dbConnect(SQLite(), db_path)
dbWriteTable(con, "enoe_data", df_raw, overwrite = TRUE)

# --- EXPLORACIÓN DE DICCIONARIOS ---
# Este script busca las definiciones de mh_fil2 y mh_col en el diccionario de la ENOE.

dict_path <- "input/diccionario_datos_sdem_enoe_2024_4t.csv"

if (file.exists(dict_path)) {
  dict <- read.csv(dict_path, encoding = "Latin-1", stringsAsFactors = FALSE)
  filas_interes <- apply(dict, 1, function(row) any(grepl("mh_", row, ignore.case = TRUE)))
  cat("\n--- FILAS ENCONTRADAS EN DICCIONARIO CON 'mh_' ---\n")
  if(any(filas_interes)) print(dict[filas_interes, ])
}

res_fil <- dbGetQuery(con, "SELECT mh_fil2, COUNT(*) as n FROM enoe_data WHERE clase2 = 1 GROUP BY mh_fil2")
res_col <- dbGetQuery(con, "SELECT mh_col, COUNT(*) as n FROM enoe_data WHERE clase2 = 1 GROUP BY mh_col")

cat("\n--- VALORES REALES EN Datos.db (mh_fil2) ---\n")
print(res_fil)
cat("\n--- VALORES REALES EN Datos.db (mh_col) ---\n")
print(res_col)

# --- LECTURA DE CATÁLOGOS ---
# Este script lee los catálogos oficiales para mh_fil2 y mh_col.

cat_fil_path <- "input/mh_fil2.csv"
cat_col_path <- "input/mh_col.csv"

if (file.exists(cat_fil_path)) {
  cat("\n--- CATÁLOGO DE FILAS (mh_fil2) ---\n")
  print(read.csv(cat_fil_path, encoding = "Latin-1"))
}

if (file.exists(cat_col_path)) {
  cat("\n--- CATÁLOGO DE COLUMNAS (mh_col) ---\n")
  print(read.csv(cat_col_path, encoding = "Latin-1"))
}

# INCISO A: ANÁLISIS DE LA MATRIZ DE HUSSMANNS
# Calcula los totales y proporciones de la Matriz de Hussmanns.

query_matriz <- "SELECT mh_fil2, mh_col, SUM(fac_tri) as total FROM enoe_data WHERE clase2 = 1 GROUP BY mh_fil2, mh_col"
datos_matriz <- dbGetQuery(con, query_matriz)

etiquetas_fila <- c("1" = "Sector informal", "2" = "Trabajo doméstico remunerado", 
                    "3" = "Empresas, Gobierno e Instituciones (Sector Formal)", "4" = "Ámbito agropecuario")
datos_matriz$Nombre_Sector <- etiquetas_fila[as.character(datos_matriz$mh_fil2)]
datos_matriz$Tipo_Empleo <- ifelse(datos_matriz$mh_col %% 2 != 0, "Informal", "Formal")

cat("\n--- MATRIZ DE HUSSMANNS (Sectores vs Tipo de Empleo) ---\n")
resumen_tabla <- xtabs(total ~ Nombre_Sector + Tipo_Empleo, data = datos_matriz)
print(addmargins(resumen_tabla))

total_trabajadores <- sum(datos_matriz$total)
cat(paste0("\nTotal de trabajadores (Ocupados): ", format(as.integer(total_trabajadores), big.mark = ","), "\n"))

# INCISO B: PROPORCIÓN DEL "SECTOR INFORMAL"
total_sector_informal <- sum(datos_matriz$total[datos_matriz$mh_fil2 == 1])
prop_sector_informal <- (total_sector_informal / total_trabajadores) * 100
cat(sprintf("Proporción del Sector Informal: %.2f%%\n", prop_sector_informal))

# Gráfica: Distribución Total por Sectores (Pastel)
df_sectores <- aggregate(total ~ Nombre_Sector, data = datos_matriz, sum)
df_sectores$Proporcion <- (df_sectores$total / total_trabajadores) * 100

p1_pay <- ggplot(df_sectores, aes(x = "", y = Proporcion, fill = Nombre_Sector)) +
  geom_bar(stat = "identity", width = 1, color = "black") +
  coord_polar("y", start = 0) +
  geom_text(aes(label = sprintf("%.1f%%", Proporcion)), position = position_stack(vjust = 0.5), fontface = "bold") +
  scale_fill_manual(values = c("Sector informal" = "#e74c3c", "Empresas, Gobierno e Instituciones (Sector Formal)" = "#3498db",
                               "Ámbito agropecuario" = "#27ae60", "Trabajo doméstico remunerado" = "#f1c40f")) +
  labs(title = "Distribución de la Población Ocupada por Sector", fill = "Sector") +
  theme_void() + tema_con_marco
ggsave("output/grafico_b_sectores_pay.png", p1_pay, width = 10, height = 7)

# INCISO C: INFORMALIDAD EN EL SECTOR FORMAL
total_formal_informal <- sum(datos_matriz$total[datos_matriz$mh_fil2 == 3 & datos_matriz$Tipo_Empleo == "Informal"])
total_sector_formal <- sum(datos_matriz$total[datos_matriz$mh_fil2 == 3])
prop_informal_en_formal <- (total_formal_informal / total_sector_formal) * 100
cat(sprintf("Proporción de empleo informal dentro del Sector Formal: %.2f%%\n", prop_informal_en_formal))

# Gráfica: Composición del Sector Formal (Pastel)
df_empleo_formal_sector <- aggregate(total ~ Tipo_Empleo, data = datos_matriz[datos_matriz$mh_fil2 == 3, ], sum)
df_empleo_formal_sector$Proporcion <- (df_empleo_formal_sector$total / sum(df_empleo_formal_sector$total)) * 100

p2_pay <- ggplot(df_empleo_formal_sector, aes(x = "", y = Proporcion, fill = Tipo_Empleo)) +
  geom_bar(stat = "identity", width = 1, color = "black") +
  coord_polar("y", start = 0) +
  geom_text(aes(label = sprintf("%.1f%%", Proporcion)), position = position_stack(vjust = 0.5), fontface = "bold", size = 6) +
  scale_fill_manual(values = c("Informal" = "#f39c12", "Formal" = "#2ecc71")) +
  labs(title = "Composición del Empleo dentro del Sector Formal", fill = "Tipo de Empleo") +
  theme_void() + tema_con_marco
ggsave("output/grafico_c_composicion_formal_pay.png", p2_pay, width = 10, height = 7)

# INCISO D: DESAGREGACIÓN POR INDUSTRIA Y ESTADO
# Se Calcula la informalidad por Industria (SCIAN) y por Estado (ENT).

query_ind_est <- "SELECT scian, ent, mh_col, SUM(fac_tri) as total FROM enoe_data WHERE clase2 = 1 GROUP BY scian, ent, mh_col"
df_ie <- dbGetQuery(con, query_ind_est)
df_ie$es_informal <- ifelse(df_ie$mh_col %% 2 != 0, "Informal", "Formal")

# INFORMALIDAD POR INDUSTRIA
ind_data <- aggregate(total ~ scian + es_informal, data = df_ie, sum)
ind_wide <- reshape(ind_data, idvar = "scian", timevar = "es_informal", direction = "wide")
ind_wide[is.na(ind_wide)] <- 0
colnames(ind_wide) <- c("scian", "Formal", "Informal")
ind_wide$Tasa_Informalidad <- (ind_wide$Informal / (ind_wide$Formal + ind_wide$Informal)) * 100

scian_cat <- read.csv("input/scian.csv", encoding = "Latin-1")
ind_wide <- merge(ind_wide, scian_cat, by.x = "scian", by.y = "CVE", all.x = TRUE)

cat("\n--- TOP 10 INDUSTRIAS CON MAYOR INFORMALIDAD ---\n")
print(head(ind_wide[order(-ind_wide$Tasa_Informalidad), c("DESCRIP", "Tasa_Informalidad")], 10), row.names = FALSE)

#Grafica: Informalidad vs Industria
p_ind <- ggplot(ind_wide, aes(x = reorder(DESCRIP, Tasa_Informalidad), y = Tasa_Informalidad)) +
  geom_bar(stat = "identity", fill = "#e67e22", color = "black") +
  coord_flip() + labs(title = "Tasa de Informalidad por Industria (SCIAN)", x = "Industria", y = "Informalidad (%)") +
  tema_con_marco
ggsave("output/grafico_d_industria.png", p_ind, width = 12, height = 10)

# INFORMALIDAD POR ESTADO
est_data <- aggregate(total ~ ent + es_informal, data = df_ie, sum)
est_wide <- reshape(est_data, idvar = "ent", timevar = "es_informal", direction = "wide")
est_wide[is.na(est_wide)] <- 0
colnames(est_wide) <- c("ent", "Formal", "Informal")
est_wide$Tasa_Informalidad <- (est_wide$Informal / (est_wide$Formal + est_wide$Informal)) * 100

estados_nombres <- c("1"="Aguascalientes", "2"="Baja California", "3"="Baja California Sur", "4"="Campeche", "5"="Coahuila", "6"="Colima", "7"="Chiapas", "8"="Chihuahua", "9"="Ciudad de México", "10"="Durango", "11"="Guanajuato", "12"="Guerrero", "13"="Hidalgo", "14"="Jalisco", "15"="México", "16"="Michoacán", "17"="Morelos", "18"="Nayarit", "19"="Nuevo León", "20"="Oaxaca", "21"="Puebla", "22"="Querétaro", "23"="Quintana Roo", "24"="San Luis Potosí", "25"="Sinaloa", "26"="Sonora", "27"="Tabasco", "28"="Tamaulipas", "29"="Tlaxcala", "30"="Veracruz", "31"="Yucatán", "32"="Zacatecas")
est_wide$Estado <- estados_nombres[as.character(est_wide$ent)]

cat("\n--- TOP 5 ESTADOS CON MAYOR INFORMALIDAD ---\n")
print(head(est_wide[order(-est_wide$Tasa_Informalidad), c("Estado", "Tasa_Informalidad")], 5))

#Grafica: Informalidad vs Entidad Federativa
p_est <- ggplot(est_wide, aes(x = reorder(Estado, Tasa_Informalidad), y = Tasa_Informalidad)) +
  geom_bar(stat = "identity", fill = "#2980b9", color = "black") +
  coord_flip() + labs(title = "Tasa de Informalidad por Entidad Federativa", x = "Estado", y = "Informalidad (%)") +
  tema_con_marco
ggsave("output/grafico_d_estado.png", p_est, width = 10, height = 8)

# INCISOS E,F,G: Correlacion entre Informalidad, Salarios y Genero

query_corr <- "
SELECT t2.DESCRIP AS Industria, AVG(CASE WHEN t1.ingocup > 0 AND t1.ingocup < 999999 THEN t1.ingocup END) AS Salario_Promedio,
AVG(t1.eda) AS Edad_Promedio, AVG(CASE WHEN t1.sex = 2 THEN 1.0 ELSE 0.0 END) * 100 AS Porc_Mujeres,
AVG(CASE WHEN t1.mh_col % 2 != 0 THEN 1.0 ELSE 0.0 END) * 100 AS Tasa_Informalidad
FROM enoe_data AS t1
LEFT JOIN (SELECT 1 AS CVE, 'Agropecuario' AS DESCRIP UNION SELECT 2, 'Minería' UNION SELECT 3, 'Electricidad/Agua' UNION SELECT 4, 'Construcción' UNION SELECT 5, 'Manufacturas' UNION SELECT 6, 'Comercio Mayor' UNION SELECT 7, 'Comercio Minor' UNION SELECT 8, 'Transportes' UNION SELECT 9, 'Medios Masivos' UNION SELECT 10, 'Financieros' UNION SELECT 11, 'Inmobiliarios' UNION SELECT 12, 'Prof/Científicos' UNION SELECT 13, 'Corporativos' UNION SELECT 14, 'Apoyo a Negocios' UNION SELECT 15, 'Educativos' UNION SELECT 16, 'Salud/Asistencia' UNION SELECT 17, 'Esparcimiento' UNION SELECT 18, 'Hospedaje/Alimentos' UNION SELECT 19, 'Otros Servicios' UNION SELECT 20, 'Gobierno' UNION SELECT 21, 'No especificado') AS t2 ON t1.scian = t2.CVE
WHERE t1.clase2 = 1 GROUP BY t2.DESCRIP;"

stats_industria <- dbGetQuery(con, query_corr)
dbDisconnect(con) # Cerramos la conexión 

stats_industria <- stats_industria[!is.na(stats_industria$Industria), ]
stats_industria$Porc_Hombres <- 100 - stats_industria$Porc_Mujeres

# INCISO E: Grafica de Informalidad vs Salario
p_e <- ggplot(stats_industria, aes(x = Tasa_Informalidad, y = Salario_Promedio)) +
  geom_point(color = "#2c3e50", size = 4, alpha = 0.7) + geom_text(aes(label = Industria), vjust = -1, size = 2.5) +
  geom_smooth(method = "lm", color = "#e74c3c", se = TRUE) +
  labs(title = "Informalidad vs Salario por Industria", x = "Informalidad (%)", y = "Salario Promedio ($)") +
  tema_con_marco
ggsave("output/grafico_e_salario.png", p_e, width = 12, height = 7)

# INCISO F: Grafica de Edad vs Salario
p_f <- ggplot(stats_industria, aes(x = Edad_Promedio, y = Salario_Promedio)) +
  geom_point(color = "#27ae60", size = 4, alpha = 0.7) + geom_text(aes(label = Industria), vjust = -1, size = 2.5) +
  geom_smooth(method = "lm", color = "#2c3e50", se = TRUE) +
  labs(title = "Edad Promedio vs Salario por Industria", x = "Edad (Años)", y = "Salario Promedio ($)") +
  tema_con_marco
ggsave("output/grafico_f_edad.png", p_f, width = 12, height = 7)

# INCISO G: Grafica de composición por Género en Industrias Y Salario
p_g_stacked <- ggplot(stats_industria, aes(x = reorder(Industria, Porc_Mujeres))) +
  geom_bar(aes(y = Porc_Mujeres, fill = "Mujeres"), stat = "identity") +
  geom_bar(aes(y = -Porc_Hombres, fill = "Hombres"), stat = "identity") +
  geom_line(aes(y = Salario_Promedio/200, group = 1, color = "Salario (Escalado)"), size = 1.5) +
  coord_flip() + scale_fill_manual(values = c("Mujeres" = "#8e44ad", "Hombres" = "#3498db")) +
  scale_color_manual(values = c("Salario (Escalado)" = "#d35400")) +
  labs(title = "Género vs Salario por Industria", x = "Industria", y = "Hombres <--- % ---> Mujeres", fill = "Género", color = "Tendencia") +
  tema_con_marco
ggsave("output/grafico_g_stacked.png", p_g_stacked, width = 12, height = 8)

print("--- PROCESO FINALIZADO EXITOSAMENTE ---")