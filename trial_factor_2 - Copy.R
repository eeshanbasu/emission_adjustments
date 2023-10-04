```{r}
library(raster)
library(rasterVis)
library(RColorBrewer)
```
```{r}
##making the dummy raster
# Define the projection (example: Lambert Conformal Conic)
projection <- CRS("+proj=lcc +lat_1=33 +lat_2=45 +lat_0=39.30345 +lon_0=-97.64413 +x_0=0 +y_0=0 +datum=WGS84 +a=6370000 +b=6370000 +units=m +no_defs")

# Define the extent (example: extent of the continental United States)
# the first one is the x-orig from the template file
wrf_extent <- extent(-2664000, -2664000 + 148 * 36000, -2016000, -2016000 + 112 * 36000)  # xmin, xmax, ymin, ymax

# Define the resolution (example: 1 km)
resolution <- c(36000, 36000)  # x-res, y-res in meters
```

```{r}
# Create a raster layer with constant value 1
template_raster <- raster(wrf_extent, res = resolution, crs = projection)
template_raster[] <- 1  # Set all grid cells to 1
```

```{r}

# Plot the raster with grid cell boundaries
plot(template_raster, 
     col=c(topo.colors(200)), 
     axes=FALSE, 
     box=FALSE)
plot(rasterToPolygons(template_raster), 
     add=TRUE, 
     border='black', 
     lwd=1) 
```
```{r}
# EQUATES
# changing the projection and making it similar to WRF
equates_nc <- ncdf4::nc_open("E:/Eeshan/EQUATES/Avg.gridded.201301.nc",
                             verbose = F)
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
```


```{r}
# making the plot
n_colors <- 20

# Create a custom color palette
custom_palette <- colorRampPalette(c("white", "red"))(n_colors)

plot(equates_reproj[[1]],
     col = custom_palette, 
     axes=FALSE, 
     box=TRUE)
# plot(rasterToPolygons(equates_reproj[[1]]), 
#      add=TRUE, 
#      border='black', 
#      lwd=1)
```
```{r}
# changing the resolution to the d01 domain
# Resample the raster to the new resolution
resampled_equates <- raster::aggregate(equates_reproj[[1]], 
                                       fact = 3)

# Plot the resampled raster
plot(resampled_equates, 
     col = custom_palette, 
     axes = FALSE, 
     box = TRUE)
plot(rasterToPolygons(resampled_equates[[1]]),
     add=TRUE,
     border='black',
     lwd=1)
```
```{r}
plot(template_raster,
     col = "yellow")
plot(resampled_equates,
     add = T)
```

