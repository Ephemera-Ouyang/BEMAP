import os
import sys

import numpy as np

import ICADimensionReduction
import PCADimensinReduction
import PCAandICACompressOriginal
import decideKvaluePCA
import decideKvalueICA
import kmeans
import pandas as pd

curLoc = os.getcwd()

trainSet = curLoc + "/../RFC/" +"note10+xiaomi11/SGBRT+ICAandPCA/ICAandPCA_train.csv"
validationSet = curLoc + "/../RFC/" + "note10+xiaomi11/SGBRT+ICAandPCA/ICAandPCA_validation.csv"
dimensions = [16, 20, 26]

#PCADimensinReduction.PCAReduction(dimensions=dimensions, inputFile=trainSet)
ICADimensionReduction.ICAReduction(dimensions=dimensions, inputFile=trainSet)
PCAandICACompressOriginal.PCAandICACompressValidation(dimensions=dimensions, validationSet= validationSet)


dimensionToKvalueICA = {}
for dimension in dimensions:
    decideKvalueICA.decide(dimension)
    dimensionToKvalueICA[dimension] = int(input("Input the k value of dimension " + str(dimension) + " for ICA:\n"))

#dimensionToKvaluePCA = {}
#for dimension in dimensions:
#   decideKvaluePCA.decide(dimension)
#    dimensionToKvaluePCA[dimension] = int(input("Input the k value of dimension " + str(dimension) + " for PCA:\n"))

kmeans.kmeansForCluster(dimensions = dimensions, dimensionToKP = dimensionToKvaluePCA, dimensionToKI = dimensionToKvalueICA)


#for reducer in ["PCA","ICA"]:
for reducer in ["ICA"]:
    excels = pd.ExcelFile(curLoc + "/../RFC/using" + str(reducer) + "_Kmeans.xlsx")
    sheet_name_list = excels.sheet_names
    print(sheet_name_list)
    writer = pd.ExcelWriter(curLoc + "/../RFC/using" + str(reducer) + "_Kmeans_select.xlsx")
    average_IPC_list = []
    for x in range(len(sheet_name_list)):
        data_kmeans = pd.read_excel(curLoc + "/../RFC/using" + str(reducer) + "_Kmeans.xlsx", sheet_name=sheet_name_list[x], index_col=0)
        pd_data_select = pd.DataFrame()
        pd_data_select = data_kmeans[data_kmeans['labels'] == 0].sort_values(by='IPC').iloc[
            int((data_kmeans[data_kmeans['labels'] == 0].sort_values(by='IPC')['IPC'].count()) / 2)].to_frame().T
        for i in range(1, int(sheet_name_list[x].split("kvalue_")[-1])):
            pd_data_add = pd.DataFrame()
            pd_data_add = data_kmeans[data_kmeans['labels'] == i].sort_values(by='IPC').iloc[
                int((data_kmeans[data_kmeans['labels'] == i].sort_values(by='IPC')['IPC'].count()) / 2)].to_frame().T
            pd_data_select = pd.concat([pd_data_select, pd_data_add], axis=0, join='inner', ignore_index=False)
        average_IPC_list.append(pd_data_select['IPC'].mean())
        print('Mean is ' + str(np.mean(average_IPC_list)))
        pd_data_select.to_excel(writer, sheet_name=sheet_name_list[x])
    writer.save()
    writer.close()
