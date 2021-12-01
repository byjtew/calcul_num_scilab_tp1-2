exec "tp2_matmatNb"

n_repeat = 10


fd_curves = mopen('curves.dat','wt');

for s = 5:+5:100
    A = rand(s,s)
    B = rand(s,s)

    mfprintf(fd_curves, "%d, ", s)

    for repeat = 1:n_repeat
        tic()
        res3b = matmat3b(A,B)
        matmat3b_exec_time(repeat) = toc()
        //disp("matmat3b(A,B) result:")
        //disp(res3b)
        //printf("\nmatmat3b_exec_time: %lf\n\n", matmat3b_exec_time)
    end
    printf("mean of matmat3b_exec_time for size [%d,%d]: %lf\n", s, s, mean(matmat3b_exec_time))

    mfprintf(fd_curves, "%lf, ", mean(matmat3b_exec_time))

    for repeat = 1:n_repeat
        tic()
        res2b = matmat2b(A,B)
        matmat2b_exec_time(repeat) = toc()
        //disp("matmat2b(A,B) result:")
        //disp(res2b)
        //printf("\nmatmat2b_exec_time: %lf\n\n", matmat2b_exec_time)
    end
    printf("mean of matmat2b_exec_time for size [%d,%d]: %lf\n", s, s, mean(matmat2b_exec_time))

    mfprintf(fd_curves, "%lf, ", mean(matmat2b_exec_time))

    for repeat = 1:n_repeat
        tic()
        res1b = matmat1b(A,B)
        matmat1b_exec_time(repeat) = toc()
        //disp("matmat1b(A,B) result:")
        //printf(res1b)
        //printf("\nmatmat1b_exec_time: %lf\n\n", matmat1b_exec_time)
    end
    printf("mean of matmat1b_exec_time for size [%d,%d]: %lf\n", s, s, mean(matmat1b_exec_time))

    for repeat = 1:n_repeat
        tic()
        res0b = matmat0b(A,B)
        matmat0b_exec_time(repeat) = toc()
        //disp("(A,B) result:")
        //disp(res0b)
        //printf("\nmatmat0b_exec_time: %lf\n\n", matmat0b_exec_time
    end
    printf("mean of matmat0b_exec_time for size [%d,%d]: %lf\n", s, s, mean(matmat0b_exec_time))

    mfprintf(fd_curves, "%lf \n", mean(matmat0b_exec_time))

end


mclose(fd_curves)
