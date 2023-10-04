library(ncdf4)
library(raster)
library(sp)
library(rasterVis)

# the projection of WRF-Chem
# new_crs <- "+proj=longlat +datum=WGS84 +no_defs"

# ncfile_2013 <- nc_open("E:/Eeshan/EQUATES/Avg.gridded.201301.nc")
# var_names <- names(ncfile_2013$var)
# print(var_names)

test <- eixport::wrf_get("E:/Eeshan/EQUATES/Avg.gridded.201301.nc",'POC')[,,1]
R    <- raster(test,)


ncdf4::nc_open("E:/Eeshan/FFDAS/emissions/d01/2012/nonpoint_sources/wrfchemi_nonpoint_d01_2012-01-01_00%3A00%3A00")




equates_201301 <- raster("E:/Eeshan/EQUATES/Avg.gridded.201301.nc",
                         varname = 'POC')
new_crs <- "+proj=lcc +lat_1=33 +lat_2=45 +lat_0=39.3034477233887 +lon_0=-97.6499862670898 +x_0=0 +y_0=0 +a=6370000 +b=6370000 +units=m +no_defs"
crs(equates_201301) <- new_crs
crs(wrf_input) <- new_crs

wrf_input <- raster("C:/Users/basu.e/Downloads/EDGAR v5.0/wrf_input/d01/new/wrfinput_d01")

equates_201301_test <- projectRaster(equates_201301, crs = "+proj=lcc +lat_1=33 +lat_2=45 +lat_0=39.3034477233887 +lon_0=-97.6499862670898 +x_0=0 +y_0=0 +a=6370000 +b=6370000 +units=m +no_defs")

plot(equates_201301)
plot(wrf_input,
     add = T)

### KF
equates_nc <- ncdf4::nc_open("E:/Eeshan/EQUATES/Avg.gridded.201301.nc")
ncdf4::nc_close(equates_nc)

## changing the projection and extent from the input file/GRIDDESC
equates_rast <- raster::raster("E:/Eeshan/EQUATES/Avg.gridded.201301.nc", 
                               varname = "POC")
equates_crs <- paste0("+proj=lcc +lat_1=33 +lat_2=45 +lat_0=40 +lon_0=-97 +x_0=0 +y_0=0 +datum=WGS84 +a=6370000 +b=6370000 +units=m +no_defs")
equates_extent <- raster::extent(-2556000, -2556000 + 459 * 12000, -1728000, -1728000 + 299 * 12000)
raster::extent(equates_rast) <- equates_extent
terra::crs(equates_rast) <- equates_crs

plot(equates_rast[[1]])
equates_reproj <- raster::projectRaster(from = equates_rast, crs ="+proj=lcc +lat_1=33 +lat_2=45 +lat_0=39.30345 +lon_0=-97.64413 +x_0=0 +y_0=0 +datum=WGS84 +a=6370000 +b=6370000 +units=m +no_defs")
plot(equates_reproj[[1]])




wrf_rast <- raster::raster("E:/Eeshan/FFDAS/emissions/d01/2012/nonpoint_sources/wrfchemi_nonpoint_d01_2012-01-01_00%3A00%3A00", varname = "POC")
wrf_crs <- paste0("+proj=lcc +lat_1=33 +lat_2=45 +lat_0=40 +lon_0=-97 +x_0=0 +y_0=0 +datum=WGS84 +a=6370000 +b=6370000 +units=m +no_defs")
wrf_extent <- raster::extent(-2556000, -2556000 + 459 * 12000, -1728000, -1728000 + 299 * 12000) #x-orig is the first one
raster::extent(wrf_rast) <- wrf_extent
terra::crs(wrf_rast) <- wrf_crs
plot(wrf_rast[[1]])
wrf_rast_lonlat <- raster::projectRaster(from = wrf_rast, crs = "+proj=longlat +datum=WGS84")
plot(wrf_rast_lonlat[[1]])