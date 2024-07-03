### Introducción R tidyverse: Trabajo práctico final
### Estudiante:
### Fecha:

# Carga paquetes ----------------------------------------------------------
pacman::p_load(
  tmap,
  sf,
  gtsummary,
  skimr,
  janitor,
  stringi,
  rio,
  tidyverse
)

# Carga datos crudos ------------------------------------------------------
msal_2020 <- import("raw/msal_dengue_zika_2020.xlsx")

msal_2021 <- import("raw/msal_dengue_zika_2021.xlsx")

msal_2022 <- read_csv2("raw/msal_dengue_zika_2022.csv", 
                    locale = locale(encoding = "WINDOWS-1252"))

msal_2023 <- import("raw/msal_dengue_zika_2023.csv")

msal_2024 <- read_csv2("raw/msal_dengue_zika_2024.csv", 
                    locale = locale(encoding = "WINDOWS-1252"))


# Limpieza de datos -------------------------------------------------------
## dengue 2020 ----
msal_2020_clean <- msal_2020 |> 
  
  # estandariza nombres de columnas
  clean_names() |> 
  rename(departamento = departamento_nombre,
         provincia = provincia_nombre,
         periodo = ano,
         semana_epi = semanas_epidemiologicas,
         grupo_edad = grupo_edad_id,
         casos = cantidad_casos) |> 
  
  # corrige formato departamento
  mutate(across(.cols = c(departamento, grupo_edad),
                .fns = ~ str_to_upper(.x) |>  
                  stringi::stri_trans_general(id = "Latin-ASCII"))) |> 
  # reemplaza NAs
  mutate(departamento = if_else(departamento %in% c("#!VALOR!", "(EN BLANCO)","*SIN DATO*",
                                                    "++++++++++++", "2007"), NA, departamento),
         grupo_edad = na_if(grupo_edad, "SIN ESPECIFICAR")) |> 
  
  # recategoriza grupo edad
  mutate(grupo_edad_cat = case_when(
    grupo_edad %in% c("DE 10 A 14 ANOS", "DE 15 A 19 ANOS") ~ "10-19 años",
    grupo_edad %in% c("DE 20 A 24 ANOS", "DE 25 A 34 ANOS") ~ "20-34 años",
    grupo_edad %in% c("DE 35 A 44 ANOS", "DE 45 A 65 ANOS") ~ "35-65 años",
    grupo_edad == "MAYORES DE 65 ANOS" ~ "65+ años",
    TRUE ~ "0-9 años"
  )) |> 
  
  # filtra datos dengue CABA y PBA
  filter(evento_nombre == "Dengue" & provincia == "Buenos Aires") |> 
  
  # descarta columnas innecesarias
  select(provincia, departamento, periodo, semana_epi, grupo_edad_cat, casos) |> 
  
  # descarta NAs
  drop_na()


## Explora base
names(msal_2020)

skim(msal_2020_clean)

tabyl(msal_2020_clean$departamento)

tabyl(msal_2020_clean$grupo_edad)

tabyl(msal_2020_clean$grupo_edad_cat)


## dengue 2021 ----
msal_2021_clean <- msal_2021 |> 
  # estandariza nombres de columna
  clean_names() |> 
  rename(departamento = departamento_nombre,
         provincia = provincia_id,
         periodo = ano,
         semana_epi = semanas_epidemiologicas,
         grupo_edad = grupo_edad_desc,
         casos = cantidad_casos) |> 
  
  # corrige formato departamento
  mutate(across(.cols = c(departamento, grupo_edad),
                .fns = ~ str_to_upper(.x) |>  
                  stringi::stri_trans_general(id = "Latin-ASCII"))) |> 
  # reemplaza NAs
  mutate(departamento = if_else(departamento %in% c("#!VALOR!", "(EN BLANCO)","*SIN DATO*",
                                                    "++++++++++++", "2007"), NA, departamento),
         grupo_edad = na_if(grupo_edad, "SIN ESPECIFICAR")) |> 
  
  # recategoriza grupo edad
  mutate(grupo_edad_cat = case_when(
    grupo_edad %in% c("DE 10 A 14 ANOS", "DE 15 A 19 ANOS") ~ "10-19 años",
    grupo_edad %in% c("DE 20 A 24 ANOS", "DE 25 A 34 ANOS") ~ "20-34 años",
    grupo_edad %in% c("DE 35 A 44 ANOS", "DE 45 A 65 ANOS") ~ "35-65 años",
    grupo_edad == "MAYORES DE 65 ANOS" ~ "65+ años",
    TRUE ~ "0-9 años"
  )) |> 
  
  # filtra datos dengue CABA y PBA
  filter(evento_nombre == "Dengue" & provincia == "Buenos Aires") |> 
  
  # descarta columnas innecesarias
  select(provincia, departamento, periodo, semana_epi, grupo_edad_cat, casos) |> 
  
  # descarta NAs
  drop_na()

