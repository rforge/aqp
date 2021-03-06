\name{fetchOSD}
\alias{fetchOSD}

\title{Fetch Official Series Description (OSD) Data}
\description{This functions fetches a limited subset of horizon and site-level attributes for named soil series, from the SoilWeb system.}
\usage{
fetchOSD(soils)
}

\arguments{
  \item{soils}{a character vector of named soil series}
}
\details{the search is case-insensitive}
\value{a \code{SoilProfileCollection} object containing basic soil morphology and taxonomic information.}
\references{
\url{http://www.nrcs.usda.gov/wps/portal/nrcs/site/soils/home/}
}
\author{D.E. Beaudette}
\note{SoilWeb maintains a snapshot of the Official Series Description data. Please use the link above for the live data.}


\examples{
\dontrun{
# soils of interest
s.list <- c('musick', 'cecil', 'drummer', 'amador', 'pentz', 
'reiff', 'san joaquin', 'montpellier', 'grangeville', 'pollasky', 'ramona')

# fetch and convert data into an SPC
s <- fetchOSD(s.list)

# plot profiles
# moist soil colors
par(mar=c(0,0,0,0))
plot(s, name='hzname', cex.names=0.85, axis.line.offset=-4)
}
}

\keyword{manip}
