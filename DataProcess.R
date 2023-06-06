#============================================
# Unit 6 Data Process
#============================================
# ===========================================
# 6.1 数据生成
# ===========================================

# - 随机数
rnorm(100, mean=10, sd=2) #  随机生成100个正态分布，注意同时要定义mean和sd

runif(100, min = 1, max = 10) #  均匀分布

# 随机变量分布函数
dnorm(8, mean = 10, sd=2) #  这里意思是，在均值为10，标准差为2的正态分布图像上，
                          #  横坐标取8 8%），对应的y（概率）值

# P{X<= A} = accumulated_P (累计概率)
pnorm(8, mean = 10, sd=2) #  正态分布上，x取8时，累计概率
qnorm(0.1586553, mean = 10, sd=2) #  已知累计概率，求x
                                  #  这两个互为反函数

# - rep, seq函数
# rep, 生成重复值
rep(1, 10) #  生成重复1的向量，10个元素
rep(c(1:3), times=2) #  重复1，2，3，重复2次
rep(c(1:3), times=c(3:1)) #  按照aaabbc的方式重复，重复值必须与对象向量长度相等

rep(c(1:3), each=2) #  each指每个依次重复两次
rep(c(1:3), each=3)  
rep(c(1:3), each=2, times=2) #  times表示整个向量排列两次

rep(c(1:3), each=2, len=5) #  len表示只表示前5个值
rep(c(1:3), each=3, len=5)  
rep(c(1:3), each=2, times=2, len=5) #  times表示整个向量排列两次

# seq, 生成序列
seq(from=1, by=1.5, length=7) #  by定义递增量，to表示到达值
seq(from=1, to=10, length=7)
seq(from=1, to=20, length=7)

seq(from=1, to=10, by=1.5)
seq(from=1, to=10, by=1.5, length=7) #  参数设定太多，三个即可

# ===========================================
# 6.2 抽样
# ===========================================

# 随机抽样
sample(1:10, size = 5, replace = T) #  总体为1-10，样本为5，有放回抽样（replace=T)
sample(1:10, size = 15, replace=F) #  error, replace=F时，样本数量不可待遇总体
sample(1:10, size = 10, replace = T, prob = c(rep(0.05,9),0.55)) 
                                    #  rep(a,b) - 重复a， 重复b次
                                    #  设置的概率是：前9个数为0.05，第10个数为0.55


# 分层抽样
install.packages("sampling") #  安装一个数据集
library(sampling)
head(iris) #  预览一下"iris"鸢尾花的数据集
iris$Species
table(iris$Species) #  table返回频数统计

# 依次为：总体，分层变量(Species), 样本量size(为向量，长度和分层变量长度相等，
# 例如此处，Speicies有三种，那么样本量向量长度需为3, c(3:5)表示第一种类抽3个，第2种类
# 抽4个，第3种类抽5个)，method()为抽样方法选项。

strata(iris, stratanames = "Species", size = (3:5), method = c("srswr")) #  with replace 有放回
strata(iris, stratanames = "Species", size = (3:5), method = c("srswor")) #  without replace

# ===========================================
# Unit 7 Data Input and Output
# ===========================================
# ===========================================
# Unit 7.1 数据导入
# ===========================================

#### txt文件
# file.choose(), 里面空出，会弹出文件选择框；也可用文件路径（绝对和相对路径）替代，
# header为T，默认第一行作为标题，为F,则第一行作为数据
# sep定义分隔标准，"/t"为制表符，表现为空格，","为逗号分隔
txt.t <- read.table(file.choose(), header = T, sep = "/t")
txt.t

txt.c <- read.table(file.choose(), header = T, sep = ",")
txt.c

#### csv文件
csv.1 <- read.csv(file.choose())
csv.1

#### Excel文件
                                                                                                                                                                                                         
install.packages("readxl") 
library(readxl)
excel.1 <- read_excel(file.choose())
class(excel.1) # excel文件在R中有三种格式，包括data frame，因此适用于df的函数同样适用于它

### SAS/Stata/SPSS文件
install.packages("haven") 
library(haven)
help(package="haven") #  具体索引打不开，待解决

# ===========================================
# Unit 7.2 批量数据导入
# ===========================================
#### 批量数据导入- data frame
files <- list.files("路径")

data.df <- data.frame() #  先准备一个空的数据框做数据容器
for (i in 1:length(files)) {
  filepath.1 <- paste("路径", files[i], spe="")
  data.i <- read_excel(filepath.1) #  data.i 会被后面文件覆盖，但已生成的data.i会在下一行被合并进data.df
  data.df <- rbind(data.df, data.i) #  ribind-以行拼接，行数必须相等
  
}

