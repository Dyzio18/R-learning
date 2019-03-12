# Geoinformatics 03.12.2019

install.packages('raster')
install.packages('rgdal')

library(raster)
library(rgdal)



README <- 'HELLO-12-03-2019'

# Blue
b2 <- raster('data/rs/LC81870262016221LGN00_B2.tif')
# Green
b3 <- raster('data/rs/LC81870262016221LGN00_B3.tif')
# Red
b4 <- raster('data/rs/LC81870262016221LGN00_B4.tif')
# Near Infrared (NIR)
b5 <- raster('data/rs/LC81870262016221LGN00_B5.tif')

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


filenames <- paste0('data/rs/LC81870262016221LGN00_B', 1:7, ".tif")
filenames
landsat <- stack(filenames)
landsat

# -----------------
par(mfrow = c(2,2))
plot(b2, main = "Blue", col = gray(0:100 / 100))
plot(b3, main = "Green", col = gray(0:100 / 100))
plot(b4, main = "Red", col = gray(0:100 / 100))
plot(b5, main = "NIR", col = gray(0:100 / 100))


landsatRGB <- stack(b4, b3, b2)
landsatFCC <- stack(b5, b4, b3)
plotRGB(landsatRGB, axes = TRUE, stretch = "lin", main = "Landsat True Color Composite")

# select first 3 bands only
landsatsub1 <- subset(landsat, 1:3)
# same
landsatsub2 <- landsat[[1:3]]
# Number of bands in orginal and new data
nlayers(landsat)

# Spatial subset or crop
e <- extent(landsat)
landsatcrop <- crop(landsat, e)

croppLand <- writeRaster(landsatcrop,filename = "cropped-landsat.tif", overwrite = TRUE)
pairs(landsatcrop[[1:2]], main = "Ultra-blue versus Blue")


