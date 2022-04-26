import csv
import os
from collections import Counter

import numpy as np
import numpy.linalg
import pandas as pd
#import EnvironmentParser
from sklearn import decomposition
from sklearn import utils

curLoc = os.getcwd()

def averageColumn(filePath):
    columnTotal = Counter()
    with open(filePath, "rt") as f:
        reader = csv.reader(f)
        next(reader)
        rowCount = 0
        for row in reader:
            for columnIdx, columnValue in enumerate(row):
                try:
                    v = float(columnValue)
                    columnTotal[columnIdx] += v
                except ValueError:
                    print("Error ({}) Column({}) could not be converted to float!".format(columnValue, columnIdx))
            rowCount += 1
    rowCount -= 1
    columnIdxes = columnTotal.keys()
    sorted(columnIdxes)
    averages = [columnTotal[columnIdx] / rowCount for columnIdx in columnIdxes]
    del (averages[-1])
    return averages


def loadModelingData(*, return_X_y=False, filePath):
    global headerFroOutput
    with open(filePath) as f:
        dataFile = csv.reader(f)
        header = next(dataFile)
    samplingData = []

    data = pd.read_csv(filePath, sep=',', engine='python', iterator=True, header=0, index_col=0)
    loop = True
    chunkSize = 10000
    chunks = []
    index = 0
    while loop:
        try:
            chunk = data.get_chunk(chunkSize)
            chunks.append(chunk)
            index += 1

        except StopIteration:
            loop = False
    samplingData = pd.concat(chunks, ignore_index=True)

    samplingData = samplingData.values.tolist()
    # for da in dataFile:
    #     samplingData.append(da)
    NumOfSamples = len(samplingData)
    NumOfFeatures = len(samplingData[0])

    print('number of samples is ' + str(NumOfSamples))
    print('number of features is ' + str(NumOfFeatures))

    data = np.empty((NumOfSamples, NumOfFeatures))
    target = np.empty((NumOfSamples,))
    featureNames = np.array(header)

    for i, d in enumerate(samplingData):

        data[i] = np.asarray(d[:], dtype=np.float64)
        target[i] = np.asarray(d[-1], dtype=np.float64)

    if return_X_y:
        return data, target

    return utils.Bunch(data=data[:NumOfSamples],
                       target=target[:NumOfSamples],
                       # last column == target value
                       featureNames=featureNames[:-1],
                       filename=filePath)

def ICAReduction(dimensions, inputFile):
    for numOfComponents in dimensions:
        headerFroOutput = []
        for i in range(numOfComponents):
            headerFroOutput.append('event_' + str(i))



        modelingData = loadModelingData(filePath=inputFile)
        X = modelingData.data
        y = modelingData.target

        ica = decomposition.FastICA(n_components=numOfComponents)
        ica.fit(X)
        X = ica.transform(X)


        a = np.matrix(X)
        b = np.matrix(ica.components_)

        c = a * b

        d = averageColumn(inputFile)

        mean_of_data = np.matrix(d)

        with open(curLoc + '/NewSamples/ICA/afterICA_' + str(numOfComponents) + '.csv', 'w', newline='') as matrixFile:
            matrixFileWriter = csv.writer(matrixFile)
            matrixFileWriter.writerow(headerFroOutput)
            wX = X.tolist()
            for wx in wX:
                matrixFileWriter.writerow(wx)

        with open(curLoc + '/NewSamples/ICA/transformingMatrixICA_' + str(numOfComponents) + '.csv', 'w', newline='') as matrixFile:
            matrixFileWriter = csv.writer(matrixFile)
            wb = numpy.linalg.pinv(b).tolist()
            for wb_ in wb:
                matrixFileWriter.writerow(wb_)

if __name__ == '__main__':
    ICAReduction()