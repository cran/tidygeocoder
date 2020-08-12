## ---- echo = FALSE, message = FALSE-------------------------------------------
knitr::opts_chunk$set(collapse = T, comment = "#>")
options(tibble.print_min = 4L, tibble.print_max = 4L)
set.seed(42)

## ----setup, warning = FALSE, message = FALSE----------------------------------
library(tibble)
library(DT)
library(dplyr)
library(tidygeocoder)

address_single <- tibble(singlelineaddress = c('11 Wall St, NY, NY', 
                    '600 Peachtree Street NE, Atlanta, Georgia'))
address_components <- tribble(
  ~street                      , ~cty,               ~st,
  '11 Wall St',                  'NY',               'NY',
  '600 Peachtree Street NE',     'Atlanta',          'GA'
)

## -----------------------------------------------------------------------------
address_single %>% geocode(address = singlelineaddress, method = 'census',
                           verbose = TRUE)

## -----------------------------------------------------------------------------
geo(address = address_single$singlelineaddress, method = 'osm', 
    lat = latitude, long = longitude)

## -----------------------------------------------------------------------------
address_components %>% geocode(street = street, city = cty, state = st,
                               method = 'census')

## -----------------------------------------------------------------------------
addr_comp1 <- address_components %>% 
  bind_rows(tibble(cty = c('Toronto', 'Tokyo'), country = c('Canada', 'Japan')))

addr_comp1 %>% geocode(street = street, state = st, city = cty,
                       country = country, method = 'cascade')

## -----------------------------------------------------------------------------
census_full1 <- address_single %>% geocode(address = singlelineaddress, 
      method = 'census', full_results = TRUE, return_type = 'geographies')
glimpse(census_full1)

## -----------------------------------------------------------------------------
salz <- geo('Salzburg, Austria', method = 'osm', full_results = TRUE)
glimpse(salz)

## -----------------------------------------------------------------------------
duplicate_addrs <- address_single %>%
  bind_rows(address_single) %>%
  bind_rows(tibble(singlelineaddress = rep(NA, 3)))

duplicates_geocoded <- duplicate_addrs %>%
  geocode(singlelineaddress, verbose = T)

knitr::kable(duplicates_geocoded)

## -----------------------------------------------------------------------------
duplicate_addrs %>%
  geocode(singlelineaddress, unique_only = TRUE)

## -----------------------------------------------------------------------------
geo_limit <- geo(c('Lima, Peru', 'Cairo, Egypt'), method = 'osm', 
    limit = 3, full_results = TRUE)
glimpse(geo_limit)

## -----------------------------------------------------------------------------
cairo_geo <- geo('Cairo, Egypt', method = 'osm', full_results = TRUE,
    custom_query = list(polygon_geojson = 1), verbose = TRUE)
glimpse(cairo_geo)

## -----------------------------------------------------------------------------
geo(c('Vancouver, Canada', 'Las Vegas, NV'), no_query = TRUE, 
    method = 'osm')

## ---- echo = FALSE------------------------------------------------------------
api_parameter_reference %>% 
  select(-required) %>%
  mutate(across(c(method, generic_name, api_name), as.factor)) %>%
  datatable(filter = 'top', rownames = FALSE, 
  options = list(lengthMenu = c(5, 8, 12, nrow(.)), pageLength = 12, autoWidth = TRUE))

