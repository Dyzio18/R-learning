# http://www.pogromcydanych.icm.edu.pl/course/lesson/11
library(PogromcyDanych)
koty_ptaki

# Pierwszy wiersz
koty_ptaki[1,]
# Pierwsza kolumna
koty_ptaki[,1]

# Ilosc wierszy
nrow(koty_ptaki)
# Ilosc kolumn
ncol(koty_ptaki)

# Indeksowanie 2, 6-8
koty_ptaki[c(2,6:8),]
# lub za pomoca zmiennej
index <- c(2,6:8)
koty_ptaki[index,]

