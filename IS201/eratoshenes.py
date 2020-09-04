import numpy as np


def eratoshenes(N):
    array = []
    p = int(np.sqrt(N))
    result = []
    for i in range(2,N):
        result.append(i)

    for i in range(2,p+1):
        flag = True
        for j in range(2, i):
            if i % j == 0:
                flag = False
        if flag:
            array.append(i)

    for arr in array:
        n = 2
        tmp = n*arr
        while tmp <= N:
            if tmp in result:
                result.remove(tmp)
            n += 1
            tmp = n*arr

    print(result)


if __name__ == "__main__":
    eratoshenes(10000)