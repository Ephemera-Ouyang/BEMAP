# -*- coding: utf-8 -*-

from sklearn.cluster import KMeans
from sklearn.cluster import AgglomerativeClustering
from scipy.cluster.hierarchy import dendrogram, linkage, fcluster
#from sklearn.SVM import SVC
from sklearn.preprocessing import Normalizer
from sklearn import preprocessing
import math
import numpy as np
import pandas as pd
from mlxtend.preprocessing import TransactionEncoder
from sklearn.feature_extraction.text import CountVectorizer, TfidfTransformer
from sklearn.metrics import silhouette_score
from matplotlib import font_manager
import matplotlib
import matplotlib.pyplot as plt
import os
curLoc = os.getcwd()


data_initial = pd.read_csv(curLoc + "/NewSamples/NoteAfterPCAandICA/usingPCA_60.csv")

d=data_initial.values.tolist()

a = np.array(d)
X = a[:,1:]
app = a[:,0]
K_value = 9

X = Normalizer(norm="l2").fit_transform(X)
#scaler = preprocessing.StandardScaler().fit(X)
#scaler.transform(X)
sse = 0
#svm=SVC(n_clusters=K_value,random_state=9).fit(X)
kmeans = KMeans(n_clusters=K_value,n_init=1000,max_iter=300,tol=0.0001,random_state=3).fit(X)
s = pd.DataFrame(app, kmeans.labels_)
s = pd.DataFrame({"labels":kmeans.labels_,"app":app}).sort_values("labels")
s

#绘制SSE曲线
SSE = []
for i in range(1,60):
    km = KMeans(n_clusters=i,random_state=3).fit(X)
    #获取K-means算法的SSE
    SSE.append(km.inertia_)
    
    #绘制曲线
plt.plot(range(1,60),SSE,marker="o")
plt.xlabel("K",size=20)
plt.ylabel("SSE",size=20)
plt.show()

import pandas as pd
from sklearn.cluster import KMeans
from sklearn.metrics import silhouette_score
import matplotlib.pyplot as plt

#绘制SSE曲线
Scores = []
for i in range(2,60):
    km = KMeans(n_clusters=i,random_state=3).fit(X)
    #获取K-means算法的SSE
    Scores.append(silhouette_score(X,km.labels_,metric='euclidean'))
    
    #绘制曲线
plt.plot(range(2,60),Scores,marker="o")
plt.xlabel("K",size=20)
plt.ylabel("silhouette_score",size=20)
plt.show()