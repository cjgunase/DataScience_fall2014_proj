train<-read.csv("./train/multinomial.csv",header=FALSE)
test<-read.csv("./test/multinomialTest.csv",header=FALSE)


#-----------------------calculating prior probablilities----
prior <-table(train[,401])/length(train[,401])

#----------------------calculatring conditional probablities----
trainDem<- subset(train,train[,401]=="democratic")
trainRep<- subset(train,train[,401]=="republican")

allDem<-0
for(i in 1:400){
  allDem<-allDem+sum(trainDem[,i])
}
allDem
allRep<-0
for(i in 1:400){
  allRep<-allRep+sum(trainRep[,i])
}
allRep


#Calculate conditional probablities with add one laplace smoothing.Laplace smoothing has been done by adding 1 when calculating the likely hood to prevent a likelyhood probabality to becomig zero. For example if a word does not appear atleast one time in Democratic documents. 

demVec<-c()
repVec<-c()
for(i in 1:400){
  demVec<-c(demVec,(sum(trainDem[,i])+1)/(allDem+400))
  #demVec<-c(demVec,sum(trainDem[,i])/allDem)
}

for(i in 1:400){
  repVec<-c(repVec,(sum(trainRep[,i])+1)/(allRep+400))
  #repVec<-c(repVec,sum(trainRep[,i])/allRep)
}

#Computing the posterior probabilities for test cases
 
#Barak Obama 2014

#test[1,]

#P(c=Dems|X)
prodVec<-c()
for(i in 1:400){
  if(test[1,i] > 0){prodVec<-c(prodVec,demVec[i]^test[1,i])}
}
prior[1]*prod(prodVec)

#P(c=Rep|X)
prodVec<-c()
for(i in 1:400){
  if(test[1,i]>0){prodVec<-c(prodVec,repVec[i]^test[1,i])}
}
prior[2]*prod(prodVec)

#pridiction : Democratic (Correct !)
#2. William Clinton 1995

#test[2,]

#P(c=Dems|X)
prodVec<-c()
for(i in 1:400){
  if(test[2,i]>0){prodVec<-c(prodVec,demVec[i]^test[2,i])}
}
prior[1]*prod(prodVec)

#P(c=Rep|X)
prodVec<-c()
for(i in 1:400){
  if(test[2,i]>0){prodVec<-c(prodVec,repVec[i]^test[2,i])}
}
prior[2]*prod(prodVec)
# prediction : Democratic (Correct!)

#George w. bush 2006

#test[3,]

#P(c=Dems|X)
prodVec<-c()
for(i in 1:400){
  if(test[3,i]>0){prodVec<-c(prodVec,demVec[i]^test[3,i])}
}
prior[1]*prod(prodVec)

#P(c=Rep|X)
prodVec<-c()
for(i in 1:400){
  if(test[3,i]>0){prodVec<-c(prodVec,repVec[i]^test[3,i])}
}
prior[2]*prod(prodVec)
#Prediction : Democratic (Wrong !)



#John F Kennedy , 1962

#test[1,]

#P(c=Dems|X)
prodVec<-c()
for(i in 1:400){
  if(test[4,i]>0){prodVec<-c(prodVec,demVec[i]^test[4,i])}
}
prior[1]*prod(prodVec)

#P(c=Rep|X)
prodVec<-c()
for(i in 1:400){
  if(test[4,i]>0){prodVec<-c(prodVec,repVec[i]^test[4,i])}
}
prior[2]*prod(prodVec)

#Prediction : Democratic (Correct !)
