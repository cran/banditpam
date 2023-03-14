## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, echo = FALSE------------------------------------------------------
library(banditpam)
library(ggplot2)

## -----------------------------------------------------------------------------
set.seed(10)
n_per_cluster <- 40
means <- list(c(0, 0), c(-5, 5), c(5, 5))
X <- do.call(rbind, lapply(means, MASS::mvrnorm, n = n_per_cluster, Sigma = diag(2)))

## -----------------------------------------------------------------------------
obj <- KMedoids$new(k = 3)

## -----------------------------------------------------------------------------
set.seed(198)
obj$fit(data = X, loss = "l2")

## -----------------------------------------------------------------------------
med_indices <- obj$get_medoids_final()

## ---- fig.cap="Clustering with 3-mediods with L2 loss"------------------------
d <- as.data.frame(X); names(d) <- c("x", "y")
dd <- d[med_indices, ]
ggplot(data = d) +
  geom_point(aes(x, y)) +
  geom_point(aes(x, y), data = dd, color = "red")

## -----------------------------------------------------------------------------
obj$fit(data = X, loss = "l1")  # L1 loss
med_indices <- obj$get_medoids_final()

## ---- echo = FALSE, fig.cap="Clustering with 3-mediods with L1 loss"----------
d <- as.data.frame(X); names(d) <- c("x", "y")
dd <- d[med_indices, ]
ggplot(data = d) +
  geom_point(aes(x, y)) +
  geom_point(aes(x, y), data = dd, color = "red")

## -----------------------------------------------------------------------------
obj$get_statistic("dist_computations") # no of dist computations
obj$get_statistic("cache_misses") #  no of cache misses

