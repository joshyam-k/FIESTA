\name{modSAarea}
\alias{modSAarea}
\title{
	Small area module - Generate small area area estimates.
}
\description{
	Generates small area estimates by domain (and estimation unit). 	 
}
\usage{    
modSAarea(SApopdat = NULL, SAdomsdf = NULL, cond = NULL, plt = NULL, pltassgn = NULL, 
	seed = NULL, dsn = NULL, tuniqueid = "PLT_CN", cuniqueid = "PLT_CN", 
	condid = "CONDID", puniqueid = "CN", pltassgnid = "CN", measCur = FALSE, 
	measEndyr = NULL, invyrs = NULL, ACI=FALSE, adj = "plot", SApackage = "JoSAE", 
	SAmethod = "unit", plt.nonsamp.filter = NULL, cond.nonsamp.filter = NULL, 
	dunitvar = "DOMAIN", dunitvar2 = NULL, dunitarea = NULL, areavar = NULL, 
	dunitlut = NULL, prednames = NULL, predfac = NULL, largebnd.att = NULL, 
	landarea = "ALL", plt.filter = NULL, cond.filter = NULL, smallbnd.att = NULL, 
	allin1 = FALSE, estround = 0, pseround = 3, estnull = 0, psenull = "--", 
	divideby = NULL, savedata = FALSE, rawdata = FALSE, multest = TRUE, 
	addSAdomsdf = TRUE, SAdomvars = NULL, outfolder = NULL, outfn.pre = NULL, 
	raw_fmt = "csv", raw_dsn = "rawdata", multest_fmt = "csv", multest_outfolder = NULL, 
	multest_dsn = NULL, multest_layer = NULL, multest.append = FALSE, 
	multest.AOIonly = FALSE, outfn.date=FALSE, overwrite = FALSE, addtitle = TRUE, 
	returntitle = FALSE, title.main = NULL, title.ref = NULL, title.dunitvar = NULL, 
	title.filter = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{SApopdat}{ List. Population data objects returned from modSApop(). }
  \item{SAdomsdf}{ DF/DT or comma-delimited file(*.csv). Dataframe from SAdoms
	with attributes from smallbnd to add to estimation table. }
  \item{cond}{ DF/DT or comma-delimited file (*.csv). The condition-level table with one 
	record per condtions and including nonsampled conditions. 
	Plot variables and strata/estimation unit variable(s) may be included for 
	post-stratification. See details for necessary variables to include. }
  \item{plt}{ DF/DT, comma-separated values (CSV) file(*.csv), or layer in dsn,
	Can also be a shapefile(*.shp) with one record per plot, a spatial layer in dsn,
	or a sf R object. Plot-level variables. If nonsampled plots are included, 
	PLOT_STATUS_CD variable must be in table. Optional. }
  \item{pltassgn}{ DF/DT, comma-delimited file(*.csv), SpatialDataFrame, or 
	shapefile(*.shp) with one record per plot, estimation unit variable(s) and 
	mean (continuous rasters) or proportions (categorical rasters) by 
	estimation unit. Optional. }
  \item{seed}{ DF/DT or comma-delimited file (*.csv). Seedling table. }
  \item{dsn}{ Sting. Data Source name of database with tree, cond, pltassgn. }
  \item{tuniqueid}{ String. Unique identifier of plot in tree and seed. }
  \item{cuniqueid}{ String. Unique identifier of plot in cond. }
  \item{condid}{ String. Unique identifier of plot conditions. If no condid in 
	cond, assumed to have 1 condition per plot. A CONDID=1 is automatically added. }
  \item{puniqueid}{ String. Unique identifier of plot. }
  \item{pltassgnid}{ String. Unique identifier of plot. }
  \item{measCur}{ Logical. If TRUE, extract plots with most current measurement for 
	state(s). }
  \item{measEndyr}{ Logical. If TRUE, extract plots with most current measurement for 
	state(s) for years measured before measEndyr. }
  \item{invyrs}{ Integer vector. Inventory year(s) (e.g., c(2000, 2001, 2002)). }
  \item{ACI}{ Logical. If TRUE, including All Condition Inventory (ACI) plots. Removes 
	nonsampled nonforest lands (NF_COND_STATUS_CD = 5). Tree data must be included. }
  \item{adj}{ String. How to calculate adjustment factors for nonsampled 
	(nonresponse) conditions based on summed proportions for by plot ('samp', 'plot').
	'samp' - adjustments are calculated at strata/estimation unit (i.e., domain unit) level; 
	'plot' - adjustments are calculated at plot-level. Adjustments 
	are only calculated for annual inventory plots (designcd=1). } 
  \item{SApackage}{ String. small area package to use ('JoSAE', 'sae') }
  \item{SAmethod}{ String. small area method to use ('unit', 'area') }
  \item{plt.nonsamp.filter}{ String. A logical expression for filtering nonsampled plots. 
	Must be R syntax. If plt.nonsamp.filter=NULL, a default is set to: 'PLOT_STATUS_CD != 3'. } 
  \item{cond.nonsamp.filter}{ String. A logical expression for filtering nonsampled conditions. 
	Must be R syntax. If cond.nonsamp.filter=NULL, a default is set to: 'COND_STATUS_CD != 5'; 
	if ACI: 'is.na(NF_COND_STATUS_CD) | NF_COND_STATUS_CD != 5'. }
  \item{dunitvar}{ String. Name of the domain unit variable in cond, plt, or pltassgn 
	with domain unit assignment for each plot. }
  \item{dunitvar2}{ String. Name of a second domain unit variable in cond or 
	pltassgn with assignment for each plot (e.g., 'STATECD'). }
  \item{dunitarea}{ Numeric or DF. Total area by domain unit. }
  \item{areavar}{ String. Name of acre variable in unitacres. Default="ACRES". }
  \item{dunitlut}{ DF/DT. Data frame with auxiliary information by domain unit. For 
	continuous data, means by domain unit; for categorical data, proportion of 
	class by domain unit. }
  \item{prednames}{ String vector. Name(s) of predictor variables to use in model. }
  \item{predfac}{ String vector. Name(s) of factor predictor variables to use in model. }
  \item{largebnd.att}{ String. Name of the large boundary attribute to define plots
	within a model extent. If NULL, all plots are used for model extent. }
  \item{landarea}{ String. The sample area filter for estimates ('ALL', 'FOREST', 'TIMBERLAND'). 
	If landarea=FOREST, filtered to COND_STATUS_CD = 1; If landarea=TIMBERLAND, filtered 
	to SITECLCD in(1:6) and RESERVCD = 0. }
  \item{plt.filter}{ String. A filter for plt. Must be R syntax. }
  \item{cond.filter}{ String. A filter for cond. Must be R syntax. }
  \item{smallbnd.att}{ String. Attribute in smallbnd, alternative to DOMAIN, to output
	in estimation table. }
  \item{allin1}{ Logical. If TRUE, both estimates and percent sample error are output
	in one table as: estimates (percent sample error). }
  \item{estround}{ Integer. Number of decimal places for estimates. }
  \item{pseround}{ Integer. Number of decimal places for percent sampling error. }
  \item{estnull}{ Number or character. The number or symbol to use to indicate 'not sampled'
		for estimate. }
  \item{psenull}{ Number or character. The number or symbol to use to indicate 'not sampled'
		for percent standard errror. }
  \item{divideby}{ String. Conversion number for output ('hundred', 'thousand', 'million'). }
  \item{savedata}{ Logical. If TRUE, saves table(s) to outfolder. }
  \item{rawdata}{ Logical. If TRUE, returns a list of raw data tables that are used
	for estimation (See Value). If savedata = TRUE, also written to outfolder. }
  \item{multest}{ Logical. If TRUE, returns a data frame of SA estimates using both
	unit-level and area-level estimates. }
  \item{addSAdomsdf}{ Logical. If TRUE, sppends SAdomdf to unit.multest table for output. }
  \item{SAdomvars}{ String vector. List of attributes from SAdoms to include in multest output. }
  \item{outfolder}{ String. The outfolder to write files to. If NULL, files are 
	written to working directory, or if gui, a window to browse. }
  \item{outfn.pre}{ String. A prefix for outfile name, if savedata=TRUE. }
  \item{raw_fmt}{ String. Format for raw output tables ('csv', 'sqlite', 'gpkg').}
  \item{raw_dsn}{ String. Name of database if raw_fmt = c('sqlite', 'gpkg'). }
  \item{multest_fmt}{ String. Format for multest output tables ('csv', 'sqlite', 'gpkg'). }
  \item{multest_outfolder}{ String. Outfolder for multest. If NULL, same as outfolder. }
  \item{multest_dsn}{ String. Name of database if multest_fmt = c('sqlite', 'gpkg'). }
  \item{multest_layer}{ String. Name of database layer if multest_fmt = c('sqlite', 'gpkg'). }
  \item{multest.append}{ Logical. If TRUE, appends multest dataframe to output. }
  \item{multest.AOIonly}{ Logical. If TRUE, appends multest dataframe (AOI=1) to output. }
  \item{outfn.date}{ Logical. If TRUE, add date to end of outfile (e.g., outfn_'date'.csv). }
  \item{overwrite}{ Logical. If TRUE and exportshp=TRUE, overwrite files in outfolder. }
  \item{addtitle}{ Logical. If TRUE and savedata=TRUE, adds title to outfile. }
  \item{returntitle}{ Logical. If TRUE, returns title(s) of the estimation table(s). }
  \item{title.main}{ String. TITLE, if savedata=TRUE and/or returntitle=TRUE: the complete 
	title used for table. If title.main=NULL, the title.* parameters are used to 
	generate title string. Note: if title.ref is not NULL, it is added to title.main. }
  \item{title.ref}{ String. TITLE, if savedata=TRUE and/or returntitle=TRUE: the ending 
	text of the table title (e.g., Nevada, 2004-2005). If NULL, = "". }
  \item{title.dunitvar}{ String. TITLE, if savedata=TRUE and/or returntitle=TRUE: pretty  
	name for the estimation unit variable. If NULL, = unitvar. }
  \item{title.filter}{ String. TITLE, if savedata=TRUE and/or returntitle=TRUE: pretty 
	name for filter(s). If NULL, = "". }
}
\details{
	If variables are NULL, then it will prompt user to input variables.

     	Necessary variables:\cr
	\tabular{llll}{
		\tab \bold{Data} \tab \bold{Variable}	\tab \bold{Description}\cr
	 	\tab tree \tab tuniqueid	\tab Unique identifier for each plot, to link to pltstrat 
								(ex. PLT_CN).\cr
		\tab  \tab CONDID		\tab Unique identifier of each condition on plot, to link to cond. 
								Set CONDID=1, if only 1 condition per plot.\cr
		\tab  \tab TPA_UNADJ		\tab Number of trees per acre each sample tree represents
								(ex. DESIGNCD=1: TPA_UNADJ=6.018046 for trees on subplot;
								74.965282 for trees on microplot).\cr
	 	\tab cond \tab cuniqueid	\tab Unique identifier for each plot, to link to pltstrat 
								(ex. PLT_CN).\cr
		\tab  \tab CONDID		\tab Unique identfier of each condition on plot. 
								Set CONDID=1, if only 1 condition per plot.\cr
		\tab  \tab CONDPROP_UNADJ	\tab Unadjusted proportion of condition on each plot. 
								Set CONDPROP_UNADJ=1, if only 1 condition per plot.\cr
		\tab  \tab COND_STATUS_CD	\tab Status of each forested condition on plot 
							(i.e. accessible forest, nonforest, water, etc.)\cr
		\tab  \tab NF_COND_STATUS_CD	\tab If ACI=TRUE. Status of each nonforest condition on plot 
							(i.e. accessible nonforest, nonsampled nonforest)\cr
  		\tab  \tab SITECLCD		\tab If landarea=TIMBERLAND. Measure of site productivity.\cr
  		\tab  \tab RESERVCD		\tab If landarea=TIMBERLAND. Reserved status.\cr
		\tab  \tab SUBPROP_UNADJ	\tab Unadjusted proportion of subplot conditions on each plot. 
								Set SUBPROP_UNADJ=1, if only 1 condition per subplot.\cr
		\tab  \tab MICRPROP_UNADJ	\tab If microplot tree attributes. Unadjusted proportion 
							of microplot conditions on each plot. Set MICRPROP_UNADJ=1, 
							if only 1 condition per microplot.\cr
		\tab  \tab MACRPROP_UNADJ	\tab If macroplot tree attributes. Unadjusted proportion 
							of macroplot conditions on each plot. Set MACRPROP_UNADJ=1, 
							if only 1 condition per macroplot.\cr
	 	\tab pltstrat \tab puniqueid	\tab Unique identifier for each plot, to link to cond 
								(ex. CN).\cr
	 	\tab  \tab STATECD		\tab Identifies state each plot is located in.\cr
	 	\tab  \tab INVYR		\tab Identifies inventory year of each plot.\cr
	 	\tab  \tab PLOT_STATUS_CD	\tab Status of each plot (i.e. sampled, nonsampled). 
								If not included, all plots are assumed as sampled.\cr							
	}

	Reference names are available for the following variables: \cr
		ADFORCD, AGENTCD, CCLCD, DECAYCD, DSTRBCD, KINDCD, OWNCD, OWNGRPCD, FORTYPCD, 
		FLDTYPCD, FORTYPCDCALC, TYPGRPCD, FORINDCD, RESERVCD, LANDCLCD, STDSZCD, FLDSZCD, 
		PHYSCLCD, MIST_CL_CD, PLOT_STATUS_CD, STATECD, TREECLCD, TRTCD, SPCD, SPGRPCD 

}
\value{
  If FIA=TRUE or unitvar=NULL and colvar=NULL, one data frame is returned with tree estimates 
	and percent sample errors. Otherwise, a list is returned with tree estimates in one 
	data frame (est) and percent sample errors in another data frame (est.pse). If
	rawdata=TRUE, another list is returned including raw data used in the estimation process.
     If addtitle=TRUE and returntitle=TRUE, the title for est/pse is returned. If savedata=TRUE, 
	all data frames are written to outfolder.

  \item{est}{ Data frame. Tree estimates by rowvar, colvar (and estimation unit). If 
	FIA=TRUE or one estimation unit and colvar=NULL, estimates and percent sampling 
	error are in one data frame. }
  \item{pse}{ Data frame. Percent sampling errors for estimates by rowvar and colvar 
	(and estimation unit). }
  \item{titlelst}{ List with 1 or 2 string vectors. If returntitle=TRUE a list with
	table title(s). The list contains one title if est and pse are in the same table 
	and two titles if est and pse are in separate tables. }
  \item{raw}{ List of data frames. If rawdata=TRUE, a list including: number of plots by
	plot status, if in dataset (plotsampcnt); number of conditions by condition status
	(condsampcnt); data used for post-stratification (stratdat); and 1-8 tables 
	with calculated variables used for processing estimates and percent sampling error
	for table cell values and totals (See processing data below). }


  Raw data

  \item{plotsampcnt}{ Table. Number of plots by plot status (ex. sampled forest on plot, 
	sampled nonforest, nonsampled). }
  \item{condsampcnt}{ DF. Number of conditions by condition status (forest land,
	nonforest land, noncensus water, census water, nonsampled). }

  \item{processing data}{ Data frames. Separate data frames containing calculated variables 
	used in estimation process. The number of processing tables depends on the input
	parameters. The tables include: total by estimation unit (unit.totest); rowvar totals
 	(unit.rowest), and if colvar is not NULL, colvar totals, (unit.colvar); and a combination 
	of rowvar and colvar (unit.grpvar). If FIA=TRUE, the raw data for the summed estimation 
	units are also included (totest, rowest, colest, grpest, respectively). These tables do 
	not included estimate proportions (nhat and nhat.var). 

	The data frames include the following information:
	\tabular{lll}{
		\tab \bold{Variable}	\tab \bold{Description}\cr
	 	\tab nhat		\tab estimated proportion of trees \cr
	 	\tab nhat.var	\tab estimated variance of estimated proportion of trees \cr
	 	\tab ACRES		\tab total area for estimation unit \cr
	 	\tab est		\tab estimated area of trees { nhat*ACRES } \cr
	 	\tab est.var	\tab estimated variance of estimated area of trees { nhat.var*ACRES^2 } \cr
	 	\tab est.se	\tab standard error of estimated area of trees { sqrt(est.var) } \cr
	 	\tab est.cv	\tab coefficient of variation of estimated area of trees { est.se/est } \cr
	 	\tab pse		\tab percent sampling error of estimate { est.cv*100 } \cr
	 	\tab CI99left	\tab left tail of 99 percent confidence interval for estimated area \cr
	 	\tab CI99right	\tab right tail of 99 percent confidence interval for estimated area \cr
	 	\tab CI95left	\tab left tail of 95 percent confidence interval for estimated area \cr
	 	\tab CI95right	\tab right tail of 95 percent confidence interval for estimated area \cr
	 	\tab CI67left	\tab left tail of 67 percent confidence interval for estimated area \cr
	 	\tab CI67right	\tab right tail of 67 percent confidence interval for estimated area \cr
	}
  }
  
  Table(s) are also written to outfolder.
}
\author{
	Tracey S. Frescino, Paul L. Patterson, Elizabeth A. Freeman
}
\references{
	Scott, Charles T.; Bechtold, William A.; Reams, Gregory A.; Smith, William D.; Westfall, James A.; 
	Hansen, Mark H.; Moisen, Gretchen G. 2005. Sample-based estimators used by the Forest Inventory and
	Analysis national information management system. Gen. Tech. Rep. SRS-80. Asheville, NC: U.S. Department
	of Agriculture, Forest Service, Southern Research Station, p.53-77.
}

\note{
 
	ADJUSTMENT FACTOR:\cr
	The adjustment factor is necessary to account for nonsampled conditions. It is calculated 
		for each estimation unit by strata. by summing the unadjusted proportions of the 
		subplot, microplot, and macroplot (i.e. *PROP_UNADJ) and dividing by the number 
		of plots in the strata/estimation unit).

	An adjustment factor is determined for each tree based on the size of the plot it was 
	measured on. This is identified using TPA_UNADJ as follows: 

	\tabular{llr}{
	\tab \bold{PLOT SIZE}	\tab \bold{TPA_UNADJ} \cr
	\tab SUBPLOT	\tab 6.018046 \cr
	\tab MICROPLOT	\tab 74.965282 \cr
	\tab MACROPLOT	\tab 0.999188 \cr }

	If ACI=FALSE, only nonsampled forest conditions are accounted for in the adjustment factor. \cr
	If ACI=TRUE, the nonsampled nonforest conditions are removed as well and accounted for in adjustment factor.
	This is if you are interested in estimates for all lands or nonforest lands in the All-Condition-Inventory.


	STRATA:\cr
	If using strata information, a strata value must be attached to each plot and a look-up 
	table by strata (and estimation unit) must be included (stratalut). The strata values 
	may be in the pltstrat table or the cond table. Specify the strata variable name strvar 
	(and unitvar). The table must have a column from strata and a column for area (areavar) 
	by strvar (and unitvar). 

	If only 1 strata, simple random sample is used. Set strlut=NULL and include totacres. 
	The function adds a dummy variable, STRATA=1, to areadat and generates a strlut based 
	on the totacres and estimation unit if included.

	If you have tree domain data already summarized to condition level, set rowvar or 
	colvar = tdomvar to define the arrangement in output estimation table. 


	FIA=TRUE vs FIA=FALSE:\cr
	FIA=TRUE means estimates are calculated by estimation unit and then collapsed (summed) 
		for the entire population.
	FIA=FALSE means estimates are calculated by estimation unit and reported by estimation unit. 
	The returned object includes all estimation units. If savedata=TRUE, there is a separate 
		file for each estimation unit.


     UNITS:\cr
     The following variables are converted from pounds (in NIMS) to short tons by multiplying 
	the variable by 0.0005.
     DRYBIO_AG, DRYBIO_BG, DRYBIO_WDLD_SPP, DRYBIO_SAPLING, DRYBIO_STUMP, DRYBIO_TOP, DRYBIO_BOLE, 
	DRYBIOT, DRYBIOM, DRYBIOTB, JBIOTOT, CARBON_BG, CARBON_AG 


	MORTALITY:\cr
     For Interior-West FIA, mortality estimates are mainly based on whether a tree has died 
		within the last 5 years of when the plot was measured. If a plot was remeasured, 
		mortality includes trees that were alive the previous visit but were dead in the 
		next visit. If a tree was standing the previous visit, but was not standing in the 
		next visit, no diameter was collected (DIA = NA) but the tree is defined as mortality. 


	Common tree filters: \cr

	\tabular{llr}{
	\tab \bold{FILTER}		\tab \bold{DESCRIPTION} \cr
 	\tab "STATUSCD == 1"		\tab Live trees \cr	
	\tab "STATUSCD == 2"		\tab Dead trees \cr	
	\tab "TPAMORT_UNADJ > 0"	\tab Mortality trees \cr
	\tab "STATUSCD == 2 & DIA >= 5.0"	\tab Dead trees >= 5.0 inches diameter \cr
	\tab "STATUSCD == 2 & AGENTCD == 30"	\tab Dead trees from fire \cr }
}

\keyword{ data }