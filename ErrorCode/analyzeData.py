import scipy.io
import pdb
import numpy as np
from sklearn.svm import SVR
import matplotlib.pyplot as plt
from sklearn import cross_validation
from sklearn.kernel_ridge import KernelRidge



def getRelevantInputs(x_train, x_test, y_train, y_test, outputNum):
    x_train = x_train[:,outputNum::6]
    x_test = x_test[:,outputNum::6]
    y_train = y_train[:,outputNum]
    y_test = y_test[:,outputNum]
    return x_train, x_test, y_train, y_test

mat = scipy.io.loadmat('../+ErrorEstimation/errorScaling.mat')
posError = mat['posError']
jacobians = mat['Jacobians']
inputAngles = mat['inputAngles']

J = jacobians[:,0,:].transpose()
x1tmp = np.append(inputAngles, J, axis=1);
x1tmp = np.append(x1tmp, J * inputAngles, axis=1);

# J = np.reshape(jacobians, (jacobians.shape[0] * jacobians.shape[1], jacobians.shape[2])).transpose()

# repeatedAngles = np.tile(inputAngles, (1, 6))



inputs = np.append(inputAngles, J, axis=1);
inputs = np.append(inputs, J * inputAngles, axis=1);
# inputs = np.append(J, J*repeatedAngles, axis=1)
# inputs = np.append(inputs, inputAngles, axis=1)
# inputs = J

def createInputs(inputAngles, J):
    inputs = np.append(inputAngles, J, axis=1);
    # inputs = np.append(inputs, J * inputAngles, axis=1);
    return inputs

# x_train, x_test, y_train, y_test = cross_validation.train_test_split(inputs, posError, test_size=0.3, random_state=0)
# x_train, x_test, y_train, y_test = cross_validation.train_test_split(inputs, posError[:,0], test_size=0.3, random_state=0)




x1 = createInputs(inputAngles, jacobians[:,0,:].transpose())
y1 = posError[:,0]

x2 = createInputs(inputAngles, jacobians[:,1,:].transpose())
y2 = posError[:,1]

# x1 = inputs

# y1 = posError[:,0]
# my1 = np.abs(np.mean(y1))
# y1 = y1/my1

# x_train = inputs

# y2 = y_train[:,1]

# # y1 = posError[:,0]
# # y2 = posError[:,1]


# yt1 = y_test[:,0]
# yt2 = y_test[:,1]


# x = x_train
# x = inputs

# x1, xt1, y1, yt1 = getRelevantInputs(x_train, x_test, y_train, y_test, 0)
# x1 = inputs
# xt1 = x_test
# y1 = posError[:,0]
# yt1 = y_test
# x2, xt2, y2, yt2 = getRelevantInputs(x_train, x_test, y_train, y_test, 1)

# xt = x_test

# pdb.set_trace()

def computeKernel(x):
    n = x.shape[0]
    k = np.zeros(shape=(n,n))
    for i in range(0, x.shape[0]):
        for j in range(0, x.shape[0]):
            k[i,j] = np.dot(x[i,:], x[j,:])
    return k




###############################################################################
# Generate sample data
# X_org = np.sort(5 * np.random.rand(100, 8), axis=0)
X_org = 5 * np.random.rand(100, 8) - 10
y_org = np.sin(X_org[:,1]).ravel()

###############################################################################
# Add noise to targets
# y_org[::5] += 3 * (0.5 - np.random.rand(8))

###############################################################################
# Fit regression model
# svr_rbf = SVR(kernel='rbf', C=1e3, gamma=1)
svr_lin = SVR(kernel='linear', epsilon=0.005, C=4)
# svr = SVR(kernel='precomputed', epsilon=.001/my1, C=16)


svr_poly = SVR(kernel='poly', C=1e3, degree=2)
# svr_anova = SVR(kernel='anova', 
# y_rbf = svr_rbf.fit(X, y).predict(X)
# y_lin = svr_lin.fit(X, y).predict(X)
# y_poly = svr_poly.fit(X, y).predict(X)

krr_lin = KernelRidge(kernel='linear', alpha=.001)
krr = KernelRidge(kernel='precomputed', alpha=.001)


# f_lin_org = svr_lin.fit(X_org, y_org)


# f1 = svr.fit(k, y1).predict(k)
# f2 = svr.fit(k, y2).predict(k)
# f1 = svr_lin.fit(x1, y1).predict(x1)
# f2 = svr_lin.fit(x2, y2).predict(x2)
# f1 = krr_lin.fit(x1, y1).predict(x1)
# f2 = krr_lin.fit(x2, y2).predict(x2)
pdb.set_trace()

k1 = computeKernel(x1)
k2 = computeKernel(x2)

# f1 = krr_lin.fit(x_train, y1).predict(x_train)
# f1 = krr_lin.fit(x1, y1).predict(x1)
# f2 = krr_lin.fit(x2, y2).predict(x2)

f1 = krr.fit(k1, y1).predict(k1)
f2 = krr.fit(k2,y2).predict(k2)

# f1_k = svr.fit(k, y1).predict(k)
# f1 = svr_lin.fit(x_train, y1).predict(x_train)

# f1_test = svr_lin.fit(x1, y1).predict(xt1)
# f2_test = svr_lin.fit(x2, y2).predict(xt2)
# f_lin = svr_lin.fit(x, y).predict(x)




###############################################################################
# look at the results
# plt.scatter(X, y, c='k', label='data')
# plt.hold('on')
# plt.plot(X, y_rbf, c='g', label='RBF model')
# plt.plot(X, y_lin, c='r', label='Linear model')
# plt.plot(X, y_poly, c='b', label='Polynomial model')
# plt.xlabel('data')
# plt.ylabel('target')
# plt.title('Support Vector Regression')
# plt.legend()
# plt.scatter(x[:,1], y, c='k')
# plt.scatter(x[:,1], f_rbf, c='g')
# plt.scatter(x[:,1], f_lin, c='y')

plt.scatter(y1, y2, c='r', label='Raw Position Error')
plt.scatter(y1-f1, y2 - f2, c='b', label='Corrected Postition Error')

# plt.show()

# plt.scatter(yt1, yt2, c='r', label='End Effector Position Error')
# plt.scatter(yt1 - f1_test, yt2 - f2_test, c='b', label='Compensated End Effector Position Error')
plt.title('Cross Validated Positional Error in Simulation')
plt.xlabel('Error in robot X')
plt.ylabel('Error in robot Y')
plt.legend()

fig = plt.gcf()
c = plt.Circle((0,0),.015, color='b', fill=False)
c2 = plt.Circle((-.015,.014), .2, color='r', fill=False)
fig.gca().add_artist(c)
fig.gca().add_artist(c2)
plt.axis('equal')

plt.show()
pdb.set_trace()


