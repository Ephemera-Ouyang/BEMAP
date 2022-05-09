import numpy as np
import os
from collections import Counter
import csv

curLoc = os.getcwd()


def get_IPC(validationSet):
    filePath = validationSet
    with open(filePath, 'r') as IPCFile:
        csvReader = csv.reader(IPCFile)
        next(csvReader)
        ipc = []
        for line in csvReader:
            ipc.append(line[-1])
    return ipc


def get_APP_name(CPI_and_APP_dir):
    CPI_list = []
    APP_list = []
    file_handle = open(CPI_and_APP_dir, 'r')
    iteration = 0
    for line in file_handle.readlines():
        if iteration == 0:
            line = line.strip()
            temp = line.split(",")
            for i in range(len(temp)):
                temp[i] = temp[i].replace("\'", '')
                temp[i] = temp[i].replace("\"", '')
            CPI_list.extend(temp)
        if iteration == 2:
            line = line.strip()
            temp = line.split(",")
            for i in range(len(temp)):
                temp[i] = temp[i].replace("\'", '')
                temp[i] = temp[i].replace("\"", '')
            APP_list.extend(temp)
        iteration += 1
    return CPI_list, APP_list


def averageColumn(filePath):
    columnTotal = Counter()
    with open(filePath, "rt") as f:
        reader = csv.reader(f)
        next(reader)
        rowCount = 0
        for row in reader:
            del(row[0])
            del(row[-1])
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
    return averages


def loadMatrix(filePath, skipHeader=False):
    if skipHeader:
        tmp = np.loadtxt(filePath, dtype=np.str_, delimiter=",", skiprows=1)
        tmp = np.delete(tmp, 0, axis=1)
        tmp = np.delete(tmp, -1, axis=1)
    else:
        tmp = np.loadtxt(filePath, dtype=np.str_, delimiter=",")
    data = tmp[:].astype(np.float64)
    return data


def PCAandICACompressValidation(dimensions, validationSet):
    noteMatrixNd = loadMatrix(validationSet, True)
    noteMatrix = np.matrix(noteMatrixNd)
    noteAverage = averageColumn(validationSet)
    meanOfNote = np.matrix(noteAverage)
    noteMatrixAfterMean = noteMatrix
    ipc = get_IPC(validationSet)
    for i in range(len(noteMatrix)):
        noteMatrixAfterMean[i] = noteMatrixAfterMean[i] - meanOfNote

    for method in ['ICA']:
        for numOfComponents in dimensions:
            header = []
            header.append('')
            for i in range(numOfComponents):
                header.append('event_' + str(i))
            header.append('IPC')

            CPI_and_APP_dir = curLoc + '/APP.txt'
            CPI_list, APP_list = get_APP_name(CPI_and_APP_dir)

            transforMatrix = loadMatrix(
                curLoc + "/BEMAP/RFC/" + str(method) + "/transformingMatrix" + str(method) + "_" + str(
                    numOfComponents) + ".csv")
            b = np.matrix(transforMatrix)
            output = noteMatrixAfterMean * b
            with open(
                    curLoc + '/BEMAP/RFC/NoteAfterPCAandICA/using' + str(method) + '_' + str(numOfComponents) + '.csv',
                    'w',
                    newline='') as matrixFile:
                matrixFileWriter = csv.writer(matrixFile)
                matrixFileWriter.writerow(header)
                out = output.tolist()
                i = 0
                print(APP_list.__len__())
                print(out.__sizeof__())
                for o in out:
                    o.insert(0, APP_list[i])
                    o.append(ipc[i])
                    matrixFileWriter.writerow(o)
                    i += 1
                print("i is" + str(i))


if __name__ == '__main__':
	trainSet = input("Input the path of validationSet:\n")
	PCAandICACompressValidation(dimensions=[16,20,24], inputFile=trainSet)