if (!require("devtools")) install.packages("devtools")
if (!require("bitops")) install.packages("bitops")
if (!require("RCurl")) install.packages("RCurl")
if (!require("stringi")) install.packages("stringi")
if (!require("httr")) install.packages("httr")
if (!require("swirl")) install.packages("swirl")
#install.packages("devtools", "bitops", "RCurl", "stringi", "httr", "swirl")
library(devtools)
library(bitops)
library(RCurl)
library(httr)
library(swirl)
set_config( config( ssl_verifypeer = 0L ) )
if (file.exists("/opt/R/home/library/swirl/Courses/Programando_en_R")) {
  uninstall_course("Programando_en_R")
}
install_course_github('josersosa','Programando_en_R')
select_language(language = "spanish")
# Ejecución del curso
swirl()

# Al comienzo nos solicita un nombre para identificarnos y almacenar los avances
# que hagamos en el caso que deseemos pausar el curso. 
# Las primeras informaciones estan en ingles porque provienen del paquete swirl. 
# Luego seleccionamos el curso Programando en R y a partir de ahí todo lo esencial 
# estará traducido. Las últimas versiones de swirl incluyen una función para seleccionar 
# el idioma, que pdemos utilizar para que los mensajes del sistema estén en español:
  
  