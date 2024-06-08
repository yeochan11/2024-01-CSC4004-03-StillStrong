import numpy as np

def softmax(X):
    exp_a = np.exp(X)
    print(exp_a)
    sum_exp_a = np.sum(exp_a)
    y = exp_a / sum_exp_a
    
    return y

print(softmax(np.array([-0.5, 1.2, -0.1, 2.4])))