



``` python
# match 只匹配字符串的开始，如果开始匹配不到，那么匹配失败，而search匹配整个字符串
print(re.match('www', 'www.runoob.com').span())  # 在起始位置匹配
print(re.match('runoob', 'www.runoob.com'))  # 不在起始位置匹配 匹配失败

print(re.search('runoob', 'www.runoob.com'))  # 匹配成功
```



可以使用group(num) 或 groups() 匹配对象函数来获取匹配表达式

``` python

line = "Cats are smarter than dogs"

matchObj = re.match(r'(.*) are (.*?) .*', line, re.M | re.I)

if matchObj:
    print("matchObj.group() : ", matchObj.group())
    print("matchObj.group(1) : ", matchObj.group(1))
    print("matchObj.group(2) : ", matchObj.group(2))
else:
    print("No match!!")

searchObj.group() :  Cats are smarter than dogs
searchObj.group(1) :  Cats
searchObj.group(2) :  smarter
```



检索和替换

``` python
phone = "2004-959-559 # 这是一个国外电话号码"

# 删除字符串中的 Python注释
num = re.sub(r'#.*$', "", phone)
print("电话号码是: ", num)

# 删除非数字(-)的字符串
num = re.sub(r'\d', "", phone) # /d : 数字 /D: 非数字
print("电话号码是 : ", num)
```



用多个分隔符分割字符串

``` python
parameterList = re.split('、|,', parameterOriginString)
```



- **flags** : 可选，表示匹配模式，比如忽略大小写，多行模式等，具体参数为：
  1. **re.I** 忽略大小写
  2. **re.L** 表示特殊字符集 \w, \W, \b, \B, \s, \S 依赖于当前环境
  3. **re.M** 多行模式
  4. **re.S** 即为 **.** 并且包括换行符在内的任意字符（**.** 不包括换行符）
  5. **re.U** 表示特殊字符集 \w, \W, \b, \B, \d, \D, \s, \S 依赖于 Unicode 字符属性数据库
  6. **re.X** 为了增加可读性，忽略空格和 **#** 后面的注释