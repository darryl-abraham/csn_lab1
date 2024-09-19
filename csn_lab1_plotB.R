#install.packages("igraph")
library(igraph)

n_vals <- 2^seq(1,20,2)
samples <- 2
p <- 0.3

avg_shortest_path <- vector(mode = "numeric", length = length(n_vals))

for (i in seq_along(n_vals)) {
  
  n <- n_vals[i]
  print(i)
  sp_sum <- 0
  
  for (j in 1:samples) {
    er_graph <- sample_gnp(n, p)
    sp_sum <- sp_sum + average.path.length(er_graph)
  }

  avg_shortest_path[i] <- sp_sum / samples
}

avg_shortest_path[is.na(avg_shortest_path)] <- 0
y_upper_limit <- ceiling(max(avg_shortest_path))


plot(n_vals, avg_shortest_path,
     ylab='average shortest path',
     xlab='num nodes',
     xlim = c(0, 1000000),
     ylim = c(0, y_upper_limit))
