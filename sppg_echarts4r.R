library(tidyverse)
library(dplyr)
library(echarts4r)

model_specification = list()

model_specification$model$number_of_runs = 15
model_specification$population$scale_down_factor = 475/0.3
show_survivor_prevalence_by_discrete_states <- function(input_population, morbidity, ...) {
  # this will show total number of survivors
  # not the total number of strokes - of which ppl can have multiple

  input_population |>
    group_by(run) |>

    # must group by and sum by run
    # and then average by other facets

    group_by(...,.add = T) |>
    summarise(counted_states = sum({{morbidity}} != 0), # !=0
              population = n(),
              .groups = "drop") |>

    #   2.	For each year, compute
    # •	the mean of those counts
    # •	the standard deviation (sd) of those counts
    # •	the number of runs (n)
    # •	the standard error (se = sd/√n)
    # •	a 95 % CI via mean ± t₀.₀₇₅, (n − 1) × se

    group_by(...) |>
    summarise(mean_counted_states = mean(counted_states), # !=0
              sd = sd(counted_states),
              se = sd/sqrt(model_specification$model$number_of_runs),
              # 95% t‐interval; df = runs - 1
              ci_lower    = mean_counted_states - qt(0.975, df = model_specification$model$number_of_runs - 1) * se,
              ci_upper    = mean_counted_states + qt(0.975, df = model_specification$model$number_of_runs - 1) * se,
              .groups = "drop")

}

# 1. Prepare data: numeric year

# past_populations <- read.csv("past_populations/past_populations_sppg_undefined.csv")
HF_populations <- past_populations <- read.fst('past_populations_sppg_undefined_reduced.fst')
# read.fst("past_populations/past_populations_sppg_undefined.fst")

# past_populations %>% sample_frac(0.3) %>%
# write.fst("past_populations/past_populations_sppg_undefined_reduced.fst")



# HF_populations <- read.csv("past_populations/past_populations_sppg_undefined.csv")

trusts <- c("Belfast HSCT", "Northern HSCT","Southern HSCT", "Western HSCT","South Eastern HSCT")
morbidities <- c("atrial_fibrillation","lung_cancer","chronic_kidney_disease","chd","dementia",
                 "hypertension","stroke","diabetes","heart_failure")

