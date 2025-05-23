% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/datLUTspp.R
\name{datLUTspp}
\alias{datLUTspp}
\title{Data - Gets variable description or class for SPCD.}
\usage{
datLUTspp(
  x = NULL,
  uniquex = NULL,
  NAclass = "Other",
  group = FALSE,
  states = NULL,
  spcdname = "COMMON",
  add0 = FALSE,
  stopifmiss = FALSE,
  xtxt = NULL,
  dsn = NULL,
  dbconn = NULL,
  dbconnopen = FALSE,
  dbwrite = FALSE,
  dbreturn = TRUE,
  overwrite = TRUE,
  savedata = FALSE,
  savedata_opts = NULL
)
}
\arguments{
\item{x}{Data frame or comma-delimited file (*.csv). The data table with
variable to classify.}

\item{uniquex}{String. Unique values of SPCD to match, if x is NULL.}

\item{NAclass}{String. NA values in xvar will be changed to NAclass.}

\item{group}{Logical. If TRUE, the group variable in ref_species
are merged to data table (E_SPGRPCD, W_SPGRPCD), depending on state(s) 
specified. If states overlap both E and W regions, the region with 
majority is used or E if equal. The group name is merged from 
ref_codes, SPGRPCD Variable.}

\item{states}{String. Name of state(s) the x table is from.}

\item{spcdname}{String. Name for species output type ('COMMON', 'SCIENTIFIC', 
'SYMBOL', 'COMMON_SCIENTIFIC', 'NONE').}

\item{add0}{Logical. IF TRUE, keep all codes in look up table. If FALSE,
only include codes that are in x.}

\item{stopifmiss}{Logical. IF TRUE, stops function if missing codes in LUTx.}

\item{xtxt}{String.* Name of x table for more useful information in
warnings.}

\item{dsn}{String. Data source name of database with x.}

\item{dbconn}{Open database connection.}

\item{dbconnopen}{Logical. If TRUE, keep database connection open.}

\item{dbwrite}{Logical. If TRUE, write class column to database table x.}

\item{dbreturn}{Logical. If TRUE, return table with class column.}

\item{overwrite}{Logical. If TRUE, and the class name already exists 
in x, overwrites class name.}

\item{savedata}{Logical. If TRUE, saves data to outfolder.}

\item{savedata_opts}{List. See help(savedata_options()) for a list
of options. Only used when savedata = TRUE. If out_layer = NULL,
default = 'datlut'.}
}
\value{
\item{xLUT}{ The input data table with look-up table variable(s). }
\item{xLUTnm}{ Name of the new variable(s). } \item{LUT}{ Look up table with
categories. }

If savedata = TRUE, a comma-delimited file is output to the outfolder as
outfn.  If outfn = NULL, the name of the file will be datlut_'date'.csv.
}
\description{
Merge the ref_species table to append new variables, names, or categories to x.
}
\note{
For available reference tables:
sort(unique(ref_codes$VARIABLE))
}
\examples{
WYtreelut <- datLUTspp(WYtree)
names(WYtreelut)
WYtree2 <- WYtreelut$xLUT
head(WYtree2)
}
\author{
Tracey S. Frescino
}
\keyword{data}
