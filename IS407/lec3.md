# lec3: 分组密码

## 理论基础
- 理想的方法是用尽可能大的替换模块
- 理想情况并不实际
- 使用一些小的模块替换
- 使用乘积密码的思想

## 替换-置换密码
- 替换-置换网络思想（S-P networks）
### 替换运算
- 一个二进制字用其它二进制字替换
- 这种替换函数构成密钥
- 可以看作是一个大的查找运算表
- S-boxes
- 作用：混淆，使作用于明文的密钥和密文之间的关系复杂化
### 置换运算
- 二进制字次序被打乱
- P-boxes
- 作用：扩散，将明文及密钥的影响尽可能迅速地散布到较多个输出的密文中（将明文冗余度分散到密文中）

## Feistel密码
- 思想：把输入块分成左右两部分L(i-1)和R(i-1)，变换是在密码的第一轮只使用R(i-1)；参与第i轮运算的为第i个子密钥（由原始密钥通过密钥编排算法得出）
- L(i) = R(i-1)
- R(i) = L(i-1) XOR g(K(i) * R(i-1))

### 雪崩效应
- 输入改变1 bit，导致近一半的bit发生改变
### 完备性效应
- 每个输出比特是所有输入比特的复杂函数的输出