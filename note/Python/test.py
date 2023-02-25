# encoding: utf-8
import re


readPath = "/Users/blf/Desktop/111.txt"

f = open(readPath)
string = f.read()

patter = "\(.*?\),"
lines = re.findall(patter, string)
print(lines)

writePath = "/Users/blf/Desktop/222.txt"
with open(writePath, 'w') as f: # 如果filename不存在会自动创建， 'w'表示写数据，写之前会清空文件中的原有数据！
    f.write("如果filename不存在会自动创建， 'w'表示写数据，写之前会清空文件中的原有数据！\n")