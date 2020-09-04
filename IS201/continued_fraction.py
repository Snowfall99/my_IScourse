a = 20200609
b = 547

P0 = 0
P1 = 1
Q0 = 1
Q1 = 0

a0 = int(a/b)
x0 = a - a0 * b
P2 = a0 * P1 + P0
Q2 = a0 * Q1 + Q0
print(str(a0)+" ("+str(P2)+","+str(Q2)+")")

Q0 = Q1
Q1 = Q2
P0 = P1
P1 = P2

while x0 != 0:
    tmp = b
    a0 = int(b/(x0))
    b = x0
    x0 = tmp - a0 * x0
    P2 = a0 * P1 + P0
    Q2 = a0 * Q1 + Q0
    print(str(a0) + " (" + str(P2) + "," + str(Q2) + ")")
    Q0 = Q1
    Q1 = Q2
    P0 = P1
    P1 = P2


