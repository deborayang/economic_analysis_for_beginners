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
mat.1<-matrix(c(1:4), nrow=2, ncol=2, byrow=T) 
# byrow, the direction of distributing elements,T=horizenal, F=vertical
mat.2<-matrix(c("a", "b", "c", "d", "e", "f"), nrow=3, ncol=2, byrow=F)
mat.1;mat.2

as.matrix(vec1)
as.vector(mat2)

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


#==========================================
# Unit 2 数据对象属性
#==========================================
# 1. Dimension 返回维度信息，可用于查询

dim(mat.2)
#Return: 3 2, 3 - number of rows, 2 - number of columns

dim(df1)

vec.7 <- c(1,2,3,4)
vec.7
dim(vec.7)
dim(ls1) #dim会返回list为null, 对列表的成分数量查询用length

# 2. 索引-对元素进行提取

#向量索引
vec1
vec1[c(1,3)] #返回向量的第2，第3个元素

#矩阵索引
#矩阵的索引不需要用c()，因为不加c()默认返回的是二维的位置信息。向量只有一维，所以要用中括号家c()
mat.1; mat.2
mat.1[2] #row1, col1 按照填充顺序来，刺猬错误示范
mat.1[1,2] #row1, col2
mat.2[2, ] #row2
mat.2[ ,2] #col2
class(mat.2[ ,2]) #记住矩阵索引返回的是向量


#数据框索引
#与矩阵索引语法类似，但数据格式本质不同
df1
df1[1]
class(df[1])

df["col1"] #不明原因，全是error
df[["col1"]]
df["2", "col3"]

df1[1, ]
df1[ ,2]
df1[1,2]
df[1:2,1]

#列表索引
ls1
ls1[[1]] #返回第1个component
ls1[[2]]
ls1[2][ ,2] #返回第2个component矩阵的col2
ls1["component1"]

# 3. 名称
vec1
vec2
names(vec1) <- vec2 #把vec2的三个字母作为vec1三个元素的名称
vec1
names(vec1)

dimnames(mat.1) <- list(c("r1","r2"), c("c1", "c2"))
mat.1
dimnames(mat.1)

df1
rownames(df1)
colnames(df1)
names(df1)

names(ls1)

#==========================================
# Unit 2.4 数据对象属性
#==========================================

#常量
# 字母，分大小写，返回26个英文字母
letters
LETTERS
LETTERS[1:3] #提取相应的位置
month.name # 月份，英文全称
month.name[6:7]
month.abb #月份，英文缩写
pi #圆周率，默认六位小数

# - NA; Inf, -Inf, NaN, NULL
length(vec1) <- 4
vec1 #将vec1的长度设置为4后，起变为长度为4，实际只有三个元素的向量

2^1024 #正无穷, Inf
-1/0 #负无穷, -Inf (0除以“-1”，R中分母放前面)

# NaN, Not a Number
Inf - Inf 
0/0

#==========================================
# Unit 3 基础操作
#==========================================
#==========================================
# Unit 3.1 数学运算
#==========================================

#加减乘除
c(2,4,5)+c(3,6) #向量加减，但长度不同，会不断循环扩展
c(2,4,5)-c(3,6,9,10) #没有元素的地方会进行循环扩展（补充）
c(2,4,5)*c(3,6) #没有元素的地方会进行循环扩展（补充）
c(2,4,5)/c(3,6) #没有元素的地方会进行循环扩展（补充）

#取商除法
2%/%3
3%/%2

#取余除法（不是取小数点）
2%%3
3%%2

#幂指数
2^3
27^(1/3)

#求和
vec8 <- c(1,2,3)
sum(vec8)
vec7 <- c(8:12)
sum(vec.7)

#求积
prod(vec8)
prod(vec.7)

#累加和
cumsum(vec8)

#累乘积
cumprod(vec8)

#四舍五入到指定小数位
round(3.141592657)
round(3.141592657, 4)

#天花板
ceiling(4.6)

#地板
floor(4.6)

#矩阵转置
t(mat.1)

