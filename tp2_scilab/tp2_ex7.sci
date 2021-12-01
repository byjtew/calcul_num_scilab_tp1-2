// 1
A = rand(3, 3)
disp("A:")
disp(A)

// 2 
xex = rand(3, 1)
disp("Exact x:")
disp(xex)

// 3
b = A * xex
disp("b:")
disp(b)

// 4
x_sys = A\b
disp("Computed x:")
disp(x_sys)

// 5
disp("Erreur avant:", (norm(xex - x_sys))/norm(xex))
r = b - A * x_sys
disp("Residuel:", r)
disp("Erreur arriere:", norm(r)/(norm(A) * norm(x_sys)))

// 6
disp("Question 6")
repeatitions = 100
iter = 15
errs_avant = 0
errs_arr = 0
conditionnement_cumul = 0

fd_av = mopen("ex7_errors_avant.dat", "wt")
fd_arr = mopen("ex7_errors_arr.dat", "wt")

for index = 1:iter
    s = 1+index
    A = rand(s, s)
    xex = rand(s, 1)
    b = A * xex
    errs_avant = 0
    errs_arr = 0
    for r = 1:repeatitions
        x_sys = A\b
        errs_avant = errs_avant + (norm(xex - x_sys))/norm(xex)
        errs_arr = errs_arr + norm(b - A * x_sys)/(norm(A) * norm(x_sys))
    end
    
    conditionnement_cumul = conditionnement_cumul + cond(A)
    mfprintf(fd_av, "%d %.20lf\n", int(s), errs_avant/repeatitions)
    mfprintf(fd_arr, "%d %.20lf\n", int(s), errs_arr/repeatitions)
end
mclose(fd_av)
mclose(fd_arr)
printf("Conditionnement : %lf\n", conditionnement_cumul/iter)
