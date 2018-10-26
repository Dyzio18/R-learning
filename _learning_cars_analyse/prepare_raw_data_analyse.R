# Uzupełnij braki danych, znajdź wartości odstające i błędy grube w pliku cars.txt
# Zaimportuj plik do programu Statistica. Wykonaj histogramy oraz wykresy rozrzutu dla wszystkich kategorii. 
# Oblicz wartości średnie, medianę, wartości minimalne i maksymalne dla wszystkich zmiennych o charakterze ciągłym.
# W przypadku zmiennych skokowych znajdź wartość przeciętną. Uzupełnij braki danych.
# Wykonaj raport, zawierający etapy czyszczenia danych wraz z wnioskami.

# ============================================================================
# mpg <- Miles Per Gallon (*spalanie) 28 miles per gallon (Imperial) = 10 liters per 100 km
# cubicinches <- Engine volume (*pojemnosc silnika)
# hp <- Horsepower (*moc / ilosc koni mechanicznych)
# weightlbs <- Weight in lbs (10 pound = 4,535 kg)
# ============================================================================

library(ggplot2)

# Read data
# cars <- read.table(file = "cars.txt", sep=",", dec=".", header=TRUE)

cars <- read.table(file = "carsfix.txt", sep=",", dec=".", header=TRUE)

carsB <- read.table(file = "carsfix.txt", sep=",", dec=".", header=TRUE)
summary(carsB)

# ============================================================================
# Wykresy dla kazdej z kategorii wzgledem kraju produkcji - pozwala wykryc nieprawidlowe i skrajne dane

ggplot(cars, aes(x=cars$mpg, y=cars$brand)) + geom_point() + labs(title = "Brand / mpg", tag = "Cars.txt / raw", x = "Miles Per Gallon", y = "Brand")

ggplot(cars, aes(x=cars$cylinders, y=cars$brand)) + geom_point() + labs(title = "Brand / cylinders", tag = "Cars.txt / raw", x = "Cylinders", y = "Brand")

ggplot(cars, aes(x=cars$cubicinches, y=cars$brand)) + geom_point() + labs(title = "Brand / cubic inches", tag = "Cars.txt / raw", x = "Cubic inches", y = "Brand")

ggplot(cars, aes(x=cars$hp, y=cars$brand)) + geom_point() + labs(title = "Brand / Horsepower", tag = "Cars.txt / raw", x = "Horsepower", y = "Brand")

ggplot(cars, aes(x=cars$weightlbs, y=cars$brand)) + geom_point() + labs(title = "Brand / Weight", tag = "Cars.txt / raw", x = "Weight [lbs]", y = "Brand")

ggplot(cars, aes(x=cars$time.to.60, y=cars$brand)) + geom_point() + labs(title = "Brand / Time to 60 mph", tag = "Cars.txt / raw", x = "Time to 60 mph", y = "Brand")

ggplot(cars, aes(x=cars$year, y=cars$brand)) + geom_point() + labs(title = "Brand / Year", tag = "Cars.txt / raw", x = "Production year", y = "Brand")

# ============================================================================
# ============================================================================
# Usuniecie wierszy z brakujacymi wartosciami
cars <- cars[complete.cases(cars),]




# ============================================================================
# Usuwanie ekstremow poprzez zastepywanie przez mediane wartosci dla podobnych przypadkow
# outlier <- which(cars$weightlbs %in% boxplot(cars$weightlbs)$out)
# Mpg
cars$mpg[cars$mpg == 0] <- median(cars$mpg[cars$cubicinches > 340 & cars$cubicinches < 360 ])
cars$mpg[cars$mpg == 0.3] <- median(cars$mpg[cars$cubicinches > 90 & cars$cubicinches < 104 ])
cars$mpg[cars$mpg == 1236.0] <- median(cars$mpg[cars$cubicinches > 240 & cars$cubicinches < 260 ])
cars$mpg[cars$mpg == 1111.0] <- median(cars$mpg[cars$cubicinches > 340 & cars$cubicinches < 360 ])
cars$mpg[cars$mpg == 219.0] <- median(cars$mpg[cars$cubicinches > 125 & cars$cubicinches < 140 ])

# Cylinders
cars$cylinders[cars$cylinders == 0] <- median(cars$cylinders[cars$hp > 95 & cars$hp < 110 ])
cars$cylinders[cars$cylinders == 42] <- median(cars$cylinders[cars$hp > 60 &  cars$hp < 70])
cars$cylinders[cars$cylinders == 25] <- median(cars$cylinders[cars$hp > 140 &  cars$hp < 150])
cars$cylinders[cars$cylinders == 14] <- median(cars$cylinders[cars$hp > 72 &  cars$hp < 74])


# Cubiciches
cars$cubicinches[cars$cubicinches < 10] <- median(cars$cubicinches[cars$hp > 140 & cars$hp < 160 ])

# Weight
cars$weightlbs[cars$weightlbs < 1000] <- median(cars$weightlbs[cars$cubicinches > 90 & cars$cubicinches < 104 ])
cars$weightlbs[cars$weightlbs > 10000 & cars$cubicinches > 190 & cars$ cubicinches < 210] <- median(cars$weightlbs[cars$cubicinches > 190 & cars$cubicinches < 210 & cars$weightlbs < 10000])
cars$weightlbs[cars$weightlbs > 10000 & cars$cubicinches > 135] <- median(cars$weightlbs[cars$cubicinches > 135 & cars$cubicinches < 155 & cars$weightlbs < 10000])

