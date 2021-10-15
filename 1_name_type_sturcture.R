#===============================
#Variable name
#===============================
variable.names <- c(1:36)
c(1:36) -> variable.name2
#simple regression names on name2
variable.name3 <- lm(variable.name2 ~ variable.names)
variable.name4 <- summary(variable.name3)
#change values
#name5=name1
#name1= 1:3
# name5 still =1:36, same in python.

# new file: ctrl+shift+n
# clean output: ctrl+l
# comments: ctrl+shift+c

#assign
assign("variable.name6", c(7:9))
variable.name6

assign("gender", c(0:1))
gender

#Naming rules

# sensitive to A/a
# avaliable with abc/123/./_
# no start with .123/123/_
# =========================================
#Data type
#==========================================
#Number
num.1 <- 224
id <- 123

#Mode
mode(id) #tell the value type
is.numeric(id) # "is" function

#String
firstcode <- "Hello world."
mode(firstcode)
is.numeric(firstcode) #logical judgement
is.character(firstcode)

district <- "123"
mode(district)
is.numeric(district)
is.character(district)

#Converter
as.numeric(district)
as.character(id)

#Logicl
TRUE; T #";"seperate codes, means different parts
FALSE; F

as.numeric(T) # "1"
as.numeric(F) # "0"

as.logical(1) #similarily
as.logical(0) 

as.logical(11) #all other numbers are TRUE.
as.logical(-11)

as.logical("FALSE") #same
as.logical("TRUE") #same

# #the followings will return "NA"
# "t"; "aa"; "100"; "1"

#=================================================
# Data structure
#=================================================
#Vectors
#all the elements in a vector should be the same, otherwise R will convert. 
#priority: character > number > logical
vec1 <- c(1:4)
is.vector(vec1)
class(vec1)

vec2<-c("a", "b", "c")
is.vector(vec2)

vec3<-c(T, T,F)
vec3
vec4<-c(1,"a")
vec4
class(vec4)

vec5<-c("a", T)
vec5
vec6<-c(1,"a", T)
vec6

#Matrix
m1<-matrix(c(1:4), nrow=2, ncol=2, byrow=T) 
# byrow, the direction of distributing elements,T=horizenal, F=vertical
m2<-matrix(c("a", "b", "c", "d", "e", "f"), nrow=3, ncol=2, byrow=F)
m1;m2

as.matrix(vec1)
as.vector(m2)

#Data frame
#data.frame can allow multiple data types
df1 <- data.frame(col1=c(1:3),col2=c("a", "b", "c"), col3=c(T, F, T))
df1
is.data.frame(df1)

as.data.frame(vec1)
as.data.frame(m2) 
class(as.vector(df1)) # it is still a "data frame"
as.matrix(df1) # now you can see all convert to strings 

#List
#the most powerful one. usuually used for saving the results.

ls1 <- list(component1=c(1:3),
            component2=matrix(c(1:4),nrow=2),
            componnet3=data.frame(col1=c(1:3)))

is.list(ls1)
class(ls1)

as.matrix(ls1)

#List releasing function 
# to change a var from list to vector 
unlist(ls1) 

#==========================================
# Unit 1 End 
#==========================================










