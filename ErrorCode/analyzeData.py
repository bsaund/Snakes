import scipy.io
import pdb
import numpy as np
from sklearn.svm import SVR
import matplotlib.pyplot as plt
from sklearn import cross_validation


mat = scipy.io.loadmat('../+ErrorEstimation/errorScaling.mat')
posError = mat['posError']
jacobians = mat['Jacobians']
inputAngles = mat['inputAngles']

J = jacobians[:,1,:]

x_train, x_test, y_train, y_test = cross_validation.train_test_split(inputAngles, posError, test_size=0.3, random_state=0)

# y1 = posError[:,1]
# y2 = posError[:,2]

# x = inputAngles

y1 = y_train[:,1]
y2 = y_train[:,2]

yt1 = y_test[:,1]
yt2 = y_test[:,2]


x = x_train
xt = x_test


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
svr_rbf = SVR(kernel='rbf', C=1e3, gamma=0.1)
svr_lin = SVR(kernel='linear', C=1e3)
svr_poly = SVR(kernel='poly', C=1e3, degree=2)
# svr_anova = SVR(kernel='anova', 
# y_rbf = svr_rbf.fit(X, y).predict(X)
# y_lin = svr_lin.fit(X, y).predict(X)
# y_poly = svr_poly.fit(X, y).predict(X)

pdb.set_trace()
# f_lin_org = svr_lin.fit(X_org, y_org)



f1_rbf = svr_rbf.fit(x, y1)
f2_rbf = svr_rbf.fit(x, y2)
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
plt.scatter(y1-f1_rbf.predict(x), y2-f2_rbf.predict(x), c='b', label='Corrected Postition Error')

plt.show()

plt.scatter(yt1, yt2, c='r')
plt.scatter(yt1 - f1_rbf.predict(xt), yt2 - f2_rbf.predict(xt), c='b')

plt.show()


