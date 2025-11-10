library(shiny); library(reactable); library(htmltools)

data <- data.frame(
  disease = "Stroke", trend = "↑ 16%", y23 = "41,388",
  y37 = "47,975", daly = "21K → 24K", pounds = "Upward", cost = "£4.46B"
)

cell <- function(title, main, sub, delta=NULL, up=TRUE){
  div(style="padding:6px 8px;",
      div(style="font-size:11px;color:#6c757d;text-transform:uppercase;", title),
      div(style="font-size:20px;font-weight:700;line-height:1.1;", main),
      if(!is.null(delta)) span(
        style=paste0("display:inline-block;margin:4px 6px 0 0;padding:1px 6px;border-radius:999px;",
                     if(up) "background:#e8f5e9;color:#2e7d32" else "background:#fdecea;color:#c62828"),
        delta
      ),
      div(style="font-size:11px;color:#6c757d;margin-top:2px;", sub)
  )
}

ui_reactable <- fluidPage(
  tags$style(HTML("
    .rt-table, .rt-thead, .rt-tbody, .rt-tr, .rt-td, .rt-th{border:none!important}
    .ReactTable .rt-tbody .rt-tr-group{border-bottom:0}
    .ReactTable{-webkit-font-smoothing:antialiased}
  ")),
  reactable(
    data, outlined = FALSE, bordered = FALSE, defaultPageSize = 1, pagination = FALSE,
    rownames = FALSE, defaultColDef = colDef(html = TRUE, align = "left"),
    columns = list(
      disease = colDef(name = "", cell = \(val) cell("Disease", "Stroke","2023–2037","▲ +6,587", TRUE)),
      trend   = colDef(name = "", cell = \(val) cell("Trend", "↑ 16%","smoothed trend")),
      y23     = colDef(name = "", cell = \(val) cell("2023", "41,388","CI 41,134–41,642")),
      y37     = colDef(name = "", cell = \(val) cell("2037", "47,975","CI 43,179–52,771")),
      daly    = colDef(name = "", cell = \(val) cell("Burden", "21K → 24K","DALYs 2023→2037")),
      pounds  = colDef(name = "", cell = \(val) cell("£ Trends", "Rising","Healthcare costs")),
      cost    = colDef(name = "", cell = \(val) cell("Cost (cum.)", "£4.46B","£224M 2023 • £393M 2037"))
    )
  )
)
# server <- \(input, output, session) {}
# shinyApp(ui_reactable, server)