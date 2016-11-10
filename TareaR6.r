# PACKAGES es una lista con los nombres de los paquetes a utilizar.  
paquete1<-c("R.utils")

for (PKT in paquete1 ) {
  if (!require(PKT, character.only=T, quietly=T)) {
      install.packages(PKT)
      library(PKT)
  }
}

setwd("/Users/DiegoMoOr/Desktop/Tarea6")
dirDown<-"/Users/DiegoMoOr/Desktop/Tarea6/Down"
dirCDatos<-"/Users/DiegoMoOr/Desktop/Tarea6/CDatos"

if( !file.exists(dirDown) ) {
  dir.create(file.path(dirDown), recursive=TRUE) 
  if( !dir.exists(dirDown) ) {
    stop("No existe directorio")
  }
}

if( !file.exists(dirCDatos) ) {
  dir.create(file.path(dirCDatos), recursive=TRUE) 
  if( !dir.exists(dirCDatos) ) {
    stop("No existe directorio")
  }
}

archivosDescargados <- c("StormEvents_fatalities-ftp_v1.0_d1990_c20160223.csv",
"StormEvents_fatalities-ftp_v1.0_d1991_c20160223.csv",
"StormEvents_fatalities-ftp_v1.0_d1992_c20160223.csv",
"StormEvents_fatalities-ftp_v1.0_d1993_c20160223.csv",
"StormEvents_fatalities-ftp_v1.0_d1994_c20160223.csv",
"StormEvents_fatalities-ftp_v1.0_d1995_c20160223.csv", 
"StormEvents_fatalities-ftp_v1.0_d1996_c20160223.csv",
"StormEvents_fatalities-ftp_v1.0_d1997_c20160223.csv",
"StormEvents_fatalities-ftp_v1.0_d1998_c20160223.csv", 
"StormEvents_fatalities-ftp_v1.0_d1999_c20160223.csv")

urlArchivos<-"http://www1.ncdc.noaa.gov/pub/data/swdi/stormevents/csvfiles/"
if( exists("fatalities") ){
	rm(fatalities)
}

for( archivo in archivosDescargados ){
  archivoS<-paste(dirCDatos, archivo, sep="/")  
  if( ! file.exists(archivoS)) { 
  	archivoComp<-paste(dirDown, archivo, sep="")
    archivoComp<-paste(archivoComp, "gz", sep=".")       
    destArchivo<-paste(dirDown, archivo, sep="/")
    destArchivo<-paste(destArchivo, "gz", sep=".")
    if( ! file.exists(archivoComp) ){
    	archivoDescarga<-paste(urlArchivos, archivo, sep="")
    	archivoDescarga<-paste(archivoDescarga, "gz", sep=".")
        download.file(archivoDescarga, destArchivo)        
    }
    gunzip(destArchivo, archivoS) 
  }
  if( !exists("fatalities" ) ) {
	fatalities<-read.csv( archivoS, header=T, sep=",", na.strings="")
  } else {
	data<-read.csv(archivoS, header=T, sep=",", na.strings="")
	fatalities<-rbind(fatalities,data)
	rm(data)
  }  
}
nrow(fatalities)
