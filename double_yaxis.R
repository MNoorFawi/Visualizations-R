library(ggplot2)
library(lubridate)
library(reshape2)
library(scales)

df <- data.frame(
  date = seq(ymd("2018-06-01"), ymd("2018-06-30"),
             by = "1 day"),
  avg = round(runif(30, 10, 20), 2),
  min = round(runif(30, 5, 10), 2),
  max = round(runif(30, 15, 30), 2),
  pre = round(runif(30, 0, 20), 2)
)
names(df) <-
  c(
    "date",
    "Average Temperature (*C)",
    "Min. Temperature (*C)",
    "Max. Temperature (*C)",
    "Precipitation (mm)"
  )
melted_data <-
  melt(df,
       id.vars = "date")
gg <-
  ggplot(melted_data[melted_data$variable != "Precipitation (mm)", ],
         aes(x = date,
             y = value,
             color = variable)) +
  geom_line() +
  scale_x_date(
    date_labels = "%d-%b-%Y",
    date_breaks = "3 days",
    date_minor_breaks = "1 day"
  ) +
  scale_colour_brewer(name = "", palette = "Set1") +
  geom_bar(
    data = melted_data[melted_data$variable == "Precipitation (mm)", ],
    aes(y = value, fill = "Precipitation (mm)"),
    stat = "identity",
    position = "identity",
    color = "grey77",
    alpha = 0.4,
    width = 0.5
  ) +
  theme_minimal() +
  scale_fill_manual(name = "",
                    values = c("grey80")) +
  # guides(color = guide_legend(ncol = 1)) +
  theme(
    axis.text.x = element_text(angle = 90),
    legend.position = "bottom",
    legend.direction = "vertical",
    legend.key.size = unit(0.4, "cm"),
    plot.title = element_text(hjust = 0.5)
  ) +
  labs(title = "Plot with Two Y Axes", x = "", y = "[*C]") +
  scale_y_continuous(breaks = pretty_breaks(n = 10),
                     sec.axis = sec_axis(~ . * 1, name = "[mm]"))
gg
ggsave("plot.png", width = 8, height = 5)
