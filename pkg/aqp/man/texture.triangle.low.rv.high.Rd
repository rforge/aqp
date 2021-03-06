\name{texture.triangle.low.rv.high}
\alias{texture.triangle.low.rv.high}

\title{Soil Texture Low-RV-High as Defined by Quantiles}
\description{This function accepts soil texture components (sand, silt, and clay percentages) and plots a soil texture triangle with a "representative value" (point) and low-high region (polygon) defined by quantiles. Marginal quantiles of sand, silt, and clay are used to define the boundary of a low-high region that encloses a severall likely soil texture classes based on the values in \code{ssc}. The defualt settings place the RV symbol at the texture defined by marginal medians of sand, silt, and clay. The default low-high region is defined by the 5th and 95th marginal percentiles of sand, silt, and clay.}

\usage{
texture.triangle.low.rv.high(ssc, p=c(0.05, 0.5, 0.95), delta=1, 
pop.rv.col='red', range.col='RoyalBlue', range.alpha=75, 
sim=FALSE, sim.n=1000, sim.rv.col='yellow', sim.col=grey(0.95), 
sim.alpha=150, legend.cex=0.75, ...)
}

\arguments{
  \item{ssc}{a matrix-like object with columns: 'sand', 'silt', 'clay', values are percentages that should add to 100.}
  \item{p}{percentiles defining 'low', 'representative value', and 'high'}
  \item{delta}{step-size used to form low-high region}
  \item{pop.rv.col}{the symbol color used to denote the population representative value on the texture triangle}
  \item{range.col}{color of the polygon enclosing the low-high region}
  \item{range.alpha}{transparency of the low-high range polygon (0-255)}
  \item{sim}{optional simulation of low-rv-high values based on a composition drawn from normal distributions, this requires the `compositions` package}
  \item{sim.n}{number of simulated sand, silt, and clay values}
  \item{sim.rv.col}{the symbol color used to denote the simulated representative value on the texture triangle}
  \item{sim.col}{color of the simulated low-high range polygon}
  \item{sim.alpha}{transparency of the simulated low-high range polygon (0-255)}
  \item{legend.cex}{scaling factor for legend}
  \item{\dots}{further arguments passed to \code{triax.points}}
}

\note{Simulation of samd, silt, and clay values requires the `compositions` package.}

\details{Simulated sand, silt, and clay values are based on sampling from a normal distribution as performed by \code{rnorm.acomp} in the `comppositions` package. The mean vector of the sand, silt, and clay values, along with covariance matrix derived from \code{ssc} are used to parametrize sampling.}

\value{A high-level plot as generated by \code{soil.texture}.}

\author{D.E. Beaudette}

\seealso{
\code{\link{triax.points}, \link{soil.texture}}
}
\examples{
# sample data
data(loafercreek, package='soilDB')

# extract sand, silt, clay proportions
x <- na.omit(data.frame(sand=loafercreek$sand, silt=loafercreek$silt, clay=loafercreek$clay))

# test out the function
texture.triangle.low.rv.high(x, p=c(0.05, 0.5, 0.95))
texture.triangle.low.rv.high(x, p=c(0.25, 0.5, 0.75), range.col='darkgreen')

# simulate compositional data from source data
if(require(compositions)) {
  # add simulated low-rv-high
  texture.triangle.low.rv.high(x, p=c(0.05, 0.5, 0.95), sim=TRUE)
}

}

\keyword{hplot}

