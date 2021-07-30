def factorial_iterative(n):
    answer = 1
    for i in range(1, n+1):
        answer = answer * i
    return answer

factorial_iterative(5)