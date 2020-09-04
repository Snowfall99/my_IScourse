import math
import random


def relatively_prime(a, b):  # a > b
    while b != 0:
        temp = b
        b = a % b
        a = temp
    if a == 1:
        return True
    else:
        return False


def Fermat(num):
    flag = True
    TestList = []
    for i in range(30):
        # 产生一个整数b,满足(b,num)=1
        b = random.randint(2, num-2)
        while relatively_prime(num, b)  == False or b in TestList:
            b = random.randint(1, num)
        TestList.append(b)

        #检验r=b^(n-1)是否为1
        if pow(b, num-1) % num != 1:
            flag = False

    return flag

def test_prime(num):


    # 质数大于 1
    if num > 1:
        # 查看因子
        for i in range(2, num):
            if (num % i) == 0:
                print(num, "不是质数")
                print(i, "乘于", num // i, "是", num)
                break
        else:
            print(num, "是质数")

    # 如果输入的数字小于或等于 1，不是质数
    else:
        print(num, "不是质数")


num = pow(2, 12)
while Fermat(num) != True:
    num += 1

print("prime number is: " + str(num))

test_prime(num)