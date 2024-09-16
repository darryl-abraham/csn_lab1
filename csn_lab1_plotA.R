#install.packages("igraph")
library(igraph)

p_vals <- 10^(seq(-4,0,0.2))
n <- 10

avg_clustering <- vector(mode = "numeric", length = length(p_vals))
avg_shortest_path <- vector(mode = "numeric", length = length(p_vals))

for (i in seq_along(p_vals)) {
  p <- p_vals[i]
  trans_sum <- 0
  sp_sum <- 0
  for (j in 1:n) {
    print(i)
    ws_graph <- sample_smallworld(1, 1000, 4, p)
    trans <- transitivity(ws_graph, type = "undirected", vids = NULL,
                          weights = NULL)
    sp <- average.path.length(ws_graph)
    trans_sum <- trans_sum + trans
    sp_sum <- sp_sum + sp
  }
  avg_clustering[i] <- trans_sum / n
  avg_shortest_path[i] <- sp_sum / n
  print(trans_sum/n)
  print(avg_clustering)
}

#Normalize them
trans <- avg_clustering/avg_clustering[1]
sp <- avg_shortest_path/avg_shortest_path[1]

x = data.frame(v1 = p_vals, v2 = sp, v3 = trans)

plot(p_vals,trans, ylim = c(0,1), ylab='coeff', log='x')
points(p_vals,sp, ylim = c(0,1), ylab='coeff',pch=15)
