## Carga paquetes
pacman::p_load(
  tmap,
  sf,
  rio,
  janitor,
  tidyverse
)

# Carga base limpia pacientes
base_clean <- import("../clean/base_clean.xlsx")

# Carga capa GIS
deptos_sf <- st_read("../clean/Elevación, precipitaciones y temperaturas medias por departamento - Santa Fe.shp")

glimpse(deptos_sf)

# Limpia dataset
deptos_sf <- deptos_sf |> 
  # estandariza nombres columnas
  clean_names() |> 
  
  # cambia manualmente nombres columnas
  rename(
    altura_cat = categoria,
    precip_anual = precipitac,
    temp_anual_media = temperatur) |> 
  
  # cambia a mayúsculas nombres deptos
  mutate(dpto = toupper(dpto) |> 
           stringi::stri_trans_general(id = "Latin-ASCII") ) |> 
  
  # descarta columnas innecesarias
  select(dpto, altura_cat, precip_anual, temp_anual_media)

glimpse(deptos_sf)

# Une base y datos GIS
base_gis <- left_join(base_clean, deptos_sf,
                      by = c("depto_residencia" = "dpto"))

# Explora estructura base
class(base_gis)

# Genera mapa con sf ------------------------------------------------------
## Crea base casos por depto
casos_depto_gis <- base_gis |> 
  # transforma a objeto espacial
  st_as_sf() |> 
  
  # tabla de casos por departamento
  count(depto_residencia, altura_cat, precip_anual, temp_anual_media,
        resultado_tipo) |> 
  
  # filtra casos descartados
  filter(resultado_tipo == 1)

# Estructura de la nueva base
class(casos_depto_gis)

## Genera mapa
ggplot() +
  geom_sf(data =  deptos_sf) +
  geom_sf(data = casos_depto_gis, mapping = aes(fill =n)) +
  scale_fill_viridis_c(option = "magma", alpha = .5) +
  # facet_wrap(~ altura_cat) +
  # facet_wrap(~ cut(precip_anual, breaks = 4)) +
    theme_minimal()


# Mapa interactivo con tmap -----------------------------------------------
tmap_mode("view")

# Genero mapa
mapa_dinamico <- 
  # Mapa base
  tm_basemap(server = "OpenStreetMap") +
  
  # Capa departamentos
  tm_shape(shp = deptos_sf) +
  tm_borders() +
  
  # Capa casos por depto
  tm_shape(shp = casos_depto_gis) +
  tm_polygons(col = c("n", "precip_anual"))  +
  tm_facets(as.layers = T)

tmap_mode("plot")
mapa_dinamico
