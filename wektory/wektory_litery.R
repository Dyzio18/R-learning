# http://www.pogromcydanych.icm.edu.pl/course/lesson/11

# Wektor do cwiczenia
LETTERS

# Dlugosc wektora
length(LETTERS)

# Rozne kombinacje 
LETTERS[1:10]
LETTERS[c(1:10,20:30)]
# Sekwencja - co druga litera [rosnaco]
az <- LETTERS[seq(from = 1, to = length(LETTERS), by = 2)]
# Sekwencja - co druga litera [malejaco]
za <- LETTERS[seq(from = length(LETTERS), to = 1, by = -2)]
# Zlaczenie wektorow i posortowanie ciagu
azAll <- c(az,za)
azAll <- sort(azAll)

# *** Zadania ***

# A) Zbuduj sekwencję dziesięciu kolejnych małych liter alfabetu łacińskiego.
letters[1:10]
# B) Zbuduj sekwencję dziesięciu kolejnych liczb nieparzystych zaczynając od 3.
letters[seq(from = 3, to = 12)]
# C) Z wektora LETTERS wybierz litery na pozycjach 5, 10, 15, 20 i 25.
LETTERS[seq(5,25,5)]
LETTERS[c(5,19,15,20,25)]
# D) Wypisz wartości wektora LETTERS od końca.
LETTERS[c(length(LETTERS):1)]





