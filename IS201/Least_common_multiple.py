a = int(input("a="))
b = int(input("b="))

if(a>b):
    r1 = a
    r2 = b
else:
    r1 = b
    r2 = a

while(r2!=0):
    temp = r2
    r2 = r1 % r2
    r1 = temp

result = a * b / r1

print(result)
