# Geoinformatics 03.12.2019

install.packages('raster')
library(raster)

README <- 'HELLO-12-03-2019'

# Blue
b2 <- raster('data/rs/LC08_044034_20170614_B2.tif')
# Green
b3 <- raster('data/rs/LC08_044034_20170614_B3.tif')
# Red
b4 <- raster('data/rs/LC08_044034_20170614_B4.tif')
# Near Infrared (NIR)
b5 <- raster('data/rs/LC08_044034_20170614_B5.tif')

# coordinate reference system (CRS)
crs(b2)
# Number of rows, columns, or cells
ncell(b2)
dim(b2)
# spatial resolution
res(b2)
# Number of bands
nlayers(b2)
# Do the bands have the same extent, number of rows and columns, projection, resolution, and origin
compareRaster(b2,b3)


filenames <- paste0('data/rs/ ', 1:7, ".tif")
landsat <- stack(filenames)

# -----------------
par(mfrow = c(2,2))
plot(b2, main = "Blue", col = gray(0:100 / 100))
plot(b3, main = "Green", col = gray(0:100 / 100))
plot(b4, main = "Red", col = gray(0:100 / 100))
plot(b5, main = "NIR", col = gray(0:100 / 100))



