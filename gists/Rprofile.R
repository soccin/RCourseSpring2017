##
## Do not define things in Rprofile
## they will pollute the name space
## except for things like .Last
##

cat("~/.Rprofile ... ")

#
# You really, really want to set this
#
options(stringsAsFactors=FALSE)

options(max.print=9999)
options(menu.graphics=FALSE)

suppressPackageStartupMessages(library(gdata,quietly=TRUE))

ndsLib=new.env(parent=baseenv())
ndsLib$DATE <- function() {gsub("-","",Sys.Date())}
ndsLib$cc <- function(...) {paste(...,sep='_')}
ndsLib$len <- function(x) {length(x)}

ndsLib$tty.width <-
function() {
   con=pipe("~/bin/getTTYWidth")
   dat=readLines(con,n=1)
   close(con)
   width=as.numeric(dat)
   if(len(width)>0 && width>80) {
     return(width)
   } else {
     return(80)
   }
}

ndsLib$write.xls <- function(dd,filename,row.names=T,col.names=NA) {
  if (!is.data.frame(dd)) {
    dd <- data.frame(dd,check.names=F)
  }
  if(!row.names) {
    col.names=T
  }
  write.table(dd,file=filename,sep="\t",quote=FALSE,
              col.names=col.names,row.names=row.names)
}

ndsLib$getSDIR<-function(){
    args=commandArgs(trailing=F)
    TAG="--file="
    path_idx=grep(TAG,args)
    SDIR=dirname(substr(args[path_idx],nchar(TAG)+1,nchar(args[path_idx])))
    if(len(SDIR)==0) {
        return(getwd())
    } else {
    	return(SDIR)
    }
}

attach(ndsLib)
rm(ndsLib)

if(interactive() & Sys.getenv("R_GUI_APP_VERSION")==""){options(width=tty.width())}

.Last <- function(){
  if(interactive())
    try(
        savehistory(paste("_Rhistory_",gsub(" ","_",Sys.time()),".R",sep=""))
        )
}

