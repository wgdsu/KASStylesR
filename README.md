# KASStylesR

# Overview
KASStylesR is a package designed for producing charts and figures that meet Welsh
Government Knowledge and Analytical Services publication guidance. The package also contains
some helper functions for producing charts ready for web teams. Some example 
use cases for KASStylesR are:
* Saving charts, alt text, titles and sources in bulk to an Excel workbook
* Saving SVG versions of charts produced in R
* Formatting charts so that they meet accessibility guidance
* Adding color themes to charts consistently and with accessibility warnings

# Installation
KASStylesR has been packaged up so that you can install it into your current
set of R packages. However, we understand that might not be the way that you want
to work, especially if you want to tweak the package to meet your departmental
guidelines. If that is the case you may want to skip to **Installing as R scripts**

## Installing as an R Package
To install as an R package you can clone this repository:
```
git clone <repolink>
cd kasstylesr
```

Then run the following commands in R:
```
install.packages('devtools')
install.packages('./kasstylesr_0.0.1.0000.tar.gz', repos=NULL, type='source')
```

## Installing as R Scripts
Alternatively if you are just interested in using the R Scripts individually
you can clone the repository:

```
git clone <repolink>
cd kasstylesr
```

There are some dependencies with KASStylesR that we recommend installing first,
though they should install alongside the package if you skip this step:
* ggplot2
* ggExtra
* openxlsx

Then checkout the R files:
```
cd R
```

# Usage
If you installed KASStylesR as an R Package, all of the functions should be accessible
by using the `kasstylesr::` prefix or by using `library(kasstylesr)`

For example:

```
library(kasstylesr)

# adds a color scheme with 4 colours to a GGPlot chart
plot_with_colours <- plot + color_picker(4)
```

For more examples the ? operator can be used in R to find out more about individual
functions: `?kasstylesr::finalise_plot`

Or for a guided walkthrough please refer to the package vignette:
```
vignette('kasstylesr')
```


# Getting Help
If you spot an issue with the package please raise an Issue in the repository
on GitHub. 

To contribute to the package please raise an Issue describing the change you want
to make. Then follow this up with a pull request which will be reviewed by the
authors/maintainers of the package.

Support queries: DataScienceUnit@gov.wales.


