# Preassignment 2
As your pre-assignment, I’ll ask you to download R and install a few packages. __Please actually do this in advance as it can take a while!__ I’ll also ask you to download a few datasets that we’ll use for the main assignment. If you’re new to R I’ve also explained where you can find resources to smooth the introduction.

1. First follow the instructions at [this link](https://posit.co/download/rstudio-desktop/#download) in order to install R and R studio.
2. Then install the following libraries using the `install.packages()` command
   * plyr
   * dplyr
   * tidyverse
   * ggalluvial
   * RColorBrewer
   * ggtext
   * stringr
   * readxl
   * leaflet
   * vroom
   * sf
   * data.table
   * htmlwidgets
   * broom
   * lubridate
   * ggtext
   * purrr
3. Ensure all packages have been successfully installed by running the following code:
```
library(plyr)
library(dplyr)
library(tidyverse)
library(ggalluvial)
library(RColorBrewer)
library(ggtext)
library(stringr)
library(readxl)
library(leaflet)
library(vroom)
library(sf)
library(data.table)
library(htmlwidgets)
library(broom)
library(lubridate)
library(ggtext)
library(purrr)
```
4. Now download the following datasets:
   * [2020 zip code shape files](https://www.census.gov/cgi-bin/geo/shapefiles/index.php?year=2020&layergroup=ZIP%20Code%20Tabulation%20Areas)
   * [2020 census tract shape files](https://www.census.gov/cgi-bin/geo/shapefiles/index.php)
   * [2020 census data on race by census tract](https://data.census.gov/table/DECENNIALCD1182020.P9?q=P9)
   * [CMS NPI registry](https://data.cms.gov/provider-data/dataset/mj5m-pzi6)
   * [ACS 2023 Age and Sex data by zip code](https://data.census.gov/table?q=s0101&g=010XX00US$8600000)
   * Ensure you see the following files in the GitHub: listings.csv, prices_modeled.csv, transplant_codes.csv, kidpan_ctr_ids.csv
5. All the packages we’ll use in class are well established with solid documentation (typically available through cran) and it should be easy to find tips and cheat sheets online. For more comprehensive coverage I recommend
   * [R for Data Science](https://r4ds.hadley.nz/)
   * [Advanced R](https://adv-r.hadley.nz/)


