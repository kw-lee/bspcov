% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/summary.bspcov.R
\name{summary.bspcov}
\alias{summary.bspcov}
\title{Summary of Posterior Distribution}
\usage{
\method{summary}{bspcov}(object, cols, rows, ...)
}
\arguments{
\item{object}{an object from \strong{bandPPP}, \strong{bmspcov}, \strong{sbmspcov}, and \strong{thresPPP}.}

\item{cols}{a scalar or a vector including specific column indices.}

\item{rows}{a scalar or a vector including specific row indices greater than or equal to columns indices.}
}
\description{
Provides the summary statistics for posterior samples of covariance matrix.
}
\note{
If both \code{cols} and \code{rows} are vectors, they must have the same length.
}
\examples{

\dontrun{
set.seed(1)
n <- 100
p <- 20

# generate a sparse covariance matrix:
True.Sigma <- matrix(0, nrow = p, ncol = p)
diag(True.Sigma) <- 1
Values <- -runif(n = p*(p-1)/2, min = 0.2, max = 0.8)
nonzeroIND <- which(rbinom(n=p*(p-1)/2,1,prob=1/p)==1)
zeroIND = (1:(p*(p-1)/2))[-nonzeroIND]
Values[zeroIND] <- 0
True.Sigma[lower.tri(True.Sigma)] <- Values
True.Sigma[upper.tri(True.Sigma)] <- t(True.Sigma)[upper.tri(True.Sigma)]
if(min(eigen(True.Sigma)$values) <= 0){
  delta <- -min(eigen(True.Sigma)$values) + 1.0e-5
  True.Sigma <- True.Sigma + delta*diag(p)
}

# generate a data
X <- MASS::mvrnorm(n = n, mu = rep(0, p), Sigma = True.Sigma)

# compute sparse, positive covariance estimator:
fout <- bspcov::sbmspcov(X = X, Sigma = diag(diag(cov(X))))
summary(fout, cols = c(1, 3, 4), rows = c(1, 3, 4))
#summary(fout, cols = 1, rows = 1:p)}

}
\author{
Seongil Jo
}
