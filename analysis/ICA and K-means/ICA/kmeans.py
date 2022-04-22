# -*- coding: utf-8 -*-

def kmeansForCluster(dimensions, dimensionToKP, dimensionToKI):
    import os

    import numpy as np
    import pandas as pd
    from openpyxl import load_workbook
    from sklearn.cluster import KMeans
    from sklearn.preprocessing import Normalizer

    curLoc = os.getcwd()

    compressionCodecs = ['PCA','ICA']
    dimensions = dimensions
    dimensionToKPCA = dimensionToKP
    dimensionToKICA = dimensionToKI

    for compressionCodec in compressionCodecs:
        writer = pd.ExcelWriter(curLoc + '/Kmeans/using' + str(compressionCodec) + '_Kmeans.xlsx')
        for dimension in dimensions:
            data_initial = pd.read_csv(curLoc + '/NewSamples/NoteAfterPCAandICA/using' + str(compressionCodec) + '_' + str(dimension) + '.csv')
            d=data_initial.values.tolist()

            a = np.array(d)
            X = a[:,1:]
            app = a[:,0]
            if compressionCodec.__eq__('PCA'):
                K_value = dimensionToKPCA[dimension]
            else:
                K_value = dimensionToKICA[dimension]

            X = Normalizer(norm="l2").fit_transform(X)

            #scaler = preprocessing.StandardScaler().fit(X)
            #scaler.transform(X)
            sse = 0
            #svm=SVC(n_clusters=K_value,random_state=9).fit(X)
            kmeans = KMeans(n_clusters=K_value,n_init=1000,max_iter=300,tol=0.0001,random_state=3).fit(X)
            s = pd.DataFrame(app, kmeans.labels_)
            s = pd.DataFrame({"labels":kmeans.labels_,"app":app}).sort_values("labels")

            s['IPC'] = data_initial['IPC']
            sheetName = 'dimension_' + str(dimension) + '_kvalue_' + str(K_value)
            s.to_excel(writer, sheet_name=sheetName)
        writer.save()
        writer.close()