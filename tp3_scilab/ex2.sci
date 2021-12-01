function [x] = usolve(U,b)
[n,n_check] = size(U)
x = zeros(n,1)
if n == n_check then
    x(n) = b(n)/U(n,n);
    for i = (n-1):-1:1
        x(i) = (b(i) -  U(i,(i+1):n) *  x((i+1):n)) / U(i,i);
    end
end
endfunction

function [x] = lsolve(L,b)
[n,n_check] = size(L)
x = zeros(n,1)
if n == n_check then
    x(1) = b(1)/L(1,1);
    for i = 2:n
        x(i) = (b(i) -  L(i,1:i-1) *  x(1:i-1)) / L(i,i);
    end
end
endfunction

function [A, b] = gausskij3b(A,b)
[n,n_check] = size(A)

if n == n_check then
    for k = 1:(n-1)
        for i = (k+1):n
            m = A(i,k) / A(k,k)
            b(i) = b(i) - m * b(k)
            for j = (k+1):n
                A(i,j) = A(i,j) - m * A(k,j)
            end
        end
    end
end
endfunction

function [L, U] = mylu3b(A)
    [n,n_check] = size(A)
    L = zeros(n,n)
    U = zeros(n,n)

    if n == n_check then
        for k = 1:(n-1)
            for i = (k+1):n
                A(i,k) = A(i,k)/A(k,k)
            end
            for i = (k+1):n
                for j = (k+1):n
                    A(i,j) = A(i,j) - A(i,k) * A(k,j)
                end
            end
        end
    L = tril(A)
    for i = 1:n
        L(i,i) = 1
    end
    U = triu(A)
    end
endfunction

function [L, U] = mylu1b(A)
    [n,n_check] = size(A)
    L = zeros(n,n)
    U = zeros(n,n)

    if n == n_check then
        for k = 1:(n-1)
            A((k+1):n,k) = A((k+1):n,k)/A(k,k)
            A((k+1):n,(k+1):n) = A((k+1):n,(k+1):n) - A((k+1):n,k) * A(k,(k+1):n)
        end
    L = tril(A)
    for i = 1:n
        L(i,i) = 1
    end
    U = triu(A)
    end
endfunction

function [L, U, P] = mylu(A)
    [m, n] = size(A)
    L = eye(n,n)
    P = eye(n,n)
    U = A
    for j = 1:n
        [pivot m] = max(abs(U(j:n, j)))
        m = m+j-1
        if m ~= j then
            U([m,j],:) =  U([j,m], :)
            P([m,j],:) =  P([j,m], :)
            if j >= 2 then
                L([m,j],1:j-1) =  L([j,m], 1:j-1)
            end
        end
        for i = j+1:n      
            L(i, j) = U(i, j) / U(j, j)
            U(i, :) =  U(i, :) - L(i, j)*U(j, :)
        end
    end
endfunction

function [err_avant, err_arriere] = erreurs(x_correct, x_computed)
    err_avant = (norm(x_correct) - norm(x_computed))/norm(x_correct)

    err_arriere = 0
endfunction


/*

// Exercice 2

for s = 3:+1:10
    A = rand(s,s)
    b = rand(s,1)
    
    A_up = triu(A)
    x_correct = A_up\b
    x_result = usolve(A_up, b)
    A_low = tril(A)
    x_correct = A_low\b
    x_result = lsolve(A_low, b)
end
*/







/*
// Exercice 3

// Constants
repeatitions = 100
min_size = 2
max_size = 15
// ---------

// Allocation for scilab
A = zeros(max_size, max_size)
B = zeros(max_size, max_size)
fd = mopen('ex3_times.dat', 'wt')
fd_error = mopen('ex3_errors.dat', 'wt')
// ---------------------

for s = min_size:max_size
    gauss_times = zeros(repeatitions, 1)
    scilab_times = zeros(repeatitions, 1)
    errors_gauss = 0
    for r = 1:repeatitions
        A = rand(s,s)
        b = rand(s,1)
    
        tic()
        x_correct = A\b
        scilab_times(r) = toc()
    
        tic()
        [A_gauss, b_gauss] = gausskij3b(A,b)
        x_result = usolve(A_gauss, b_gauss)
        gauss_times(r) = toc()

        errors_gauss = errors_gauss + erreurs(x_correct, x_result)(1)
        
    end
    printf("[size: %d] mean time for scilab is %lf\nmean time for gauss+solve is %lf\n", s, mean(scilab_times), mean(gauss_times))
    mfprintf(fd, "%d %lf %lf\n", s, mean(scilab_times), mean(gauss_times))  
    mfprintf(fd_error, "%d %.20lf\n", s, abs(errors_gauss/repeatitions))
    printf("[size: %d] mean error is %.20lf\n", s, errors_gauss/repeatitions)
end

mclose(fd)
mclose(fd_error)
*/






/*

// Exercice 4

// Constants
repeatitions = 100  
min_size = 2
max_size = 8
// ---------

// Allocation for scilab
fd = mopen('ex4_times.dat', 'wt')
fd_error = mopen('ex4_errors.dat', 'wt')
fd_mylu_error = mopen('ex4_mylu_errors.dat', 'wt')
// ---------------------


for s = min_size:max_size
    mylu3b_times = zeros(repeatitions, 1)
    scilab_times = zeros(repeatitions, 1)
    mylu3b_errors = zeros(repeatitions, 1)
    scilab_errors = zeros(repeatitions, 1)
    my_lu_errors = 0
    for r = 1:repeatitions
        A = rand(s,s)
    
        tic()
        [L, U] = lu(A)
        scilab_times(r) = toc()
        scilab_errors(r) = erreurs(A, L*U)(1) //(sum(A - L*U))/(s*s)
    
        tic()
        [my3_L, my3_U] = mylu3b(A)
        mylu3b_times(r) = toc()
        mylu3b_errors(r) = erreurs(A, my3_L*my3_U)(1) //(sum(A- my3_L*my3_U))/(s*s)

        [my_L, my_U, my_P] = mylu(A) // my_L*my_U == my_P * A
        my_lu_errors = my_lu_errors + abs(erreurs(my_P * L * U, my_L*my_U)(1))
    end
    printf("[size: %d] mean time for scilab is %lf\nmean time for mylu3b is %lf\n", s, mean(scilab_times), mean(mylu3b_times))
    mfprintf(fd, "%d %lf %lf\n", s, mean(scilab_times), mean(mylu3b_times))
    mfprintf(fd_error, "%d %.20lf %.20lf\n", s, abs(mean(scilab_errors)), abs(mean(mylu3b_errors)))
    mfprintf(fd_mylu_error, "%d %.20lf\n", s, my_lu_errors/repeatitions)
end
mclose(fd)
mclose(fd_error)
mclose(fd_mylu_error)

*/








