def compose1(f, g):
    '''
    This function generates a function h(x),
    h(x)=f(g(x))
    '''
    return lambda x: f(g(x))

def cycle(f1, f2, f3):
    '''
    This function generates a function f(n),
    n = 0 : x
    n = 1 : f1(x)
    n = 2 : f2(f1(x))
    n = 3 : f3(f2(f1(x)))
    n = 4 : f1(f3(f2(f1(x))))
    '''
    def cycle_with_count(n):
        f = lambda y: y
        count = 0
        while n>=1:
            count += 1
            n -= 1
            if count % 3 == 1 :
                f = compose1(f1,f)
                '''errors happen when change to
                f = lambda x: f1(f(x))
                '''
            if count % 3 == 2 :
                f = compose1(f2,f)
            if count % 3 == 0 :
                f = compose1(f3,f)
        return f
    return cycle_with_count

def add_1(x):
    return x + 1

def mul_2(x):
    return x * 2

def square(x):
    return x * x

f_cycle_with_count = cycle(add_1,mul_2,square)

g = f_cycle_with_count(2)

'''test case:
>>> g(4)
10

>>> h = f_cycle_with_count(3)
>>> h(4)
100
'''