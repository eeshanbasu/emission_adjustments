library(raster)
library(rasterVis)
library(RColorBrewer)

## making the dummy raster
# this is important because the template rater is the raster on which I am replacing the factors
# Define the projection (example: Lambert Conformal Conic)
projection <- CRS("+proj=lcc +lat_1=33 +lat_2=45 +lat_0=39.30345 +lon_0=-97.64413 +x_0=0 +y_0=0 +datum=WGS84 +a=6370000 +b=6370000 +units=m +no_defs")

# Define the extent (example: extent of the continental United States)
# the first one is the x-orig from the template file
wrf_extent <- extent(-2664000, -2664000 + 148 * 36000, -2016000, -2016000 + 112 * 36000)  # xmin, xmax, ymin, ymax

# Define the resolution (example: 1 km)
resolution <- c(36000, 36000)  # x-res, y-res in meters

# Create a raster layer with constant value 1
template_raster <- raster(wrf_extent, 
                          res = resolution, 
                          crs = projection)
template_raster[] <- 1  # Set all grid cells to 1

# # Plot the raster with grid cell boundaries
# # just a checking step
# plot(template_raster, 
#      col=c(topo.colors(200)), 
#      axes=FALSE, 
#      box=FALSE)
# plot(rasterToPolygons(template_raster), 
#      add=TRUE, 
#      border='black', 
#      lwd=1) 

# EQUATES 2013
# changing the projection and making it similar to WRF
equates_1301_nc <- ncdf4::nc_open("E:/Eeshan/EQUATES/Avg.gridded.201301.nc",
                                  verbose = F)
variables_equates <- names(equates_1301_nc[['var']])
ncdf4::nc_close(equates_1301_nc)

# EQUATES variables
var_equates <- c("POC", "NO2", "SO2", "NH3", "PEC", "NO", "PSO4", "CL2", "ALD2", "ALDX", "BENZ", 
                 "ETH", "ETHA", "FORM", "HCL", "HONO", "IOLE", "ISOP", "SULF", "TERP", "TOL")

# WRF-Chem variables
var_wrfchem <- c("E_ORGJ", "E_NO2", "E_SO2", "E_NH3", "E_PM25J", "E_NO", "E_SO4J", "E_CL2", "E_ALD2", "E_ALDX", "E_BENZENE", 
                 "E_ETH", "E_ETHA", "E_FORM", "E_HCL", "E_HONO", "E_IOLE", "E_ISOP", "E_PSULF", "E_TERP", "E_TOL")

## changing the projection and extent from the input file/GRIDDESC
equates_1301_rast <- raster::raster("E:/Eeshan/EQUATES/Avg.gridded.201301.nc", 
                                    varname = "POC")
equates_1301_crs <- paste0("+proj=lcc +lat_1=33 +lat_2=45 +lat_0=40 +lon_0=-97 +x_0=0 +y_0=0 +datum=WGS84 +a=6370000 +b=6370000 +units=m +no_defs")
equates_1301_extent <- raster::extent(-2556000, -2556000 + 459 * 12000, -1728000, -1728000 + 299 * 12000)
raster::extent(equates_1301_rast) <- equates_1301_extent
terra::crs(equates_1301_rast) <- equates_1301_crs
plot(equates_1301_rast[[1]])

equates_1301_reproj <- raster::projectRaster(from = equates_1301_rast, crs ="+proj=lcc +lat_1=33 +lat_2=45 +lat_0=39.30345 +lon_0=-97.64413 +x_0=0 +y_0=0 +datum=WGS84 +a=6370000 +b=6370000 +units=m +no_defs")

# making the plot
n_colors <- 20

# Create a custom color palette
custom_palette <- colorRampPalette(c("white", "red"))(n_colors)

plot(equates_1301_reproj[[1]],
     col = custom_palette, 
     axes=FALSE, 
     box=TRUE)
# plot(rasterToPolygons(equates_1301_reproj[[1]]),
#      add=TRUE,
#      border='black',
#      lwd=1)

# changing the resolution to the d01 domain
# Resample the raster to the new resolution
resampled_equates_1301 <- raster::aggregate(equates_1301_reproj[[1]], 
                                            fact = 3)

# Plot the resampled raster
plot(resampled_equates_1301, 
     col = custom_palette, 
     axes = FALSE, 
     box = TRUE)
plot(rasterToPolygons(resampled_equates_1301[[1]]),
     add=TRUE,
     border='black',
     lwd=1)



