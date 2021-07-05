Week 27
================
Nabil Murtadha
04/07/2021

## Tidytuesday week 27

Tidytuesday é um movimento de engaiamento onde toda semana é liberada um
`data base` para a comunidade demonstrar suas habilidades

A semana 27 é sobre a base de dados sobre Animais resgatados feito pelo
[Governo de
Londres](URL(https://data.london.gov.uk/dataset/animal-rescue-incidents-attended-by-lfb))

*Carregando os dados*

``` r
#install.packages("tidytuesdayR")
tuesdata <- tidytuesdayR::tt_load(2021, week = 27)
```

    ## 
    ##  Downloading file 1 of 1: `animal_rescues.csv`

``` r
animal_rescues <- tuesdata$animal_rescues
```

As variáveis estão representada pela tabela abaixo. Após de limpar a
base com o pacote `janitor` como recomendado pelo
[Tidytuesday](URL(https://github.com/rfordatascience/tidytuesday/blob/master/data/2021/2021-06-29/readme.md))

``` r
#Tornando os nomes das variáveis mais amigáveis
janitor::clean_names(animal_rescues)
```

    ## # A tibble: 7,544 x 31
    ##    incident_number date_time_of_call cal_year fin_year type_of_incident
    ##              <dbl> <chr>                <dbl> <chr>    <chr>           
    ##  1          139091 01/01/2009 03:01      2009 2008/09  Special Service 
    ##  2          275091 01/01/2009 08:51      2009 2008/09  Special Service 
    ##  3         2075091 04/01/2009 10:07      2009 2008/09  Special Service 
    ##  4         2872091 05/01/2009 12:27      2009 2008/09  Special Service 
    ##  5         3553091 06/01/2009 15:23      2009 2008/09  Special Service 
    ##  6         3742091 06/01/2009 19:30      2009 2008/09  Special Service 
    ##  7         4011091 07/01/2009 06:29      2009 2008/09  Special Service 
    ##  8         4211091 07/01/2009 11:55      2009 2008/09  Special Service 
    ##  9         4306091 07/01/2009 13:48      2009 2008/09  Special Service 
    ## 10         4715091 07/01/2009 21:24      2009 2008/09  Special Service 
    ## # ... with 7,534 more rows, and 26 more variables: pump_count <chr>,
    ## #   pump_hours_total <chr>, hourly_notional_cost <dbl>,
    ## #   incident_notional_cost <chr>, final_description <chr>,
    ## #   animal_group_parent <chr>, originof_call <chr>, property_type <chr>,
    ## #   property_category <chr>, special_service_type_category <chr>,
    ## #   special_service_type <chr>, ward_code <chr>, ward <chr>,
    ## #   borough_code <chr>, borough <chr>, stn_ground_name <chr>, uprn <chr>,
    ## #   street <chr>, usrn <chr>, postcode_district <chr>, easting_m <chr>,
    ## #   northing_m <chr>, easting_rounded <dbl>, northing_rounded <dbl>,
    ## #   latitude <chr>, longitude <chr>

``` r
knitr::kable(head(animal_rescues))
```

| incident\_number | date\_time\_of\_call | cal\_year | fin\_year | type\_of\_incident | pump\_count | pump\_hours\_total | hourly\_notional\_cost | incident\_notional\_cost | final\_description | animal\_group\_parent            | originof\_call     | property\_type                               | property\_category | special\_service\_type\_category | special\_service\_type                               | ward\_code | ward                           | borough\_code | borough              | stn\_ground\_name | uprn        | street         | usrn     | postcode\_district | easting\_m | northing\_m | easting\_rounded | northing\_rounded | latitude    | longitude    |
|-----------------:|:---------------------|----------:|:----------|:-------------------|:------------|:-------------------|-----------------------:|:-------------------------|:-------------------|:---------------------------------|:-------------------|:---------------------------------------------|:-------------------|:---------------------------------|:-----------------------------------------------------|:-----------|:-------------------------------|:--------------|:---------------------|:------------------|:------------|:---------------|:---------|:-------------------|:-----------|:------------|-----------------:|------------------:|:------------|:-------------|
|           139091 | 01/01/2009 03:01     |      2009 | 2008/09   | Special Service    | 1           | 2                  |                    255 | 510                      | Redacted           | Dog                              | Person (land line) | House - single occupancy                     | Dwelling           | Other animal assistance          | Animal assistance involving livestock - Other action | E05011467  | Crystal Palace & Upper Norwood | E09000008     | Croydon              | Norbury           | NULL        | Waddington Way | 20500146 | SE19               | NULL       | NULL        |           532350 |            170050 | NULL        | NULL         |
|           275091 | 01/01/2009 08:51     |      2009 | 2008/09   | Special Service    | 1           | 1                  |                    255 | 255                      | Redacted           | Fox                              | Person (land line) | Railings                                     | Outdoor Structure  | Other animal assistance          | Animal assistance involving livestock - Other action | E05000169  | Woodside                       | E09000008     | Croydon              | Woodside          | NULL        | Grasmere Road  | NULL     | SE25               | 534785     | 167546      |           534750 |            167550 | 51.39095371 | -0.064166887 |
|          2075091 | 04/01/2009 10:07     |      2009 | 2008/09   | Special Service    | 1           | 1                  |                    255 | 255                      | Redacted           | Dog                              | Person (mobile)    | Pipe or drain                                | Outdoor Structure  | Animal rescue from below ground  | Animal rescue from below ground - Domestic pet       | E05000558  | Carshalton Central             | E09000029     | Sutton               | Wallington        | NULL        | Mill Lane      | NULL     | SM5                | 528041     | 164923      |           528050 |            164950 | 51.36894086 | -0.161985191 |
|          2872091 | 05/01/2009 12:27     |      2009 | 2008/09   | Special Service    | 1           | 1                  |                    255 | 255                      | Redacted           | Horse                            | Person (mobile)    | Intensive Farming Sheds (chickens, pigs etc) | Non Residential    | Animal rescue from water         | Animal rescue from water - Farm animal               | E05000330  | Harefield                      | E09000017     | Hillingdon           | Ruislip           | 1.00021E+11 | Park Lane      | 21401484 | UB9                | 504689     | 190685      |           504650 |            190650 | 51.60528344 | -0.489683853 |
|          3553091 | 06/01/2009 15:23     |      2009 | 2008/09   | Special Service    | 1           | 1                  |                    255 | 255                      | Redacted           | Rabbit                           | Person (mobile)    | House - single occupancy                     | Dwelling           | Other animal assistance          | Animal assistance involving livestock - Other action | E05000310  | Gooshays                       | E09000016     | Havering             | Harold Hill       | NULL        | Swindon Lane   | 21300122 | RM3                | NULL       | NULL        |           554650 |            192350 | NULL        | NULL         |
|          3742091 | 06/01/2009 19:30     |      2009 | 2008/09   | Special Service    | 1           | 1                  |                    255 | 255                      | Redacted           | Unknown - Heavy Livestock Animal | Person (land line) | House - single occupancy                     | Dwelling           | Other animal assistance          | Animal assistance involving livestock - Other action | E05000027  | Alibon                         | E09000002     | Barking and Dagenham | Dagenham          | NULL        | Rogers Road    | 19900321 | RM10               | NULL       | NULL        |           549350 |            184950 | NULL        | NULL         |
