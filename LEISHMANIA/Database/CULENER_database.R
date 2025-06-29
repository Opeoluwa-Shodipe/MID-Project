
setwd("/Users/noorhidayatallah/Desktop/MTM/MID/Diagnostic test/Database")

install.packages("dplyr")
library("dplyr")
library("tibble")
library("readxl")
library("ggplot2")

## Loading Datasets

DNA_ext <- read.csv("~/Desktop/MTM/MID/Diagnostic test/Database/Re_ Sensitivity of the PCR/DNA extraction.csv")
View(DNA_ext)
Hospital <- read.csv("~/Desktop/MTM/MID/Diagnostic test/Database/Re_ Sensitivity of the PCR/Hospital.csv")
View(Hospital)
Samples <- read.csv("~/Desktop/MTM/MID/Diagnostic test/Database/Re_ Sensitivity of the PCR/Samples.csv")
View(Samples)
PCR <- read.csv("~/Desktop/MTM/MID/Diagnostic test/Database/Re_ Sensitivity of the PCR/PCR.csv")
View(PCR)
RFLP <- read.csv("~/Desktop/MTM/MID/Diagnostic test/Database/Re_ Sensitivity of the PCR/RFLP.csv")
View(RFLP)
 
metadata <- read.csv("~/Desktop/MTM/MID/Diagnostic test/Database/Re_ Sensitivity of the PCR/metadata.csv")
View(metadata)

# View the updated dataframe
print(metadata)

Sam_DNA <-left_join(Samples, DNA_ext, by ="SampleID")
View(Sam_DNA)
Sam_DNA_PCR <- left_join(Sam_DNA, PCR, by="SampleID_E")
View(Sam_DNA_PCR)

Sam_DNA_PCR_RFLP <- left_join(Sam_DNA_PCR, RFLP, by="SampleID_P")
View(Sam_DNA_PCR_RFLP)

Results <- select(Sam_DNA_PCR_RFLP, SampleID, Hospital_Code, SampleID_E, Run_E, SampleID_P, PCR.round, Band.brightness, Storage.box.number, Remark.y, RFLP.Round, RFLP.Tube, Leishmania.spp)
View(Results)

# Metadata
metadata_total<- full_join(Sam_DNA_PCR_RFLP, metadata)
#Metadata Extraction
metadata_extraction <- select(DNA_ext, 4:7)
names(metadata_extraction)[names(metadata_extraction) == "Remark"] <- "Date"
#Metadata PCR
metadata_PCR <- select(metadata_total, PCR.round, Remark.y, Manipulator_P, MasterMix, Batch_no., Pipette_P)
View(metadata_PCR)
#Metadata RFLP
metadata_RFLP <- select(metadata_total,RFLP.Round, Manipulator_R, Reagent, Date)
View(metadata_RFLP)

Results_metadata <- full_join(Results, metadata)


