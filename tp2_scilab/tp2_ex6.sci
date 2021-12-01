// 1
x = [1 2 3 4]
disp(x)

// 2
y = [5; 6; 7; 8]
disp(y)


// 3
z = x+y'
disp(z)
s = x*y
disp(s)

// 4
disp(size(x))
disp(size(y))

// 5
disp(norm(x))

// 6 
A =rand(4, 3)
disp(A)

// 7
transA = A'
disp(transA)

// 8

B = rand(3, 4)
prodAB = A * B
disp(prodAB)

C = rand(4, 3)
sumAC = A + C
disp(sumAC)

// 9
disp(cond(A))
