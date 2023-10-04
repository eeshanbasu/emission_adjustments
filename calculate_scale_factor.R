library(ncdf4)
library(raster)

# the projection of WRF-Chem
# new_crs <- "+proj=longlat +datum=WGS84 +no_defs"

ncfile_2013 <- nc_open("E:/Eeshan/EQUATES/Avg.gridded.201301.nc")

var_names <- names(ncfile_2013$var)
print(var_names)

#####
SO2_2013 <- ncvar_get(ncfile_2013, 
                 varid = "SO2")
print(sum(SO2_2013))

ncfile_2016 <- nc_open("E:/Eeshan/EQUATES/Avg.gridded.201601.nc")

var_names <- names(ncfile_2016$var)
print(var_names)

SO2_2016 <- ncvar_get(ncfile_2016, 
                      varid = "SO2")
print(sum(SO2_2016))

SO2_factor <- sum(SO2_2013)/sum(SO2_2016)
print(SO2_factor)
##### 
NH3_2013 <- ncvar_get(ncfile_2013, 
                      varid = "NH3")
print(sum(NH3_2013))

ncfile_2016 <- nc_open("E:/Eeshan/EQUATES/Avg.gridded.201601.nc")

var_names <- names(ncfile_2016$var)

NH3_2016 <- ncvar_get(ncfile_2016, 
                      varid = "NH3")
print(sum(NH3_2016))

NH3_factor <- sum(NH3_2013)/sum(NH3_2016)
print(NH3_factor)

#####
ALD2_2013 <- ncvar_get(ncfile_2013, 
                      varid = "ALD2")
print(sum(ALD2_2013))

ncfile_2016 <- nc_open("E:/Eeshan/EQUATES/Avg.gridded.201601.nc")

var_names <- names(ncfile_2016$var)

ALD2_2016 <- ncvar_get(ncfile_2016, 
                      varid = "ALD2")
print(sum(ALD2_2016))

ALD2_factor <- sum(ALD2_2013)/sum(ALD2_2016)
print(ALD2_factor)

#####
PSO4_2013 <- ncvar_get(ncfile_2013, 
                       varid = "PSO4")
print(sum(PSO4_2013))

ncfile_2016 <- nc_open("E:/Eeshan/EQUATES/Avg.gridded.201601.nc")

var_names <- names(ncfile_2016$var)

PSO4_2016 <- ncvar_get(ncfile_2016, 
                       varid = "PSO4")
print(sum(PSO4_2016))

PSO4_factor <- sum(PSO4_2013)/sum(PSO4_2016)
print(PSO4_factor)
#####
PEC_2013 <- ncvar_get(ncfile_2013, 
                       varid = "PEC")
print(sum(PEC_2013))

ncfile_2016 <- nc_open("E:/Eeshan/EQUATES/Avg.gridded.201601.nc")

var_names <- names(ncfile_2016$var)

PEC_2016 <- ncvar_get(ncfile_2016, 
                       varid = "PEC")
print(sum(PEC_2016))

PEC_factor <- sum(PEC_2013)/sum(PEC_2016)
print(PEC_factor)

#####
POC_2013 <- ncvar_get(ncfile_2013, 
                      varid = "POC")
print(sum(POC_2013))

ncfile_2016 <- nc_open("E:/Eeshan/EQUATES/Avg.gridded.201601.nc")

var_names <- names(ncfile_2016$var)

POC_2016 <- ncvar_get(ncfile_2016, 
                      varid = "POC")
print(sum(POC_2016))

POC_factor <- sum(POC_2013)/sum(POC_2016)
print(POC_factor)

#####
PMOTHR_2013 <- ncvar_get(ncfile_2013, 
                         varid = "PMOTHR")
print(sum(PMOTHR_2013))

ncfile_2016 <- nc_open("E:/Eeshan/EQUATES/Avg.gridded.201601.nc")

var_names <- names(ncfile_2016$var)

PMOTHR_2016 <- ncvar_get(ncfile_2016, 
                         varid = "PMOTHR")
print(sum(PMOTHR_2016))

PMOTHR_factor <- sum(PMOTHR_2013)/sum(PMOTHR_2016)
print(PMOTHR_factor)