usa_lcc <- readRDS("C:/Users/basu.e/Downloads/important_R/data/usa_lcc.rds")
world_lcc <- readRDS("C:/Users/basu.e/Downloads/important_R/data/world_lcc.rds")

# plotting both the files on top to check if everything is correct
plot(template_raster,
     col = "yellow")
plot(resampled_equates_1301,
     add = T)
raster::plot(usa_lcc, 
             add = TRUE, 
             lwd = 2)
raster::plot(world_lcc,
             add = TRUE,
             lwd = 0.5)

# EQUATES 2016
# changing the projection and making it similar to WRF
equates_1601_nc <- ncdf4::nc_open("E:/Eeshan/EQUATES/Avg.gridded.201601.nc",
                                  verbose = F)
ncdf4::nc_close(equates_1601_nc)

## changing the projection and extent from the input file/GRIDDESC
equates_1601_rast <- raster::raster("E:/Eeshan/EQUATES/Avg.gridded.201601.nc", 
                                    varname = "POC")
equates_1601_crs <- paste0("+proj=lcc +lat_1=33 +lat_2=45 +lat_0=40 +lon_0=-97 +x_0=0 +y_0=0 +datum=WGS84 +a=6370000 +b=6370000 +units=m +no_defs")
equates_1601_extent <- raster::extent(-2556000, -2556000 + 459 * 12000, -1728000, -1728000 + 299 * 12000)
raster::extent(equates_1601_rast) <- equates_1601_extent
terra::crs(equates_1601_rast) <- equates_1601_crs
plot(equates_1601_rast[[1]])

equates_1601_reproj <- raster::projectRaster(from = equates_1601_rast, crs ="+proj=lcc +lat_1=33 +lat_2=45 +lat_0=39.30345 +lon_0=-97.64413 +x_0=0 +y_0=0 +datum=WGS84 +a=6370000 +b=6370000 +units=m +no_defs")

# calculating the factor for POC (this is just an example)
# changing the resolution to the d01 domain
# Resample the raster to the new resolution
resampled_equates_1601 <- raster::aggregate(equates_1601_reproj[[1]], 
                                            fact = 3)
factor_POC <- resampled_equates_1301/resampled_equates_1601

# also checking the minimum and the maximum value
min_POC <- factor_POC@data@min
max_POC <- factor_POC@data@max

# resampling the factor on the WRF-Chem grid
resampled_POC <- resample(factor_POC, template_raster)

# open the emission netcdf and see the variables
emissions_january <- nc_open("E:/Eeshan/EQUATES/model_ready_emissions/before/2012/d01/wrfchemi_d01_2012-01-01_00%3A00%3A00",
                             write = T)
# List all variables
variables_wrf <- names(emissions_january[['var']])
nc_close(emissions_january)

# choosing the path and doing the calculations
path_files <- ("E:/Eeshan/EQUATES/model_ready_emissions/after/2012/d01/")
files <- dir(path = "E:/Eeshan/EQUATES/model_ready_emissions/after/2012/d01/",
             pattern = 'wrfchemi_d01_2012-01-*')

data_replace <- nc_open(paste0(path_files,files[i]),
                        write = T)
orgj <- ncvar_get(data_replace,
                 varid = 'E_ORGJ')

# converting the raster to a matrix
resampled_POC_matrix <- as.matrix(resampled_POC)

# replacing the NA values with 1
resampled_POC_matrix[is.na(resampled_POC_matrix)] <- 1

# transpose the matrix to make it 148*112
resampled_POC_matrix_transpose <- t(resampled_POC_matrix)

# converting the 2D matrix to a 3D matrix
resampled_POC_matrix_transpose_3d <- array(resampled_POC_matrix_transpose, dim = c(dim(resampled_POC_matrix_transpose), 1))

# extracting just the first layer of the emissions for the multiplication
emissions_first_layer <- abc[, , 1]

# Element-wise multiplication of the two matrices
result_matrix <- emissions_first_layer * resampled_POC_matrix_transpose

# converting the 2D emission matrix to a 3D emission matrix for replacement
result_matrix_3d <- array(result_matrix, dim = c(dim(result_matrix), 1))

# Replace the first layer of abc with replacement_matrix
abc[,,1] <- result_matrix_3d[,,1]

ncvar_put(test,
          varid = 'E_ORGJ',
          vals = abc)
     