#### 批量数据导入- list
# 当行数不等时，用data frame就会出错，此时可用list
data.ls <- list() #  准备空的列表
for(i in 1:length(files)){
  filepath.1 <- paste("路径", files[i], sep = "")
  data.ls[[i]] <- read_excel(filepath.1) #  [[i]]确定储存成分，此处直接讲每个文件读进data.ls,不需要合并
  
}

# ===========================================
# Unit 7.3 数据导出
# ===========================================
#### 数据导出

write.table(txt.t, "txt2t.txt", sep = "/t", row.names = F) #  文件，名称，分隔符，是否保留行号（一般不保留）
write.table(csv, "csv.csv", sep = ",", row.names = F)


# ===========================================
# Unit 8 Data Cleaning 
# ===========================================
# ===========================================
# Unit 8.1 样本筛选，新变量生成，排序
# ===========================================
install.packages("tidyverse")
library(tidyverse)

test <- data.frame(x=rnorm(10, mean = 50, sd=5),
                   y=sample(letters[1:3], 10, replace = T),
                   z_1=1:10,
                   z_2=2:11
                   )

# 筛选样本 filter
test %>% filter(x>50) #   %>% - 将左边变量操作到到右边函数中去，这里将数据框test操作到filter中去
test %>% filter(x>50 & y=="a")
test %>% filter(x>50 & z_1 %in% c(1:5))

# 选取变量 select
test %>% select(y)
test %>% select(starts_with("z"))
test %>% select(ends_with("1"))

test %>% filter(x>50) %>% select(y) #  操作符%>%可以连起来使用

# 生成新变量 mutate
test %>% mutate(x_1=x+1,
                x_2=x_1+1,
                x_3=if_else(x_2>50, 1, 0))

test %>% filter(x>50) %>% select(x) %>% mutate(x_1=x+1,
                                               x_2=x_1+1,
                                               x_3=if_else(x_2>50, 1, 0)) 

# 排序 arrange 
test
test %>% arrange(desc(x))
test %>% arrange(y,x)
test %>% arrange(x,y)

test %>% filter(x>50) %>% select(x) %>% mutate(x_1=x+1,
                                               x_2=x_1+1,
                                               x_3=if_else(x_2>50, 1, 0)) %>% arrange(x)


# ===========================================
# Unit 7.2 long-wide reshape 
# ===========================================
library(tidyverse)
dat <- data.frame(year=2011:2015,
                  a_city= rnorm(5, mean = 1),
                  b_city= rnorm(5, mean = 2),
                  c_city= rnorm(5, mean = 3))

dat 

#### wide --> long - gather
# 注意，宽转长时，要合并区域数据，这里从wide到long的关键变量是city，
# a_city, b_city, c_city 会被整合成 city，原abc_city 代表的GDP数据会被给到新变量 gdp
# 联想Stata是如何转换的，R里需要手动设置变量名称
dat.long <- gather(dat, key = "city", value = "gdp", -year)
dat.long

#### long --> wide - spread
spread(dat.long, key = city, value = gdp) #  比较这两种key的不同
spread(dat.long, key = year, value = gdp)

# ===========================================
# Unit 7.3 Merge 
# ===========================================
library(tidyverse)
# 先绘制三张表，表示id和log hourly wage，
# 设定test.1和test.2表来自于同一调查组，分别调查了2016和2018年的数据，调查对象时不同的
# 设定test.3来自于另一调查组，调查了2018年的数据，调查对象部分和test.1, test.2有重合
test.1 <- data.frame(id=letters[1:5],
                     log_wage_2016= rnorm(3))
test.2 <- data.frame(id=letters[6:10],
                     log_wage_2018= c(1:5))
test.3 <- data.frame(id=letters[3:7],
                     log_wage_2018= c(4,1,2,5,3))
test.1
test.2
test.3

# 单纯按行或列合并(merge)不同的表
bind_rows(test.1, test.2, test.3)
bind_cols(test.1, test.2, test.3)

# inner_join是取交集，full_join是取交集
inner_join(test.2, test.3, by="id")
full_join(test.2, test.3, by="id")

# 以test.3为参照，根据变量id，保留test.2中test.3包含的数据（最终保留的是test.2的数据）
semi_join(test.2, test.3, by="id")
# 以test.3为参照，根据变量id，保留test.2中test.3没有的数据（最终保留的是test.2的数据）
anti_join(test.2, test.3, by="id")

# 这里的左右就是括号中表的左右位置，左表示以左方的表为参照，
# 优先保留左方表的id，添加左右标中右方表中相同的id
left_join(test.2, test.3, by="id")
# 优先保留右方表的id，添加左右标中左方表中相同的id
right_join(test.2, test.3, by="id") 

