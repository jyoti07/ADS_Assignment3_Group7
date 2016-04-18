#read file
Agassiz1=read.csv("Agassiz Jan-june 2014.csv", header=TRUE)
Agassiz2=read.csv("Agassiz Jul-Dec 2014.csv", header=TRUE)



#merge files
Agassiz <- rbind(Agassiz1, Agassiz2)


#transpose file Agassiz
install.packages("reshape")
library(reshape)
AgassizTranspose <- melt(Agassiz, id=c("Account","Date","Channel","Units"))



#export file to Desktop as csv
write.csv(AgassizTranspose, "AgassizTranspose.csv" )










