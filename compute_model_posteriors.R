
out_file = "model_comparison_results.txt"

log = read.table("output/rj_model.log", header=TRUE, sep="\t", stringsAsFactors=FALSE)

total_samples = length(log$rate_01)
m1_rate_samples = length(which(log$rate_01 == log$rate_10))
m01_irreversible = length(which(log$rate_01 == 0))
m10_irreversible = length(which(log$rate_10 == 0))
m2_rate_samples = total_samples - (m1_rate_samples + m01_irreversible + m10_irreversible)

write("Model posterior probabilities:", file=out_file)
write(paste("01 irreversible: ", round(m01_irreversible / total_samples, 2), sep=""), file=out_file, append=TRUE)
write(paste("10 irreversible: ", round(m10_irreversible / total_samples, 2), sep=""), file=out_file, append=TRUE)
write(paste("1 rate: ", round(m1_rate_samples / total_samples, 2), sep=""), file=out_file, append=TRUE)
write(paste("2 rate: ", round(m2_rate_samples / total_samples, 2), sep=""), file=out_file, append=TRUE)
write("", file=out_file, append=TRUE)

write(paste("BF 1/2: ", round((m1_rate_samples/total_samples)/(m2_rate_samples/total_samples), 2), sep=""), file=out_file, append=TRUE)
write(paste("BF 2/1: ", round((m2_rate_samples/total_samples)/(m1_rate_samples/total_samples), 2), sep=""), file=out_file, append=TRUE)