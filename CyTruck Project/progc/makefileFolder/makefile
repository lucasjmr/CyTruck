CC = gcc
T = ../../temp/Tprocess
S = ../../temp/Sprocess

C_T = ../cfiles/main_T.c 
HEADER_T = ../headers/header_T.h
C_S = ../cfiles/main_S.c
HEADER_S = ../headers/header_S.h

TARGET ?= all

all : $(T) $(S)
t : $(T)
s : $(S)

$(T) : $(C_T) $(HEADER_T)
	$(CC) $< -o $@


$(S) : $(C_S) $(HEADER_S)
	$(CC) $< -o $@
	
cleanhere : 
	rm -r ../../temp
	rm -f ../../images/*
	
cleanfrommainsh :
	rm -r temp/
	rm -f images/*
	
