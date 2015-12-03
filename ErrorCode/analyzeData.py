import scipy.io
import pdb
import numpy as np
from sklearn.svm import SVR
import matplotlib.pyplot as plt
from sklearn import cross_validation
from sklearn.kernel_ridge import KernelRidge


mat = scipy.io.loadmat('../+ErrorEstimation/errorThetaOffsets.mat')
posError = mat['posError']
jacobians = mat['Jacobians']
inputAngles = mat['inputAngles']

J = jacobians[:,0,:].transpose()
J = np.reshape(jacobians, (48, 100)).transpose()



# inputs = np.append(inputAngles, J, axis=1);
# inputs = np.append(inputs, J * inputAngles, axis=1);
inputs = J


x_train, x_test, y_train, y_test = cross_validation.train_test_split(inputs, posError, test_size=0.3, random_state=0)

# y1 = posError[:,1]
# y2 = posError[:,2]

# x = inputAngles

y1 = y_train[:,0]
y2 = y_train[:,1]

# y1 = posError[:,0]
# y2 = posError[:,1]


yt1 = y_test[:,0]
yt2 = y_test[:,1]


x = x_train
# x = inputs

xt = x_test

pdb.set_trace()

n = x.shape[0]
k = np.zeros(shape=(n,n))
for i in range(0, x.shape[0]):
    for j in range(0, x.shape[0]):
        k[i,j] = np.dot(x[i,:], x[j,:])





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
svr_lin = SVR(kernel='linear', epsilon=0.001, C=4)
svr = SVR(kernel='precomputed', epsilon=.001, C=4)


svr_poly = SVR(kernel='poly', C=1e3, degree=2)
# svr_anova = SVR(kernel='anova', 
# y_rbf = svr_rbf.fit(X, y).predict(X)
# y_lin = svr_lin.fit(X, y).predict(X)
# y_poly = svr_poly.fit(X, y).predict(X)

krr_lin = KernelRidge(kernel='linear', alpha=.001)


# f_lin_org = svr_lin.fit(X_org, y_org)


# f1 = svr.fit(k, y1).predict(k)
# f2 = svr.fit(k, y2).predict(k)
f1 = svr_lin.fit(x, y1).predict(x)
f2 = svr_lin.fit(x, y2).predict(x)
# f1 = krr_lin.fit(x, y1).predict(x)
# f2 = krr_lin.fit(x, y2).predict(x)


# f1_rbf_test = svr_rbf.fit(x, y1).predict(xt)
# f2_rbf_test = svr_rbf.fit(x, y2).predict(xt)
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

plt.show()

# plt.scatter(yt1, yt2, c='r')
# plt.scatter(yt1 - f1_rbf_test, yt2 - f2_rbf_test, c='b')

# plt.show()

pdb.set_trace()
