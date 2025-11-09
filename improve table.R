iris %>%
  group_by(Species) %>%
  summarize(petal_width = list(Petal.Width)) %>%
  reactable(.,
            columns = list(petal_width = colDef(cell = react_sparkline(.,
                                                                       line_curve = "linear",
                                                                       decimals = 1,
                                                                       highlight_points = highlight_points(first="orange",last="blue"),
                                                                       labels = c("first","last")))))

# https://kcuilla.github.io/reactablefmtr/reference/react_sparkline.html