ZIP_NAME := D3

files := $(wildcard ./*)
files := $(filter-out ./Makefile, $(files))
files := $(filter-out ./$(ZIP_NAME).zip, $(files))

ifeq ($(OS),Windows_NT)
	remove = del $(ZIP_NAME).zip
else
	remove = rm -f $(ZIP_NAME).zip
endif

$(ZIP_NAME).zip: $(files)
	zip -r $(ZIP_NAME).zip $(files)

clean:
	$(remove)
