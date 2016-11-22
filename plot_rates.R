
library(ggplot2)

log = read.table("output/rj_model.log", header=TRUE, sep="\t", stringsAsFactors=FALSE)

data = data.frame(rate=c(log$rate_01, log$rate_10), type=rep(c("Trilobate to bilobate", "Bilobate to trilobate"), each=length(log$rate_01)))

p = ggplot(data, aes(x=rate, fill=type)) + 
          labs(x="Rate", y="Posterior Density") + 
          geom_density(alpha = 0.4) + 
          guides(fill = guide_legend(title = "Transition Rates"))

print(p)

ggsave("transition_rates.pdf", width=8, height=6)
