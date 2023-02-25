``` ruby
# 执行终端代码
puts `ruby --version`

=begin
多行注释
=end

puts "打印会换行"
print "打印不会换行"

str = '123'
puts "#{str}" # 打印 123
puts '#{str}' # 打印 #{str}

# 万物皆对象
puts 1.class # Integer
puts "1".class # String
puts nil.class # NilClass

# Q:双引号规则 q:单引号规则
puts %Q{#{str}} # 打印 123
puts %q{#{str}} # 打印 #{str}

# 定义一个符号
:cat
puts :cat # Symbol
# 符号在ruby中是唯一的
c = :cat
puts c == :cat # true
puts c == :'cat' # true 
c.to_s # 符号转字符串
'cat'.to_sym # 字符串转符号

puts c.object_id # 25417
puts :cat.object_id # 25417

# 通过method获取符号代表的方法
puts "hello".method(:class).class # Method

puts 3.+(3) # 6 
puts 3.+ 3 # 6 

# 组合比较运算符
# 返回1，第一个参数大
# 返回0，两个参数相等
# 返回-1，右边参数大
puts 1 <=> 10 #=> -1 (1 < 10)
puts 10 <=> 1 #=> 1 (10 > 1)
puts 1 <=> 1 #=> 0 (1 == 1)

# and 左侧执行成功，继续执行右侧
(1 < 0) and (puts "mm")
# or 左侧执行失败，继续执行右侧
(1 < 0) or (puts "cc")
```



## string

``` ruby


cat = 'cat'

# utf-8
puts cat.encoding.name
# 非破坏性
newStr = cat.encode!('ISO-8859-1')
puts cat.encoding.name
# 破坏性
cat.force_encoding('ISO-8859-1')
puts cat.encoding.name

# do 相当于swift中的闭包
newStr.each_byte do |byte|
    puts byte
end
# 相当于swift中的尾随闭包
newStr.each_byte { | byte |
    puts byte
}

# 拼接字符串
puts 'hello ' + 'world' #=> "hello world"
puts 'hello ' + 3.to_s #=> "hello 3"

# 拼接一个对象
puts 'hello' << ' world'
puts 'hello' << newStr

# 重复输出指定字符串n次
puts 'hello ' * 3 #=> "hello hello hello "

# =~ 返回匹配到到字符的索引（如果没有匹配，则返回nil） 两个斜线代表正则
puts 'Cat' =~ /[t]/

# 格式化字符串
puts format('%05d', 123)
puts format("%-5s: %08x #{cat}", 'ID', 44)

# 首字母大写
puts cat.capitalize
# ? !操作符 不一样的
# ？：返回的是一个 布尔值
puts cat.empty?
puts "123" == "123"
# ！破坏性
puts "123".eql?("123")

# "cat"
puts cat.sub(/[a]/, "b")

sleep 1
```

