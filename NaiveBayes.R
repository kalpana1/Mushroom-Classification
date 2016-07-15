df <- read.csv("mushroom.txt",header=FALSE, stringsAsFactors=TRUE)
a<-apply(df,2,function(x) gsub("\\?",names(sort(-table(x,exclude="?")))[1],x))
a<-as.data.frame(a)
View(a)

str(a)
#$ V17: Factor w/ 1 level "p": 1 1 1 1 1 1 1 1 1 1 ...
a$V17<-NULL
table(a$V1)

sub = sample(nrow(a), floor(nrow(a) * 0.6))
train = a[sub,]
test = a[-sub,]

xTrain = train
yTrain = train$V1

xTest = test
yTest = test$V1

model = train(xTrain,yTrain,'nb',trControl=trainControl(method='cv',number=5))
prop.table(table(predict(model$finalModel,xTest)$class,yTest))
