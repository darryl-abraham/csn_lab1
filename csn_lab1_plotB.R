#install.packages("igraph")
library(igraph)

n_vals <- 2^seq(1, 18, 1)
samples <- 2
p <- 0

avg_shortest_path <- vector(mode = "numeric", length = length(n_vals))

for (i in seq_along(n_vals)) {
  
  n <- n_vals[i]
  sp_sum <- 0
  p <- 1.0000001 * log(n)/n

  for (j in 1:samples) {
    er_graph <- sample_gnp(n, p)
    sp <- average.path.length(er_graph)
    sp[is.nan(sp)] <- 0
    sp_sum <- sp_sum + sp
  }

  avg_shortest_path[i] <- sp_sum / samples
}

avg_shortest_path[is.na(avg_shortest_path)] <- 0
y_upper_limit <- ceiling(max(avg_shortest_path))
x_upper_limit <- ceiling(max(n_vals))

plot(n_vals, avg_shortest_path,
     ylab='average shortest path',
     xlab='num nodes',
     xlim = c(0, x_upper_limit),
     ylim = c(0, y_upper_limit),
     type = "b")