## Explora base
names(msal_2021)

skim(msal_2021_clean)

tabyl(msal_2021_clean$departamento)

tabyl(msal_2021_clean$grupo_edad)

tabyl(msal_2021_clean$grupo_edad_cat)

# dengue 2022 ----
msal_2022_clean <- msal_2022 |>
  # estandariza nombres de columna
  clean_names() |>
  rename(departamento = departamento_nombre,
         provincia = provincia_nombre,
         periodo = ano,
         semana_epi = semanas_epidemiologicas,
         grupo_edad = grupo_edad_desc,
         casos = cantidad_casos) |>

  # corrige formato departamento
  mutate(across(.cols = c(departamento, grupo_edad),
                .fns = ~ str_to_upper(.x) |>  
                  stringi::stri_trans_general(id = "Latin-ASCII"))) |> 
  # reemplaza NAs
  mutate(departamento = if_else(departamento %in% c("#!VALOR!", "(EN BLANCO)","*SIN DATO*",
                                                    "++++++++++++", "2007"), NA, departamento),
         grupo_edad = na_if(grupo_edad, "SIN ESPECIFICAR")) |> 
  
  # recategoriza grupo edad
  mutate(grupo_edad_cat = case_when(
    grupo_edad %in% c("DE 10 A 14 ANOS", "DE 15 A 19 ANOS") ~ "10-19 años",
    grupo_edad %in% c("DE 20 A 24 ANOS", "DE 25 A 34 ANOS") ~ "20-34 años",
    grupo_edad %in% c("DE 35 A 44 ANOS", "DE 45 A 65 ANOS") ~ "35-65 años",
    grupo_edad == "MAYORES DE 65 ANOS" ~ "65+ años",
    TRUE ~ "0-9 años"
  )) |> 
  
  # filtra datos dengue CABA y PBA
  filter(evento_nombre == "Dengue" & provincia == "Buenos Aires") |> 
  
  # descarta columnas innecesarias
  select(provincia, departamento, periodo, semana_epi, grupo_edad_cat, casos) |> 
  
  # descarta NAs
  drop_na()

## Explora base
names(msal_2022)

skim(msal_2022_clean)

tabyl(msal_2022_clean$departamento)

tabyl(msal_2022_clean$grupo_edad)

tabyl(msal_2022_clean$grupo_edad_cat)


## dengue 2023 ----
msal_2023_clean <- msal_2023 |> 
  # estandariza nombres de columna
  clean_names() |> 
  rename(departamento = departamento_residencia,
         provincia = provincia_residencia,
         periodo = anio_min,
         semana_epi = sepi_min,
         grupo_edad = grupo_etario,
         casos = cantidad) |> 
  
  # corrige formato departamento
  mutate(across(.cols = c(departamento, grupo_edad),
                .fns = ~ str_to_upper(.x) |>  
                  stringi::stri_trans_general(id = "Latin-ASCII"))) |> 
  # reemplaza NAs
  mutate(departamento = if_else(departamento %in% c("#!VALOR!", "(EN BLANCO)","*SIN DATO*",
                                                    "++++++++++++", "2007"), NA, departamento),
         grupo_edad = na_if(grupo_edad, "SIN ESPECIFICAR")) |> 
  
  # recategoriza grupo edad
  mutate(grupo_edad_cat = case_when(
    grupo_edad %in% c("DE 10 A 14 ANOS", "DE 15 A 19 ANOS") ~ "10-19 años",
    grupo_edad %in% c("DE 20 A 24 ANOS", "DE 25 A 34 ANOS") ~ "20-34 años",
    grupo_edad %in% c("DE 35 A 44 ANOS", "DE 45 A 65 ANOS") ~ "35-65 años",
    grupo_edad == "MAYORES DE 65 ANOS" ~ "65+ años",
    TRUE ~ "0-9 años"
  )) |> 
  
  # filtra datos dengue CABA y PBA
  filter(evento == "Dengue" & provincia == "Buenos Aires") |> 
  
  # descarta columnas innecesarias
  select(provincia, departamento, periodo, semana_epi, grupo_edad_cat, casos) |> 
  
  # descarta NAs
  drop_na()


