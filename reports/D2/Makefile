#https://stackoverflow.com/questions/4879592/whats-the-difference-between-and-in-makefile
files := $(wildcard ./*)
files := $(filter-out ./Makefile, $(files))
files := $(filter-out ./D2.zip, $(files))

ifeq ($(OS),Windows_NT)
	remove = del D2.zip
else
	remove = rm -f D2.zip
endif

D2.zip: $(files)
	zip -r D2.zip $(files)

clean:
	$(remove)
