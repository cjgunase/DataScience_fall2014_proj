
library(e1071)
library(caret)
train<-read.csv("./train/bernouli.csv")
nzro<-nearZeroVar(train[,-360])
train<-train[,-nzro]
test<-read.csv("./test/bernouliTest.csv")
test<-test[,-nzro]

#calculating prior probablilities
prior <-table(train[,341])/length(train[,341])

#calculating p(evidence) for each word in Democratic and republican. Then calculate the likelyhoods p(word|Dems) and p(word|Rep)
#Laplace smoothing has been done by adding 1 when calculating the likely hood to prevent a likelyhood probabality to becomig zero. For example if a word does not appear atleast one time in Democratic documents. p(word|Democratic)=0. 

trainDem<- subset(train,train[,341]=="Democratic")
trainRep<- subset(train,train[,341]=="Republican")
demVec<-c()
repVec<-c()
for(i in 1:340){
  pWordgivenParty<-(sum(as.numeric(trainDem[,i]))+1)/length(trainDem[,341])
  demVec<-c(demVec,pWordgivenParty)
}
for(i in 1:340){
  pWordgivenParty<-(sum(as.numeric(trainRep[,i]))+1)/length(trainRep[,341])
  repVec<-c(repVec,pWordgivenParty)
}




#Computing the posterior probabilities for test cases
 
#Barak Obama 2014

#test[1,]

#P(c=Dems|X)
prodVec<-c()
for(i in 1:340){
  if(test[1,i]==1){prodVec<-c(prodVec,demVec[i])}else{prodVec<-c(prodVec,(1-demVec[i]))}
}
prior[1]*prod(prodVec)

#P(c=Rep|X)
prodVec<-c()
for(i in 1:340){
  if(test[1,i]==1){prodVec<-c(prodVec,repVec[i])}else{prodVec<-c(prodVec,(1-repVec[i]))}
}
prior[2]*prod(prodVec)

#pridiction : Democratic (Correct !)

#2. William Clinton 1995

#test[2,]

#P(c=Dems|X)
prodVec<-c()
for(i in 1:340){
  if(test[2,i]==1){prodVec<-c(prodVec,demVec[i])}else{prodVec<-c(prodVec,(1-demVec[i]))}
}
prior[1]*prod(prodVec)

#P(c=Rep|X)
prodVec<-c()
for(i in 1:340){
  if(test[2,i]==1){prodVec<-c(prodVec,repVec[i])}else{prodVec<-c(prodVec,(1-repVec[i]))}
}
prior[2]*prod(prodVec)
# prediction : Democratic (Correct!)

#George w. bush 2006

#test[3,]

#P(c=Dems|X)
prodVec<-c()
for(i in 1:340){
  if(test[3,i]==1){prodVec<-c(prodVec,demVec[i])}else{prodVec<-c(prodVec,(1-demVec[i]))}
}
prior[1]*prod(prodVec)

#P(c=Rep|X)
prodVec<-c()
for(i in 1:340){
  if(test[3,i]==1){prodVec<-c(prodVec,repVec[i])}else{prodVec<-c(prodVec,(1-repVec[i]))}
}
prior[2]*prod(prodVec)
#Prediction : Democratic (Wrong !)



#John F Kennedy , 1962

#test[1,]

#P(c=Dems|X)
prodVec<-c()
for(i in 1:340){
  if(test[4,i]==1){prodVec<-c(prodVec,demVec[i])}else{prodVec<-c(prodVec,(1-demVec[i]))}
}
prior[1]*prod(prodVec)

#P(c=Rep|X)
prodVec<-c()
for(i in 1:340){
  if(test[4,i]==1){prodVec<-c(prodVec,repVec[i])}else{prodVec<-c(prodVec,(1-repVec[i]))}
}
prior[2]*prod(prodVec)
#Prediction : Democratic (Correct!)