#####
NO2_2013 <- ncvar_get(ncfile_2013, 
                         varid = "NO2")
print(sum(NO2_2013))

ncfile_2016 <- nc_open("E:/Eeshan/EQUATES/Avg.gridded.201601.nc")

var_names <- names(ncfile_2016$var)

NO2_2016 <- ncvar_get(ncfile_2016, 
                         varid = "NO2")
print(sum(NO2_2016))

NO2_factor <- sum(NO2_2013)/sum(NO2_2016)
print(NO2_factor)

#####
CL2_2013 <- ncvar_get(ncfile_2013, 
                      varid = "CL2")
print(sum(CL2_2013))

ncfile_2016 <- nc_open("E:/Eeshan/EQUATES/Avg.gridded.201601.nc")

var_names <- names(ncfile_2016$var)

CL2_2016 <- ncvar_get(ncfile_2016, 
                      varid = "CL2")
print(sum(CL2_2016))

CL2_factor <- sum(CL2_2013)/sum(CL2_2016)
print(CL2_factor)

#####
NO_2013 <- ncvar_get(ncfile_2013, 
                      varid = "NO")
print(sum(NO_2013))

ncfile_2016 <- nc_open("E:/Eeshan/EQUATES/Avg.gridded.201601.nc")

var_names <- names(ncfile_2016$var)

NO_2016 <- ncvar_get(ncfile_2016, 
                      varid = "NO")
print(sum(NO_2016))

NO_factor <- sum(NO_2013)/sum(NO_2016)
print(NO_factor)

#####
PMG_2013 <- ncvar_get(ncfile_2013, 
                     varid = "PMG")
print(sum(PMG_2013))

ncfile_2016 <- nc_open("E:/Eeshan/EQUATES/Avg.gridded.201601.nc")

var_names <- names(ncfile_2016$var)

PMG_2016 <- ncvar_get(ncfile_2016, 
                     varid = "PMG")
print(sum(PMG_2016))

PMG_factor <- sum(PMG_2013)/sum(PMG_2016)
print(PMG_factor)


#####
PMC_2013 <- ncvar_get(ncfile_2013, 
                      varid = "PMC")
print(sum(PMC_2013))

ncfile_2016 <- nc_open("E:/Eeshan/EQUATES/Avg.gridded.201601.nc")

var_names <- names(ncfile_2016$var)

PMC_2016 <- ncvar_get(ncfile_2016, 
                      varid = "PMC")
print(sum(PMC_2016))

PMC_factor <- sum(PMC_2013)/sum(PMC_2016)
print(PMC_factor)


#####
PMN_2013 <- ncvar_get(ncfile_2013, 
                      varid = "PMN")
print(sum(PMN_2013))

ncfile_2016 <- nc_open("E:/Eeshan/EQUATES/Avg.gridded.201601.nc")

var_names <- names(ncfile_2016$var)

PMN_2016 <- ncvar_get(ncfile_2016, 
                      varid = "PMN")
print(sum(PMN_2016))

PMN_factor <- sum(PMN_2013)/sum(PMN_2016)
print(PMN_factor)

#####
PSO4_2013 <- ncvar_get(ncfile_2013, 
                      varid = "PSO4")
print(sum(PSO4_2013))

ncfile_2016 <- nc_open("E:/Eeshan/EQUATES/Avg.gridded.201601.nc")

var_names <- names(ncfile_2016$var)

PSO4_2016 <- ncvar_get(ncfile_2016, 
                      varid = "PSO4")
print(sum(PSO4_2016))

PSO4_factor <- sum(PSO4_2013)/sum(PSO4_2016)
print(PSO4_factor)


#####
VOC_INV_2013 <- ncvar_get(ncfile_2013, 
                       varid = "VOC_INV")
print(sum(VOC_INV_2013))

ncfile_2016 <- nc_open("E:/Eeshan/EQUATES/Avg.gridded.201601.nc")

var_names <- names(ncfile_2016$var)

VOC_INV_2016 <- ncvar_get(ncfile_2016, 
                       varid = "VOC_INV")
print(sum(VOC_INV_2016))

VOC_INV_factor <- sum(VOC_INV_2013)/sum(VOC_INV_2016)
print(VOC_INV_factor)
