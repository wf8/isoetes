
library(ggplot2)

sites = c(1, 5, 10, 50, 100)
reps = 10
x = c()
y = c()

for (i in 1:length(sites)) {
    for (j in 1:reps) {

        log_file = paste("output/upp_sim_", sites[i], "_", j, ".log", sep="")
        log = read.table(log_file, header=TRUE, sep="\t", stringsAsFactors=FALSE)
        y = c(y, length(which(log$rate_10 == 0))/1000)
        x = c(x, sites[i])
    }
}

data = data.frame(x, y)
data$density = fields::interp.surface(
    MASS::kde2d(data$x, data$y), data[,c("x", "y")])

p = ggplot(data, aes(x=x, y=y, color=y, alpha=1/density)) + ylim(0, 1.0) + 
    geom_point(shape=16, size=5, show.legend=FALSE) +
    scale_x_continuous("Number of Sites", c(1,5,10,50,100), c(1,5,10,50,100)) +
    labs(y="Posterior Probability") + 
    scale_color_gradient(low="#32aeff", high="#f2aeff") +
    scale_alpha(range = c(.25, .6)) +
    geom_line(stat="smooth", method="lm", show.legend=FALSE, alpha=0.3, color="darkblue", size=1) +
    geom_ribbon(stat="smooth", method="lm", se=TRUE, alpha=0.1, show.legen=FALSE) +
    guides(colour="none")


print(p)
ggsave("simulation_results.pdf", width=8, height=6)

