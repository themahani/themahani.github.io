---
title: Matrix multiplication in q lang
tags: q/kdb+ programming 
categories: ['short posts']
math: true
---

Following my [previous post]({% link _posts/2026-07-24-weird-arithmetics-in-qkdb.md %}), 
I've started reading the book "Q for Mortals". It's a fascinating book and I highly recommend it 
to anyone who is interested in learning this language properly. After getting through chapter 1 and realizing how well q-lang handles lists and vectors (considering it's a vector-language),
I started thinking what I need to do to write the matrix multiplication operator in q-lang. But I don't want to just write it. I mean writing it in a for loop is easy and all, but I want
to write it as compact as I can. I tried my best to condense the entire code into a one-liner, but failed. It turned into 2 lines :smiling_face_with_tear:. Anyways, here it goes.

Consider the $m \times n$ matrix $$A$$ and the $$n \times p$$ matrix $$B$$.
Let's create some simple examples for $$A$$ and $$B$$.

```q
a:(1 2 3; 2 3 4)
b:(3 5; 4 6; 5 7)
```

Here `a` is $$2 \times 3$$ while `b` is $$3 \times 2$$. Let's see what happens if 
I multiply one row of `a` by `b`
```q
a[0]*b
// shows:
// 3  5 
// 8  12
// 15 21
```
which is multiplying the first row of `a` by each column in `b`. Now if we `sum` this, we get
```q
sum a[0]:b
// shows:
// 26 38
```
which is the first row of the result of the matrix multiplication $$A \times B$$. See where this is going?
Now we just need to repeat this for each row in `a`. We can use "each-left" to achieve this, but we 
need to define this row-times-matrix operation first.
```q
row_mult:{[row;matrix] sum row*matrix}
```

Now we can use each-left as
```q
a row_mult\: b
// shows:
// 26 38
// 38 56
```
which is the full result of the matrix multiplication. Yay!