plot_echart_sppg_morbidity_facet <- function(input_population,
                                             morbidity,
                                             trust = "Northern HSCT",
                                             model_specification = model_specification
                                             ) {
  print(morbidity)

chart_data <-
  show_survivor_prevalence_by_discrete_states(
    input_population = input_population,
    morbidity = morbidity,
    year,
    HSCT
    #grouping_var = !!sym("year")
  ) |>
    mutate(mean_counted_states_scaled_to_population = mean_counted_states * model_specification$population$scale_down_factor) |>
    mutate(ci_upper_counted_states_scaled_to_population = ci_upper * model_specification$population$scale_down_factor) |>
    mutate(ci_lower_counted_states_scaled_to_population = ci_lower * model_specification$population$scale_down_factor)

  print(chart_data)


  chart_data |>
    e_charts(
      x        = year,
      # don’t force zero on y-axis
    ) |>
    e_title(paste("Projected", gsub("_", " ", morbidity), "prevalence"),
            subtext = trust) |>
    e_tooltip(
      trigger     = "axis",
      axisPointer = list(type = "shadow"),
      formatter   = htmlwidgets::JS("
        function(params){
          var year = params[0].value[0]
          window.params = params;

          var ciLow  = Math.round(params[0].value[1])
          var prev   = Math.round(params[2].value[1])
          var ciHigh = Math.round(params[1].value[1]/2)+prev

          return year + '<br/>'
               + '<b>Prevalence:</b> ' + prev + '<br/>'
               + '<b>95% CI:</b> ' + ciLow + ' – ' + ciHigh + '';
        }
      ")
    ) |>
    # 1) ribbon (CI band)
    e_band(
      min    = ci_lower_counted_states_scaled_to_population,
      max    = ci_upper_counted_states_scaled_to_population,
      # fill style: soft blue with 30% opacity
      areaStyle = list(
        list(color = "rgba(70,130,180,0)"),       # lower half invisible
        list(color = "rgba(70,130,180,0.3)")      # upper half semi-opaque
      ),
      # thin border on top of ribbon
      itemStyle = list(
        borderColor = "rgba(70,130,180,0.5)",
        borderWidth = 1
      )
    ) |>

    # 2) main prevalence line with markers
    e_line(tooltip = list(show=T),
      serie      = mean_counted_states_scaled_to_population,
      name       = "Prevalence",
      symbol     = "circle",
      symbolSize = 6,
      lineStyle  = list(
        width = 2.5,
        color = "#4682B4"
      ),
      itemStyle  = list(
        color = "#4169E1",
        borderColor = "#ffffff",
        borderWidth = 1
      )
    ) |>

    # 3) axes & grid

    e_y_axis(
      name        = "Prevalence",
      splitLine   = list(
        lineStyle = list(type = "dashed", opacity = 0.4)
      )
    ) |>
    e_grid(
      top        = "15%",
      bottom     = "12%",
      left       = "10%",
      right      = "10%"
    ) |>

    # 4) tooltip & legend

    e_legend(
      top     =     '5%',
      right        = "5%",
      orient     = "horizontal"
    )
}

# plot_echart_sppg_morbidity_facet(past_populations, trust = 'Belfast HSCT', morbidity = atrial_fibrillation)

  trusts <- c("Belfast HSCT", "Northern HSCT","Southern HSCT", "Western HSCT","South Eastern HSCT")
  morbidities <- c('atrial_fibrillation','lung_cancer','chronic_kidney_disease','chd','dementia',
                   'hypertension','stroke','diabetes','heart_failure'#,
                   #'asthma', 'copd'
  )

  generate_prevalence_charts <- function(input_population,
                                         trust,
                                         morbidity,
                                         scale_down_factor = model_specification$population$scale_down_factor,
                                         save_plots = FALSE,
                                         output_dir = "./plot_figure_echarts") {

    require(dplyr)
    require(echarts4r)
    require(rlang)
    require(htmlwidgets)

    dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

    # for (trust in trusts) {
    #   for (morbidity in morbidities) {

        # Filter population
        filtered_data <- input_population |>
          filter(HSCT == trust)

        # Calculate prevalence
        chart_data <- show_survivor_prevalence_by_discrete_states(
          input_population = filtered_data,
          morbidity = !!sym(morbidity),
          year
          #grouping_var = !!sym("year")
        ) |>
          mutate(
            mean_counted_states_scaled_to_population = mean_counted_states * scale_down_factor,
            ci_upper_counted_states_scaled_to_population = ci_upper * scale_down_factor,
            ci_lower_counted_states_scaled_to_population = ci_lower * scale_down_factor
          )

        # Skip if empty
        if (nrow(chart_data) == 0) next

        # Build chart
        chart <- chart_data |>
          e_charts(year) |>
          e_title(paste("Projected", gsub("_", " ", morbidity), "prevalence"),
                  subtext = trust) |>
          e_tooltip(
            trigger = "axis",
            axisPointer = list(type = "shadow"),
            formatter = htmlwidgets::JS("
            function(params){
              var year = params[0].value[0];
              var ciLow  = Math.round(params[0].value[1]);
              var prev   = Math.round(params[2].value[1]);
              var ciHigh = Math.round(params[1].value[1]/2) + prev;
              return year + '<br/>'
                   + '<b>Prevalence:</b> ' + prev + '<br/>'
                   + '<b>95% CI:</b> ' + ciLow + ' – ' + ciHigh;
            }
          ")
          ) |>
          e_band(
            min = ci_lower_counted_states_scaled_to_population,
            max = ci_upper_counted_states_scaled_to_population,
            areaStyle = list(
              list(color = "rgba(70,130,180,0)"),
              list(color = "rgba(70,130,180,0.3)")
            ),
            itemStyle = list(
              borderColor = "rgba(70,130,180,0.5)",
              borderWidth = 1
            )
          ) |>
          e_line(
            serie = mean_counted_states_scaled_to_population,
            name = "Prevalence",
            symbol = "circle",
            symbolSize = 6,
            lineStyle = list(width = 2.5, color = "#4682B4"),
            itemStyle = list(color = "#4169E1", borderColor = "#ffffff", borderWidth = 1)
          ) |>
          e_y_axis(name = "Prevalence", splitLine = list(lineStyle = list(type = "dashed", opacity = 0.4))) |>
          e_grid(top = "15%", bottom = "12%", left = "10%", right = "10%") |>
          e_legend(top = "5%", right = "5%", orient = "horizontal")

        print(chart)

        if (save_plots) {
          filename <- file.path(output_dir, paste0(trust, "_", morbidity, "_prevalence.html")) #|>
            # gsub(" ", "_" ) |>
            # gsub("__", "_") #|>
          htmlwidgets::saveWidget(widget = chart, file = filename, selfcontained = TRUE)
        }
    #   }
    # }
  }



generate_prevalence_charts(input_population = past_populations,
                             trust = 'Belfast HSCT',
                             morbidity = 'stroke',
                             save_plots = TRUE)


# show_survivor_prevalence_by_discrete_states(
#     input_population = filtered_data,
#     morbidity = !!sym(morbidity),
#     year
#     #grouping_var = !!sym("year")
#   )


chart_data <- show_survivor_prevalence_by_discrete_states(
    input_population = past_populations,
    morbidity = heart_failure,
    year,
    HSCT
    #grouping_var = !!sym("year")
  ) |>
    mutate(mean_counted_states_scaled_to_population = mean_counted_states * model_specification$population$scale_down_factor) |>
    mutate(ci_upper_counted_states_scaled_to_population = ci_upper * model_specification$population$scale_down_factor) |>
    mutate(ci_lower_counted_states_scaled_to_population = ci_lower * model_specification$population$scale_down_factor)


chart_data |>
  mutate(year = as.character(year)) |>
  group_by(HSCT) |>
  e_charts(year) |>
  # e_title(paste("Projected", gsub("_", " ", morbidity), "prevalence"),
          # subtext = trust) |>
  e_tooltip(
    trigger = "axis",
    axisPointer = list(type = "shadow"),
    formatter = htmlwidgets::JS("
            function(params){
              var year = params[0].value[0];
              var ciLow  = Math.round(params[0].value[1]);
              var prev   = Math.round(params[2].value[1]);
              var ciHigh = Math.round(params[1].value[1]/2) + prev;
              return year + '<br/>'
                   + '<b>Prevalence:</b> ' + prev + '<br/>'
                   + '<b>95% CI:</b> ' + ciLow + ' – ' + ciHigh;
            }
          ")
  ) |>

   # e_band(
   #   min = ci_lower_counted_states_scaled_to_population,
   #   max = ci_upper_counted_states_scaled_to_population,
   #   areaStyle = list(
   #     list(color = "rgba(70,130,180,0)"),
   #     list(color = "rgba(70,130,180,0.3)")
   #   ),
   #   itemStyle = list(
   #     borderColor = "rgba(70,130,180,0.5)",
   #     borderWidth = 1
   #   )
   # ) |>

  e_line(
    serie = mean_counted_states_scaled_to_population,
    name = "Prevalence",
    symbol = "circle",
    symbolSize = 6,
    lineStyle = list(width = 2.5, color = "#4682B4"),
    itemStyle = list(color = "#4169E1", borderColor = "#ffffff", borderWidth = 1)
  )# |>
   # e_facet(rows = 2, cols=3, legend_pos = "top", legend_space = 12)
  # e_y_axis(name = "Prevalence", splitLine = list(lineStyle = list(type = "dashed", opacity = 0.4))) |>
  # e_grid(top = "15%", bottom = "12%", left = "10%", right = "10%") |>
  # e_legend(top = "5%", right = "5%", orient = "horizontal")



####################################################################################
####################################################################################

  # group_size <- 20
  # n_groups <- 13
  # df <- data.frame("day" = rep(1:group_size, times=n_groups),
  #                  "temperature" = runif(group_size * n_groups, 10, 40),
  #                  "location" = rep(LETTERS[1:n_groups], each=group_size))
  #
  #
  # df |>
  #   group_by(location) |>
  #   e_charts(day) |>
  #   e_line(temperature) |>
  #   e_facet(rows = 4, cols=4, legend_pos = "top", legend_space = 12)

################################################################################
################################################################################
################################################################################
################################################################################
  # at the top of your script/app
options(knitr.in.progress = F)


# then e_arrange() will *not* bring in bootstrap 4
  e_facet <- function(input_population, morbidity = heart_failure, facet = HSCT, ...,  cols = 4,save_plots=T) {

    input_population <- input_population %>%
    mutate(age20 = factor(age20,
                  levels = c("0-20", "20-40", "40-60", "60-80", "80-100", "100-120"),
                  labels = c("0-19", "20-39", "40-59", "60-79", "80-99", "100-119")))

    input_population <- input_population %>%
      mutate(mdm_quintile = factor(mdm_quintile,
                            levels = c(5,4,3,2,1),
                            labels = c("Most Affluent", "Second Most Affluent", "Middle", "Second Most Deprived", "Most Deprived")))


    facet_sym <- enquo(facet)
    facet_name <- as_name(facet_sym)

    facets <- unique(input_population |>
                       pull({{facet}}))

    morbidity_sym <- enquo(morbidity)
    morbidity_name <- as_name(morbidity_sym)

  print(facets)
    #print(morbidity)
  print(length(facets))

  chart_data <-
      show_survivor_prevalence_by_discrete_states(
        input_population = input_population,
        morbidity = !!morbidity_sym,
        year,
        ...
        #grouping_var = !!sym("year")
      ) |>
      mutate(mean_counted_states_scaled_to_population = mean_counted_states * model_specification$population$scale_down_factor) |>
      mutate(ci_upper_counted_states_scaled_to_population = ci_upper * model_specification$population$scale_down_factor) |>
      mutate(ci_lower_counted_states_scaled_to_population =  ci_lower * model_specification$population$scale_down_factor)

    print(chart_data)



    library(tidyverse)

    plots <- chart_data %>%
      mutate(year = as.character(year)) |>
      mutate(
        L      = ci_lower_counted_states_scaled_to_population, #l + base,      # lower bound baseline
        U_band = ci_upper_counted_states_scaled_to_population - ci_lower_counted_states_scaled_to_population, #u - l,         # height of the band
        V      = mean_counted_states_scaled_to_population #value + base   # main series
      ) %>%
      group_split(!!facet_sym) %>%
      imap(.f = function(j, k) {
        #print(j);
        j %>%
          group_by(!!facet_sym) %>%
          e_charts(height = '200px',width = '100%', year,#, name = paste0("chart_", )
                   emphasis = list(focus = 'series')
                   ) %>%
          e_line(mean_counted_states_scaled_to_population,
                 name =  j |> pull(!!facet_sym) |> head(1),
                 itemStyle = list(color = pastel_colors[k])) %>%
          e_grid(top = "10%", bottom = "30%", left = "15%", right = "10%") |>
          #
          e_tooltip(
            backgroundColor='white',
            trigger = "axis",
            axisPointer = list(type = "shadow"),
            formatter = htmlwidgets::JS("
            function(params){
              var year = params[0].value[0];
              //console.log(params);
              //window.params = params;

              var ciHigh = Math.round(params[0].value[1]);
              var ciLow  = Math.round(params[1].value[1]);
              var prev   = Math.round(params[2].value[1]);
              return year + '<br/>'
                   + '<b>Prevalence:</b> ' + prev + '<br/>'
                   + '<b>95% CI:</b> ' + ciLow + ' – ' + ciHigh;
            }
          ")
          ) |>
          # e_band2(legend =F,
          #   ci_lower_counted_states_scaled_to_population,
          #   ci_upper_counted_states_scaled_to_population,
          #   itemStyle = list(color =  pastel_colors[k],#'lightgreen',
          #                    borderWidth = 0,
          #                    opacity = 0.6)
          #   ) #|>
          # e_text_style(fontSize = 1)






        # chart_data %>%
        #   mutate(
        #     L      = ci_lower_counted_states_scaled_to_population, #l + base,      # lower bound baseline
        #     U_band = ci_upper_counted_states_scaled_to_population - ci_lower_counted_states_scaled_to_population, #u - l,         # height of the band
        #     V      = mean_counted_states_scaled_to_population #value + base   # main series
        #   ) %>%
          #mutate(year =as.character(year)) %>%
          #e_charts(year) %>%
          # Invisible baseline for the stack
          e_line(legend=F,
            L, name = "L",
            stack = "confidence-band",
            symbol = "none",
            lineStyle = list(opacity = 0)
          ) %>%
          # The filled band (stacked on L)
          e_line(legend=F,
            U_band,
            name = "U",
            stack = "confidence-band",
            symbol = "none",
            lineStyle = list(opacity = 0),

            areaStyle = list(color =  pastel_colors[k],#'lightgreen',
                    borderWidth = 0,
                    opacity = 0.6)
          ) %>%
          e_theme('auritus')

          # The main line
          # e_line(
          #   V, name = "Value",
          #   showSymbol = FALSE,
          #   itemStyle = list(color = NULL)
          # ) #%>%
          # e_tooltip(trigger = "axis") %>%
          # e_legend(right = 10)



      }) # %>%
      #append(c(rows = 2, cols = 4 )) %>%
      #do.call(e_arrange, .)

    print(class(plots))

    # Wrap in flex container
    flex_container <- htmltools::div(
      style = 'display: flex; flex-wrap: wrap; gap: 0.2rem;',
      lapply(plots, function(p) {
        htmltools::div(
          style = sprintf(
            # 'flex: 4 0 %s;
            # max-width: 250px;', paste0(round(100/(cols), 2), '%')
            'flex: 4 0;
            justify-content:center;
            align-items:center;
            max-width: 250px;'
            ),
          p
        )
      })
    )

    #plots

    # output_dir = "./plot_figure_echarts"
    # dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)
    # if (save_plots) {
    #   filename <- file.path(output_dir, paste0(facet_name, "_", morbidity_name, "_prevalence.html")) #|>
    #   # gsub(" ", "_" ) |>
    #   # gsub("__", "_") #|>
    #   htmlwidgets::saveWidget(widget = flex_container, file = filename, selfcontained = F)
    # }

  }

  pastel_colors <- c(
    "#AEC6CF", # pastel blue
    "#FFB347", # pastel orange
    "#77DD77", # pastel green
    "#FF6961", # pastel red
    "#F49AC2", # pastel pink
    "#CBAACB", # pastel purple
    "#FFFFB3", # pastel yellow
    "#B0E0E6"  # pastel cyan
  )
  ################################################################################
  ################################################################################
  ################################################################################
  past_populations |> #filter(HSCT == 'Belfast HSCT') |>
    e_facet( morbidity = stroke, facet = HSCT,         HSCT         ) |> shiny::fluidPage() |>  htmltools::browsable()
  stroke_HSCT          <-  e_facet(past_populations, morbidity = stroke, facet = HSCT,         HSCT         );   htmltools::browsable(stroke_HSCT)
  # stroke_HSCT[[1]]$dependencies
  stroke_age20         <-  e_facet(past_populations, morbidity = stroke, facet = age20,        age20        );   htmltools::browsable(stroke_age20)
  stroke_sex           <-  e_facet(past_populations, morbidity = stroke, facet = sex,          sex          )
  stroke_mdm_quintile  <-  e_facet(past_populations, morbidity = stroke, facet = mdm_quintile, mdm_quintile );  htmltools::browsable(stroke_mdm_quintile)
  heart_failure_HSCT          <-  e_facet(HF_populations, morbidity = heart_failure, facet = HSCT,         HSCT         )
  heart_failure_age20         <-  e_facet(HF_populations, morbidity = heart_failure, facet = age20,        age20        )
  heart_failure_sex           <-  e_facet(HF_populations, morbidity = heart_failure, facet = sex,          sex          )
  heart_failure_mdm_quintile  <-  e_facet(HF_populations, morbidity = heart_failure, facet = mdm_quintile, mdm_quintile )
  atrial_fibrillation_HSCT          <-  e_facet(past_populations, morbidity = atrial_fibrillation, facet = HSCT,         HSCT         )
  atrial_fibrillation_age20         <-  e_facet(past_populations, morbidity = atrial_fibrillation, facet = age20,        age20        )
  atrial_fibrillation_sex           <-  e_facet(past_populations, morbidity = atrial_fibrillation, facet = sex,          sex          )
  atrial_fibrillation_mdm_quintile  <-  e_facet(past_populations, morbidity = atrial_fibrillation, facet = mdm_quintile, mdm_quintile )
  hypertension_HSCT          <-  e_facet(past_populations, morbidity = hypertension, facet = HSCT,         HSCT         )
  hypertension_age20         <-  e_facet(past_populations, morbidity = hypertension, facet = age20,        age20        )
  hypertension_sex           <-  e_facet(past_populations, morbidity = hypertension, facet = sex,          sex          )
  hypertension_mdm_quintile  <-  e_facet(past_populations, morbidity = hypertension, facet = mdm_quintile, mdm_quintile )
  lung_cancer_HSCT          <-  e_facet(past_populations, morbidity = lung_cancer, facet = HSCT,         HSCT         )
  lung_cancer_age20         <-  e_facet(past_populations, morbidity = lung_cancer, facet = age20,        age20        )
  lung_cancer_sex           <-  e_facet(past_populations, morbidity = lung_cancer, facet = sex,          sex          )
  lung_cancer_mdm_quintile  <-  e_facet(past_populations, morbidity = lung_cancer, facet = mdm_quintile, mdm_quintile )
  chd_HSCT          <-  e_facet(past_populations, morbidity = chd, facet = HSCT,         HSCT         )
  chd_age20         <-  e_facet(past_populations, morbidity = chd, facet = age20,        age20        )
  chd_sex           <-  e_facet(past_populations, morbidity = chd, facet = sex,          sex          )
  chd_mdm_quintile  <-  e_facet(past_populations, morbidity = chd, facet = mdm_quintile, mdm_quintile )
  chronic_kidney_disease_HSCT          <-  e_facet(past_populations, morbidity = chronic_kidney_disease, facet = HSCT,         HSCT         )
  chronic_kidney_disease_age20         <-  e_facet(past_populations, morbidity = chronic_kidney_disease, facet = age20,        age20        )
  chronic_kidney_disease_sex           <-  e_facet(past_populations, morbidity = chronic_kidney_disease, facet = sex,          sex          )
  chronic_kidney_disease_mdm_quintile  <-  e_facet(past_populations, morbidity = chronic_kidney_disease, facet = mdm_quintile, mdm_quintile )
  dementia_HSCT          <-  e_facet(past_populations, morbidity = dementia, facet = HSCT,         HSCT         )
  dementia_age20         <-  e_facet(past_populations, morbidity = dementia, facet = age20,        age20        )
  dementia_sex           <-  e_facet(past_populations, morbidity = dementia, facet = sex,          sex          )
  dementia_mdm_quintile  <-  e_facet(past_populations, morbidity = dementia, facet = mdm_quintile, mdm_quintile )
  diabetes_HSCT          <-  e_facet(past_populations, morbidity = diabetes, facet = HSCT,         HSCT         )
  diabetes_age20         <-  e_facet(past_populations, morbidity = diabetes, facet = age20,        age20        )
  diabetes_sex           <-  e_facet(past_populations, morbidity = diabetes, facet = sex,          sex          )
  diabetes_mdm_quintile  <-  e_facet(past_populations, morbidity = diabetes, facet = mdm_quintile, mdm_quintile )

  save(stroke_HSCT ,stroke_age20 ,stroke_sex ,stroke_mdm_quintile ,heart_failure_HSCT ,heart_failure_age20 ,heart_failure_sex ,heart_failure_mdm_quintile ,atrial_fibrillation_HSCT ,atrial_fibrillation_age20 ,atrial_fibrillation_sex ,atrial_fibrillation_mdm_quintile ,hypertension_HSCT ,hypertension_age20 ,hypertension_sex ,hypertension_mdm_quintile ,lung_cancer_HSCT ,lung_cancer_age20 ,lung_cancer_sex ,lung_cancer_mdm_quintile ,chd_HSCT ,chd_age20 ,chd_sex ,chd_mdm_quintile ,chronic_kidney_disease_HSCT ,chronic_kidney_disease_age20 ,chronic_kidney_disease_sex ,chronic_kidney_disease_mdm_quintile ,dementia_HSCT ,dementia_age20 ,dementia_sex ,dementia_mdm_quintile ,diabetes_HSCT ,diabetes_age20 ,diabetes_sex ,diabetes_mdm_quintile,
       file = "sppg_new.RData")
  #save.image() # creating ".RData" in current working directory
  # unlink("sppg.RData")

  chart_data |>
    mutate(year = as.character(year)) |>
    group_by(HSCT) |>
    e_charts(year, emphasis = list(focus = 'series' )) |>
      e_tooltip(
        trigger = "axis",
        axisPointer = list(type = "shadow"),
        formatter = htmlwidgets::JS("
            function(params){
              var year = params[0].value[0];
              var ciLow  = Math.round(params[0].value[1]);
              var prev   = Math.round(params[2].value[1]);
              var ciHigh = Math.round(params[1].value[1]/2) + prev;
              return year + '<br/>'
                   + '<b>Prevalence:</b> ' + prev + '<br/>'
                   + '<b>95% CI:</b> ' + ciLow + ' – ' + ciHigh;
            }
          ")
      ) |>
    e_band2(
      ci_lower_counted_states_scaled_to_population,
      ci_upper_counted_states_scaled_to_population,
      itemStyle = list(borderWidth = 0, opacity = 0.3),
      )     |>
    e_line(
      mean_counted_states_scaled_to_population,

           ) %>%
    e_theme('auritus') %>%
    e_color(c("#AEC6CF", "#FFB347", "#77DD77", "#FF6961", "#F49AC2", "#CBAACB", "#FFFFB3", "#B0E0E6"))