## Explora base
names(msal_2023)

skim(msal_2023_clean)

tabyl(msal_2023_clean$departamento)

tabyl(msal_2023_clean$grupo_edad)

tabyl(msal_2023_clean$grupo_edad_cat)


## dengue 2024 ----
msal_2024_clean <- msal_2024 |> 
  # estandariza nombres de columna
  clean_names() |> 
  rename(departamento = departamento_residencia,
         provincia = provincia_residencia,
         periodo = anio_min,
         semana_epi = sepi_min,
         grupo_edad = grupo_etario,
         casos = cantidad) |> 
  
  # corrige formato departamento
  mutate(across(.cols = c(departamento, grupo_edad),
                .fns = ~ str_to_upper(.x) |>  
                  stringi::stri_trans_general(id = "Latin-ASCII"))) |> 
  # reemplaza NAs
  mutate(departamento = if_else(departamento %in% c("#!VALOR!", "(EN BLANCO)","*SIN DATO*",
                                                    "++++++++++++", "2007"), NA, departamento),
         grupo_edad = na_if(grupo_edad, "SIN ESPECIFICAR")) |> 
  
  # recategoriza grupo edad
  mutate(grupo_edad_cat = case_when(
    grupo_edad %in% c("DE 10 A 14 ANOS", "DE 15 A 19 ANOS") ~ "10-19 años",
    grupo_edad %in% c("DE 20 A 24 ANOS", "DE 25 A 34 ANOS") ~ "20-34 años",
    grupo_edad %in% c("DE 35 A 44 ANOS", "DE 45 A 65 ANOS") ~ "35-65 años",
    grupo_edad == "MAYORES DE 65 ANOS" ~ "65+ años",
    TRUE ~ "0-9 años"
  )) |> 
  
  # filtra datos dengue CABA y PBA
  filter(evento == "Dengue" & provincia == "Buenos Aires") |> 
  
  # descarta columnas innecesarias
  select(provincia, departamento, periodo, semana_epi, grupo_edad_cat, casos) |> 
  
  # descarta NAs
  drop_na()


## Explora base
names(msal_2024)

skim(msal_2024_clean)

tabyl(msal_2024_clean$departamento)

tabyl(msal_2024_clean$grupo_edad)

tabyl(msal_2024_clean$grupo_edad_cat)


# Unión de datasets -------------------------------------------------------
msal_dengue <- bind_rows(msal_2020_clean, msal_2021_clean, msal_2022_clean,
                         msal_2023_clean, msal_2024_clean)

## Exporta base limpia
export(msal_dengue, file = "msal_dengue_2020_2024.xlsx")

## Limpia environment
rm(list = ls())

# Tablas de resumen -------------------------------------------------------
## Carga datos limpios
msal_dengue <- import("msal_dengue_2020_2024.xlsx")

## Tablas
msal_dengue |> 
  group_by(departamento, grupo_edad_cat) |> 
  summarise(casos = sum(casos, na.rm = T))

msal_dengue |> 
  group_by(departamento, periodo, grupo_edad_cat) |> 
  summarise(casos = sum(casos, na.rm = T))


msal_dengue |> 
  group_by(departamento, periodo, semana_epi, grupo_edad_cat) |> 
  summarise(casos = sum(casos, na.rm = T))


msal_dengue |> 
  tbl_summary(by = grupo_edad_cat,
              include = casos)

## Total casos 
casos_dengue <- msal_dengue |> 
  group_by(departamento, periodo, semana_epi, grupo_edad_cat) |> 
  summarise(casos = sum(casos, na.rm = T)) |> 
  ungroup()

# Gráficos exploratorios --------------------------------------------------


# Mapa de casos -----------------------------------------------------------

