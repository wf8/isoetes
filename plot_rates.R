
library(ggplot2)
library(scales)

log = read.table("output/upp_model.log", header=TRUE, sep="\t", stringsAsFactors=FALSE)

data = data.frame(rate=c(log$rate_01, log$rate_10), type=rep(c("Trilobate to bilobate", "Bilobate to trilobate"), each=length(log$rate_01)))

p = ggplot(data, aes(x=rate, fill=type)) + 
          labs(x="Rate", y="Posterior Density") + 
          geom_density(alpha = 0.4) + 
          guides(fill = guide_legend(title = "Transition Rates")) +
          geom_vline(xintercept = mean(log$rate_01), linetype = "longdash", color=hue_pal()(2)[2]) +
          geom_vline(xintercept = mean(log$rate_10), linetype = "longdash", color=hue_pal()(2)[1]) 

print(p)

ggsave("transition_rates.pdf", width=8, height=6)
