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

mat = scipy.io.loadmat('../+ErrorEstimation/errorThetaOffsets.mat')
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

x1 = createInputs(inputAngles, jacobians[:,0,:].transpose())
y1 = posError[:,0]

x2 = createInputs(inputAngles, jacobians[:,1,:].transpose())
y2 = posError[:,1]



def computeLinearKernel(x):
    n = x.shape[0]
    k = np.zeros(shape=(n,n))
    for i in range(0, x.shape[0]):
        for j in range(0, x.shape[0]):
            k[i,j] = np.dot(x[i,:], x[j,:])
    return k

def computeTestKernel(x):
    n = x.shape[0]
    k = np.zeros(shape=(n,n))
    for i in range(0, x.shape[0]):
        for j in range(0, x.shape[0]):
            k[i,j] = np.dot(x[i,:], x[j,:])  + np.dot(x[i,0:8]* x[j,8:16], x[i,8:16] * x[j,0:8])
    return k






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

k1 = computeLinearKernel(x1)
k2 = computeLinearKernel(x2)

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
plt.title('Simple Error, Linear Kernel')
plt.xlabel('Error in robot X')
plt.ylabel('Error in robot Y')
plt.legend()

fig = plt.gcf()
c = plt.Circle((np.mean(y1-f1),np.mean(y2-f2)),.015, color='b', fill=False)
c2 = plt.Circle((np.mean(y1), np.mean(y2)), .2, color='r', fill=False)
fig.gca().add_artist(c)
fig.gca().add_artist(c2)
plt.axis('equal')

plt.show()
pdb.set_trace()


