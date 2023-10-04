# first try to github
library(ncdf4)
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

## EQUATES variables
# var_equates <- c("POC", "NO2", "SO2", "NH3", "PEC", "NO", "PSO4", "ALD2", "ALDX", "BENZ", 
#                  "ETH", "ETHA", "FORM", "HONO", "IOLE", "ISOP", "TERP", "TOL")

# EQUATES variables
var_equates <- c("TERP", "TOL")

## WRF-Chem variables
# var_wrfchem <- c("E_ORGJ", "E_NO2", "E_SO2", "E_NH3", "E_PM25J", "E_NO", "E_SO4J", "E_ALD2", "E_ALDX", "E_BENZENE", 
#                  "E_ETH", "E_ETHA", "E_FORM", "E_HONO", "E_IOLE", "E_ISOP", "E_TERP", "E_TOL")

var_wrfchem <- c("E_TERP", "E_TOL")

for (i in 1:length(var_equates)) {
  
  ## changing the projection and extent from the input file/GRIDDESC
  equates_1301_rast <- raster::raster("E:/Eeshan/EQUATES/Avg.gridded.201301.nc", 
                                      varname = var_equates[i])
  equates_1301_crs <- paste0("+proj=lcc +lat_1=33 +lat_2=45 +lat_0=40 +lon_0=-97 +x_0=0 +y_0=0 +datum=WGS84 +a=6370000 +b=6370000 +units=m +no_defs")
  equates_1301_extent <- raster::extent(-2556000, -2556000 + 459 * 12000, -1728000, -1728000 + 299 * 12000)
  raster::extent(equates_1301_rast) <- equates_1301_extent
  terra::crs(equates_1301_rast) <- equates_1301_crs
  equates_1301_reproj <- raster::projectRaster(from = equates_1301_rast, crs ="+proj=lcc +lat_1=33 +lat_2=45 +lat_0=39.30345 +lon_0=-97.64413 +x_0=0 +y_0=0 +datum=WGS84 +a=6370000 +b=6370000 +units=m +no_defs")
  
  # changing the resolution to the d01 domain
  # Re-sample the raster to the new resolution
  resampled_equates_1301 <- raster::aggregate(equates_1301_reproj[[1]], 
                                              fact = 3)
  
  ## changing the projection and extent from the input file/GRIDDESC
  equates_1601_rast <- raster::raster("E:/Eeshan/EQUATES/Avg.gridded.201601.nc", 
                                      varname = var_equates[i])
  equates_1601_crs <- paste0("+proj=lcc +lat_1=33 +lat_2=45 +lat_0=40 +lon_0=-97 +x_0=0 +y_0=0 +datum=WGS84 +a=6370000 +b=6370000 +units=m +no_defs")
  equates_1601_extent <- raster::extent(-2556000, -2556000 + 459 * 12000, -1728000, -1728000 + 299 * 12000)
  raster::extent(equates_1601_rast) <- equates_1601_extent
  terra::crs(equates_1601_rast) <- equates_1601_crs
  equates_1601_reproj <- raster::projectRaster(from = equates_1601_rast, crs ="+proj=lcc +lat_1=33 +lat_2=45 +lat_0=39.30345 +lon_0=-97.64413 +x_0=0 +y_0=0 +datum=WGS84 +a=6370000 +b=6370000 +units=m +no_defs")
  
  # calculating the factor for POC (this is just an example)
  # changing the resolution to the d01 domain
  # Resample the raster to the new resolution
  resampled_equates_1601 <- raster::aggregate(equates_1601_reproj[[1]], 
                                              fact = 3)
  # Create the dataframe name using paste0
  df_name <- paste0("factor_",var_equates[i])
  
  # Create the dataframe and assign it to the name
  x <- assign(df_name, resampled_equates_1301/resampled_equates_1601)
  
  ## also checking the minimum and the maximum value
  # min_POC <- factor_POC@data@min
  # max_POC <- factor_POC@data@max
  
  # re-sampling the factor on the WRF-Chem grid
  resampled_emissions <- resample(x, template_raster)
  
  # converting the raster to a matrix
  resampled_emissions_matrix <- as.matrix(resampled_emissions)
  
  # replacing the NA values with 1
  resampled_emissions_matrix[is.na(resampled_emissions_matrix)] <- 1
  
  # transpose the matrix to make it 148 * 112
  resampled_emissions_matrix_transpose <- t(resampled_emissions_matrix)
  
  ## converting the 2D matrix to a 3D matrix
  ## no need
  # resampled_emissions_matrix_transpose_3d <- array(resampled_emissions_matrix_transpose, dim = c(dim(resampled_emissions_matrix_transpose), 1))
  
  # choosing the path and doing the calculations
  path_files <- ("E:/Eeshan/EQUATES/model_ready_emissions/after/2012/d01/")
  files <- dir(path = "E:/Eeshan/EQUATES/model_ready_emissions/after/2012/d01/",
               pattern = 'wrfchemi_d01_2012-01-*')
  
  for (j in 1:length(files)) {
  
    data_replace <- nc_open(paste0(path_files,files[j]),
                            write = T)
    
    pollutant <- ncvar_get(data_replace,
                           varid = var_wrfchem[i])
    
    # extracting just the first layer of the emissions for the multiplication
    emissions_first_layer <- pollutant[,,1]
    
    # Element-wise multiplication of the two matrices
    result_matrix <- emissions_first_layer * resampled_emissions_matrix_transpose
    
    # converting the 2D emission matrix to a 3D emission matrix for replacement
    result_matrix_3d <- array(result_matrix, dim = c(dim(result_matrix), 1))
    
    # Replace the first layer of pollutant with replacement_matrix
    pollutant[,,1] <- result_matrix_3d[,,1]
    
    ncvar_put(data_replace,
              varid = var_wrfchem[i],
              vals = pollutant)
    
    nc_close(data_replace)
    
    # Print the filename that was processed
    cat("Processed file:", files[j], "and pollutant:", var_wrfchem[i], "\n")
    
  }
  
}

