% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/imported-functions.R
\name{scale_color_add_on}
\alias{scale_color_add_on}
\title{ggplot2 - color add on}
\usage{
scale_color_add_on(
  aes = "color",
  variable = "numeric",
  clrsp = NULL,
  clrp = NULL,
  ...
)
}
\arguments{
\item{aes}{Character value. Either \emph{'color'} or \emph{'fill'}. Denotes the
used aesthetic.}

\item{variable}{The variable that is mapped onto the denoted aesthetic or a character
value - one of \emph{'numeric', 'discrete'}.}

\item{clrsp}{Character value. The color spectrum of choice if \code{variable} is
numeric. Run \code{confuns::all_colorspectra()}
to see all valid input choices.

(Ignored if \code{variable} is discrete)}

\item{clrp}{Character value. The color panel of choice if \code{variable} is discrete
Run \code{confuns::all_colorpanels()} to see all valid input choices.

(Ignored if \code{variable} is numeric)}

\item{...}{Additional arguments given to the respective function.

 \itemize{
  \item{\code{ggplot2::scale_color_viridis_c(...)}: If \code{variable} is numeric and
  \code{clrsp} is one of \emph{'cividis', 'viridis', 'inferno', 'magma', 'plasma'}}
  \item{\code{colorspace::scale_<aes>_continuous_sequential(...)}: If \code{variable} is numeric
  and \code{clrsp} is sequential}
  \item{\code{colorspace::scale_<aes>_continuous_diverging(...)}: If \code{variable} is numeric
  and \code{clrsp} is diverging}
  \item{\code{ggplot2::scale_<aes>_manual(...)}: If \code{variable} is categorical.}
  }}
}
\value{
An unnamed list containing the ggproto object.
}
\description{
A wrapper around a variety of \code{scale_color_-() / scale_fill_-()}
functions.
}
\details{
If the specified \code{clrp} does not contain enough colors to cover the
specified variable NULL is returned - which makes the call to \code{ggplot2::ggplot()}
use the default ggplot2 color panel.

Make sure to use correct capitalization and white spaces denoting the color panel or -spectrum
of choice.
}
\examples{
library(ggplot2)

ggplot(mtcars, aes(x = qsec, y = wt)) +
geom_point(aes(color = mpg)) +
scale_color_add_on(aes = "color", variable = mtcars$mpg, clrsp = "Reds 3")
}
