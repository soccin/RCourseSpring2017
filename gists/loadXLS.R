#
# Read all sheets from an excel file
# use try in case it fails on one
# needs read.xls from gdata package
#
readAllSheets<-function(XLSFILE) {
    sNames=sheetNames(XLSFILE)
    sheets=list()
    for(ii in seq(sNames)) {
        cat(ii,"\t",sNames[ii],"\n")
        sheet=NULL
        try({sheet=read.xls(XLSFILE,sheet=ii)})
        if(!is.null(sheet)) {
            sheets[[sNames[ii]]]=sheet
        }
    }
    return(sheets)
}


# Prostate_Cancer_PartC_Results=list()
# Prostate_Cancer_PartC_Results$xlsFile="raw/Prostate_Cancer_PartC_Results.xlsx"
# sheets=readAllSheets(Prostate_Cancer_PartC_Results$xlsFile)
# Prostate_Cancer_PartC_Results$sheets=sheets
# save(Prostate_Cancer_PartC_Results,
#      file="data/Prostate_Cancer_PartC_Results.rda",
#     compress=T)

