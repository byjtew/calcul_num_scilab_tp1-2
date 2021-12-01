function [C] = matmat3b(A,B)
[nr_a, nc_a] = size(A)
[nr_b, nc_b] = size(B)

for i = 1:nr_a
    for j = 1:nc_b
        C(i,j)= 0.0
        for k = 1:nr_b
           C(i,j) = C(i,j) + A(i,k) * B(k,j)
        end
    end
end
endfunction

function [C] = matmat2b(A,B)
[nr_a, nc_a] = size(A)
[nr_b, nc_b] = size(B)

for i = 1:nr_a
    for j = 1:nc_b
        C(i,j) = A(i,1:nr_b) * B(1:nr_b,j)
    end
end
endfunction

function [C] = matmat1b(A,B)
[nr_a, nc_a] = size(A)
[nr_b, nc_b] = size(B)

for i = 1:nr_a
    C(i, 1:nc_b) = A(i,1:nr_b) * B(1:nr_b,1:nc_b)
end
endfunction


function [C] = matmat0b(A,B)
[nr_a, nc_a] = size(A)
[nr_b, nc_b] = size(B)
C = A*B
endfunction
