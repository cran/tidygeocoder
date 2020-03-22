## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup,warning=F,message=F------------------------------------------------
library(dplyr)
library(tidygeocoder)
library(knitr)

## ----geocode,warning=F--------------------------------------------------------
lat_longs <- sample_addresses %>% 
  geocode(addr,lat=latitude,long=longitude)

## ----display------------------------------------------------------------------
kable(lat_longs)

## ----map,fig.width=8,fig.height=5,warning=F,message=F-------------------------
if ((require("ggplot2") & require("maps") & require("ggrepel"))) {

ggplot(lat_longs %>% filter(!is.na(longitude)),aes(longitude,latitude),color="grey98") +
  borders("state") +
  theme_classic() +
  geom_point() +
  theme(line = element_blank(),
        text = element_blank(),
        title = element_blank()) +
  geom_label_repel(aes(label =name),show.legend=F) +
  scale_x_continuous(breaks = NULL) + 
  scale_y_continuous(breaks = NULL)
}
#ggsave("us_map.png",width=8,height=5)

## ----warning=F----------------------------------------------------------------
cascade_points <- sample_addresses %>% 
  geocode(addr,method='cascade')

## ----display-cascade,warning=F------------------------------------------------
kable(cascade_points)

