% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/st_connect.R
\name{st_connect}
\alias{st_connect}
\title{Create lines between features of two layers}
\usage{
st_connect(x, y, ids = st_nn(x, y, ...), progress = TRUE, ...)
}
\arguments{
\item{x}{Object of class \code{sf} or \code{sfc}}

\item{y}{Object of class \code{sf} or \code{sfc}}

\item{ids}{A sparse list representation of features to connect, such as returned by function \code{\link{st_nn}}}

\item{progress}{Display progress bar? (default `TRUE`)}

\item{...}{Other arguments passed to \code{st_nn} such as \code{k} and \code{maxdist}}
}
\value{
Object of class \code{sfc} with geometry type \code{LINESTRING}
}
\description{
Create lines between features of two layers
}
\examples{
# Nearest 'city' per 'town'
l = st_connect(towns, cities)
plot(st_geometry(towns), col = "darkgrey")
plot(st_geometry(l), add = TRUE)
plot(st_geometry(cities), col = "red", add = TRUE)

# Ten nearest 'towns' per 'city'
l = st_connect(cities, towns, k = 10)
plot(st_geometry(towns), col = "darkgrey")
plot(st_geometry(l), add = TRUE)
plot(st_geometry(cities), col = "red", add = TRUE)

# Nearest 'city' per 'town', search radius of 30 km
cities = st_transform(cities, 32636)
towns = st_transform(towns, 32636)
l = st_connect(cities, towns, k = nrow(towns), maxdist = 30000)
plot(st_geometry(towns), col = "darkgrey")
plot(st_geometry(l), add = TRUE)
plot(st_buffer(st_geometry(cities), units::set_units(30, km)), border = "red", add = TRUE)

# The 20-nearest towns for each water body
water = st_transform(water, 32636)
l = st_connect(water[-1, ], towns, k = 20)
plot(st_geometry(water[-1, ]), col = "lightblue", border = NA)
plot(st_geometry(towns), col = "darkgrey", add = TRUE)
plot(st_geometry(l), col = "red", add = TRUE)

\dontrun{

# The 2-nearest water bodies for each town
l = st_connect(towns, water[-1, ], k = 2)
plot(st_geometry(water[-1, ]), col = "lightblue", border = NA)
plot(st_geometry(towns), col = "darkgrey", add = TRUE)
plot(st_geometry(l), col = "red", add = TRUE)

# The 2-nearest water bodies for each water body
l = st_connect(water, water, k = 2)
plot(st_geometry(water), col = "lightblue")
plot(st_geometry(towns), col = "darkgrey", add = TRUE)
plot(st_geometry(l), col = "red", add = TRUE)

}
}
