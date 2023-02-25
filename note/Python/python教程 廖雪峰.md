### 使用 __slots__

可以给实例绑定任何属性和方法，这就是动态语言的灵活性

``` python
s = Student()
s.name = 'Michael' # 动态给实例绑定一个属性

from types import MethodType
def set_age(self, age):
  self.age = age
s.set_age = MethodType(set_age, s) # 给实例绑定一个方法

# 给实例绑定的方法，对另一个实例不起作用
# 如果要对所有实例有效，可以给class绑定方法
Student.set_age = set_age
```

``` python
# 限制实例的属性使用 __slots__
class Student(object):
  __slots__ = ('name', 'age')  # 用tuple定义允许绑定的属性名称
```



### 使用@property

@property 负责把一个方法变成属性调用

只读属性：只定义getter方法，不定义setter方法

``` python
class Student(object):
  @property
  def score(self):
    return self._score
  
  @score.setter
  def score(self, value):
    self._score = value
```



### 多重继承

MixIn

### 定制类

``` python
# print 打印实例时 输出
__str__()
```