#矩阵乘法
mat.3 <- matrix(c(3:8), nrow=2)
mat.1%*%mat.3

#矩阵行列式(针对方阵)
det(mat.1)

#矩阵的迹（主对角线元素的和）
sum(diag(mat.1))

#矩阵求逆
solve(mat.1)

#解线性方程组
mat.4 <- matrix(c(7,8), nrow=2)
#解方程：mat.1%*% x =mat.4
solve(mat.1, mat.4)

#==========================================
# Unit 3.2 字符运算
#==========================================

#字符长度
char.1 <- c("Hello World!")
nchar(char.1)
nchar(vec2)

#字符连接
char.2 <- c("123")
paste(char.1, char.2, sep=",") #sep=""定义链接分隔符，可用空格
paste(char.1, vec2, sep="  ")
paste(colnames(df1), collapse = "+") #data frame 三个cols连成向量

#字符拆分
strsplit(char.1, split = " ") #以空格为界定拆分
unlist(strsplit(char.1, split = " ")) 

#字符替换
gsub(" ", "!", char.1) #空格替换为！

#转换为大小写字母
toupper(char.1)
tolower(char.1)

#==========================================
# Unit 3.3 關係运算
#==========================================
#非常重要，应用于数据条件筛选
#是否相等
2==3

#是否不相等
2!=3

#是否大于
2>3

#是否小于等于
2<=3

#是否被包含
2%in%c(2,3)

#与 & 满足所有条件
(2<=3)&(4<=5)
(2<=3)&(4>=5)

#或 | (option+shift+7) 满足一个条件即可
(2<=3)|(4>=5)

#非 !

#==========================================
# Unit 3.4 條件和循環語句
#==========================================

#條件語句
# if else
a <- 2
if(a>2){
  print("a is greater than 2")
}else{
  print("a is not greater than 2")
}

# if-else, else-if结构
b <- 1
if(b>2) {
  print("b is greater than 2")
} else if(b>0) {
  print("b is greater than 0 and smaller than 2")
} else {
  print("b is not greater than 0")
}

# ifelse 用於根據新條件生成新變量
d <- 5
ifelse(d>4, d, d*2) # 判断条件为d>4，TRUE为d，FALSE为d*2，用逗号隔开

# 循环语句
# for 循环 - 先界定范围
for (i in c(1:4)) {
  print(i+1)
}

# while 循环 - 界定循环条件
i <- 10
while (i<15) {
  print(i)
  i <- i+1 #不加的后果是无限10循环。这里的目的是重新赋值i，使循环终止。
}
  
#==========================================
# Unit 3.5 自定义函数
#==========================================
choose(10,4) #排列组合, 10选4
factorial(4) #阶乘，1*2*3*4

my.permutation.func <- function(arugment1, argument2){
  result <- choose(arugment1, argument2)*factorial(argument2)
  return(result)
}#定义完毕，返回新定义变量result. argument1，2相当于function(n,k)

my.permutation.func(10,4)

# 自定义二院操作符- 格式 "%...%"
"%npm%" <- function(n.m){
  choose(n,m)*factorial(m)
}
10 %npm% 4

#==========================================
# Unit 4 Pachages
#==========================================
#查看已安装包
library()

#查看已加载包
(.packages())

#查看包管理情况
packageStatus()

#安装包
plot_missing(airquality)

# 1.代码方式安装
install.packages("DataExplorer")

# 2.菜单方式安装 - Tools

#加载包，R中要加载方可使用
library(DataExplorer)

#更新包
upgrade(packageStatus())

#查看包帮助
hlep(packages ="DataExplorer")

#暂时卸载包
detach(package:DataExplorer)

#彻底移除包
remove.packages("DataExplorer")

#==========================================
# Unit 5 帮助，代码风格
#==========================================
# 5.1获取帮助
#函数帮助
help(lm)
?lm
example(lm)

#关键词帮助
help.search("regression")
??regression

# 5.2编程风格- 遵循Google和R社区共同约定守则