# Hp
currHp <- cars[cars$hp < 0,]$cubicinches
cars$hp[cars$hp < 0] <- median(cars$hp[cars$cubicinches > currHp - 10 & cars$cubicinches < currHp + 10 ])
currHp <- cars[cars$hp > 1000,]$cubicinches
cars$hp[cars$hp > 1000] <- median(cars$hp[cars$cubicinches > currHp - 10 & cars$cubicinches < currHp + 10 ])
currHp <- cars[cars$hp > 900,]$cubicinches
cars$hp[cars$hp > 900] <- median(cars$hp[cars$cubicinches > currHp - 10 & cars$cubicinches < currHp + 10 ])


cars <- cars[complete.cases(cars),]

# ============================================================================

# ============================================================================
# Wykres ramka-wasy


for(i in colnames(cars)){
  if(i != 7){}
    boxplot(cars[i], horizontal=TRUE)
    hist(cars[i])
  }
}


p <- boxplot(cars$mpg, horizontal=TRUE)



hist(cars$mpg, main = "Histogram spalania", breaks=8)
hist(cars$cylinders, main = "Histogram ilosci cylindrów", breaks=8)
hist(cars$cubicinches, main = "Histogram pojemnosci silnika [in^3]")
hist(cars$hp, main = "Histogram mocy [KM]")
hist(cars$weightlbs, main = "Histogram wagi [lbs]")
hist(cars$time.to.60, main = "Histogram przyspieszenia do 60 mil [s]")
hist(cars$year, main = "Histogram roku produkcji")






summary(cars)
summary(cars$mpg)
summary(cars$cylinders)
summary(cars$cubicinches)
summary(cars$hp)
summary(cars$weightlbs)
summary(cars$time.to.60)
summary(cars$year)
summary(cars$brand)

# ============================================================================
# Linear Regression
scatter.smooth(x=cars$hp, y=cars$weightlbs, main="Weight / Power [HP]") 
scatter.smooth(x=cars$hp, y=cars$cubicinches, main="Pojemność silnika do mocy") 

# ============================================================================
# Wykresy dla kazdej z kategorii wzgledem kraju produkcji - pozwala wykryc nieprawidlowe i skrajne dane


ggplot(cars, aes(x=cars$mpg, y=cars$brand)) + geom_point() + labs(title = "Brand / mpg", tag = "Cars.txt / clean", x = "Miles Per Gallon", y = "Brand")

ggplot(cars, aes(x=cars$cylinders, y=cars$brand)) + geom_point() + labs(title = "Brand / cylinders", tag = "Cars.txt / clean", x = "Cylinders", y = "Brand")

ggplot(cars, aes(x=cars$cubicinches, y=cars$brand)) + geom_point() + labs(title = "Brand / cubic inches", tag = "Cars.txt / clean", x = "Cubic inches", y = "Brand")

ggplot(cars, aes(x=cars$hp, y=cars$brand)) + geom_point() + labs(title = "Brand / Horsepower", tag = "Cars.txt / clean", x = "Horsepower", y = "Brand")

ggplot(cars, aes(x=cars$weightlbs, y=cars$brand)) + geom_point() + labs(title = "Brand / Weight", tag = "Cars.txt / clean", x = "Weight [lbs]", y = "Brand")

ggplot(cars, aes(x=cars$time.to.60, y=cars$brand)) + geom_point() + labs(title = "Brand / Time to 60 mph", tag = "Cars.txt / clean", x = "Time to 60 mph", y = "Brand")

ggplot(cars, aes(x=cars$year, y=cars$brand)) + geom_point() + labs(title = "Brand / Year", tag = "Cars.txt / clean", x = "Production year", y = "Brand")


hist(cars$mpg)
hist(cars$cylinders)
hist(cars$cubicinches)
hist(cars$hp)
hist(cars$weightlbs)
hist(cars$time.to.60)
hist(cars$year)
hist(cars$brand)


cor(x = cars$hp, y = cars$cubicinches)
cor(x = cars$hp, y = cars$cubicinches)



carCorelation <- function( cars ) {
  
  carsCorDF <- data.frame(spalanie = cars[['mpg']], 
                          cylindry = cars[['cylinders']], 
                          pojemnosc = cars[['cubicinches']],
                          moc = cars[['hp']],
                          waga = cars[['weightlbs']],
                          przyspieszenie = cars[['time.to.60']],
                          rok = cars[['year']])
  carsCorelation <- cor(carsCorDF)
  corrplot::corrplot(carsCorelation, method = "number")
  
}


# install.packages("corrplot")

japanCar <- cars[cars$brand == 'Japan', ]
usCar <- cars[cars$brand == 'US', ]
euroCar <- cars[cars$brand == 'Europe', ]


carCorelation(japanCar)
carCorelation(usCar)
carCorelation(euroCar)


hist(japanCar$mpg) + geom_boxplot()



carsCorDF <- data.frame(spalanie = cars[['mpg']], 
                        cylindry = cars[['cylinders']], 
                        pojemnosc = cars[['cubicinches']],
                        moc = cars[['hp']],
                        waga = cars[['weightlbs']],
                        przyspieszenie = cars[['time.to.60']],
                        rok = cars[['year']])

carsCorelation <- cor(carsCorDF)
corrplot::corrplot(carsCorelation, method = "number")

cor(carsCorelation)

ggplot(cars,aes(x = cars$cubicinches ,y = cars$weightlbs ,colour = cars$brand, shape = cars$brand, size = cars$cylinders)) + geom_point()

ggplot(cars,aes(x = cars$brand ,y = cars$time.to.60)) + geom_point() + geom_violin()
