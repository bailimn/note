# 定义一个函数
def sayHello
    puts "hello world"
end

# 调用一个函数
sayHello

# 定义一个有参函数
def sayHello2(name)
    puts "hello #{name}"
end

sayHello2("zhangsan")

# 定义一个参数有默认值的函数
def sayHello3(name="wangwu")
    puts "hello #{name}"
end

sayHello3()


# @name 实例变量，可以被本类和子类使用
class Player
    def initialize(name = "zhangsan")
        @name = name
    end
    def show()
        puts "palyer: #{@name}"
    end
end

player = Player.new("wangwu")
player.show()

# instance_methods(all:bool): 列出对象（类）内部的方法
puts Player.instance_methods(true) # 参数：是否打印出所有方法，为false时只打印自己定义的方法
# respond_to? : 调查对象的方法/属性是否可用
# end : 执行对象的方法
if player.respond_to?("show")
    player.send("show")
end


# attr_accessor: 定义可存取对象的属性
class Game
    attr_accessor :price, :title
    def initialize(title = "怪物猎人", price = 100)
        @title = title
        @price = price
    end
    def show()
        puts "标题：#{title}"
        puts "价格：#{price}"
    end
end

game = Game.new()
game.show

game.title = "lisi"
game.price = 99
game.show

a = 10
b = 20
puts "**********"
puts a + b
puts a  +b
puts "**********"

print <<EOF
这是第一种方式创建 here document
多行字符串
EOF

print <<"EOF"
这是第二种方式创建 here document
多行字符串
EOF

print <<`EOC` # 执行命令
    echo hi there
    echo lo there
    ls
EOC

# hi there
# lo there
# ls 命令输出

print <<"foo", <<"bar" # 堆叠方式
I said foo.
foo
I said bar.
bar


=begin
    这里是注释1
    这里是注释1
=end

ary = ["a", 10, "b"]
ary.each do |i|
    puts i
end

hsh = colors = {"red" => 0xf00, "green" => 0x0f0}
hsh.each do |key, value|
    print key, " is ", value, "\n"
end

(10..15).each do |n|
    print n, ' '
end

$global_variable = 10
class Customer
    @@no_of_customers=0
    def initialize(id, name)
        @cust_id=id
        @cust_name=name
        @@no_of_customers += 1
    end
    def show()
        puts @cust_id, @cust_name
        puts "#{@cust_id}"
    end

    def show2
        # 文本和带有符号（#）的实例变量应使用双引号标记。
        puts "#{@cust_name} #@cust_id"
        puts "Total number: #@@no_of_customers"
        puts $global_variable
        puts "#$global_variable"
    end
end

cust=Customer.new("123", "zhangsan")
cust.show
cust.show2

# <=> : 联合比较运算符。a = b 返回 0，a < b 返回 -1，a > b 返回 1
puts a <=> b
# -1

# === : 用于测试 case 语句的 when 子句内的相等。(1...10) === 5 返回 true
puts (1...10) === 5
# true

puts 1 == 1.0
puts 1.eql?(1.0)
# true
# false

puts (a and b)
puts a && b

foo = 23
defined? foo    # => "local-variable"
defined? $_     # => "global-variable"
defined? bar    # => nil（未定义）
defined? puts(bar)   # => nil（在这里 bar 未定义）
defined? super     # => "super"（如果可被调用）
defined? super     # => nil（如果不可被调用）
defined? yield    # => "yield"（如果已传递块）
defined? yield    # => nil（如果未传递块）

x=1
if x > 2
    puts "x 大于 2"
elsif x <= 2 and x!=0
    puts "x 是 1"
else 
    puts "未知"
end

# x 是 1

$debug = 1
print "debug\n" if $debug

# debug

$i = 0
$num = 5
begin
    puts("i = #$i")
    $i += 1
end while $i < $num

# i = 0
# i = 1
# i = 2
# i = 3
# i = 4

for i in 0..5
    puts i
end

(0..5).each do |i|
    puts i
end

def test
    puts "在 test 方法内"
    yield
    puts "你又回到了 test 方法内"
    yield
end

test { puts "你在块内" }
# 在 test 方法内
# 你在块内
# 你又回到了 test 方法内
# 你在块内

def test2
    yield 5
    puts "在 test2 方法内"
    yield 100
end

test2 { |i| puts "你在块 #{i} 内"}
# 你在块 5 内
# 在 test2 方法内
# 你在块 100 内

module Trig
    PI = 3.14
    def Trig.sin
        puts Trig::PI * Trig::PI
    end
end

Trig.sin
# 9.8596

myStr = String.new("this is test")
foo = myStr.downcase
puts "#{foo}"

puts "K"*10 # KKKKKKKKKK
puts "K" + "M" # KM
puts "K" <=> "M" # -1
puts "K" == "M" # false
puts "TestString"[3] # t
puts "TestString"[3..4] # tS
puts "TestString"[3...4] # t
puts "TestString"[3, 4] # tStr
puts "testString".capitalize # Teststring
puts "testString".capitalize! # 与 capitalize 相同，但是 str 会发生变化并返回。
puts "TestString".casecmp("estString") # 不相等： 1。 相等： 0 不区分大小写的字符串比较。
puts "TestString".chomp # 从字符串末尾移除记录分隔符（$/），通常是 \n。如果没有记录分隔符，则不进行任何操作。
puts "TestString".chomp! # 与 chomp 相同，但是 str 会发生变化并返回。
puts "TestString".chop # 移除 str 中的最后一个字符。
puts "TestString".chop! # 与 chop 相同，但是 str 会发生变化并返回。
puts "Test".concat("String") # 连接字符串
puts "TestString".crypt("dd") # 对 str 应用单向加密哈希。参数是两个字符长的字符串，每个字符的范围为 a.z、 A.Z、 0.9、 . 或 /。 (ddk4.hvhrGZOM)
puts "TestString".crypt("mk") # mmE6KD6TxOoI.
puts "TestString".downcase # 返回 str 的副本，所有的大写字母会被替换为小写字母。

