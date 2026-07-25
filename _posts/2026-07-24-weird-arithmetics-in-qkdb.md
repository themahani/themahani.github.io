---
title: Weird order of arithmetics in q/kdb+
<<<<<<< Updated upstream
tags: rant, fun, programming, q/kdb+
categories: ['short posts']
=======
tags: rant fun programming q/kdb+
categories: ["short posts"]
>>>>>>> Stashed changes
---

So I started learning q/kdb+ recently. kdb-x is a database suite optimized for time series data. And I say "suite" because it provides more than just a
database and a query language. It also provides libraries that help you design live dashboards, develop entire models, and much more.

Cutting to the chase, here's the interesting part. When doing arithmetics in most programming languages such as python, C/C++ etc., you have a certain order of operations.
For instance, when calculating `3 + 4 * 5 - 4`, the priority of operation is given to `*`, then `+/-` from left to right.
So calculating this step-by-step, leads to:

1. `3 + 20 - 4`
2. `23 - 4`
3. `19`

But apparently, q/kdb+ works differently. There are no priorities in the arithmetic operations and the order of ops is from right-to-left! Meaning the previous arithmetic boils down
to:

1. `3 + 4 * 1`
2. `3 + 4`
3. `7`

This felt sort of weird for me, until I started adding the parentheses to explicitly define the order of ops without changing the output like so:
`3 + (4 * (5 - 4))`. This will equal `7` in both types of programming languages. Then I realized that this is just like BSL from _Dr. Racket_.
In BSL, every arithmetic op is a function that is defined in BSL syntax and called accordingly. So a summation looks like this:

```bsl
(+ num1 num2 num3 ...)
```

and a division is as follows:

```bsl
(/ numerator denominator)
```

Now if I write the same arithmetic in BSL, I would get

```bsl
(+ 3 (* 4 (- 5 4)))
```

Which results in `7`. You see the resemblance? I think this is cool. Now whenever I want to troubleshoot any q/kdb+ arithmetic in my head,
I just start adding parentheses from right to left and calculate as I progress to the
left side of the equation.
