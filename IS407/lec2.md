# lec2-1: 现代密码学历史-代换

## 古典密码学
- 替换和置换
### 恺撒密码
- 替换方法：每个字母用其后的第三个字母替换
### 混合单表替换密码
- 不仅仅是移位变换
- 每个字母可以用其它任何一个字母替换（不能重复）
- 每个字母可以随机映射到其它一个
### 简单的单表替换密码
- 需要一种简单方法指定密钥字
- 写没有重复字母的“密钥字”，其他字母按顺序写在密钥字最后字母后面
### Vigenere Cipher
- 使用多个单字母替换表
- 用一个密钥选择对每个字母使用哪个字母表

## Scytale 密码
## 轨道栅栏密码
- 以不同的行写下消息字母
- 按行读取消息
## 几何图形密码
- 以一种形式写下消息，以另一种形式读取消息
## 行变换密码
- 按行写出字母
- 以密钥给出的顺序读取消息