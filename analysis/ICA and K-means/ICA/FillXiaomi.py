import os
import pandas as pd

curLoc = os.getcwd()

mateExcel = curLoc + '/Outputs/change_mate30_all.xlsx'
appsTxt = curLoc + '/APP.txt'
outputExcel = curLoc + '/Outputs'

def main():
    for oper in ['change','quench','slide']:
        xiaomiExcel = curLoc + '/Outputs/xiaomi_' + oper + '.xlsx'
        with open(appsTxt, "r") as appFile:
            lines = appFile.readlines()
        apps = lines[2].replace("\'","").replace("\n","").split(",")
        with pd.ExcelWriter(outputExcel + '/' + oper + "_xiaomi11_all.xlsx") as writer:
            for app in apps:
                newXiaomiDf = convertSheet(xiaomiExcel,app)
                newXiaomiDf.to_excel(writer, sheet_name=app, index=None)


def convertSheet(xiaomiExcel, sheetName):
    xiaomiSource = pd.read_excel(xiaomiExcel, sheet_name=sheetName)
    mateSource = pd.read_excel(mateExcel, sheet_name=sheetName)

    pdXiaomi = pd.DataFrame(xiaomiSource)
    pdMate = pd.DataFrame(mateSource)

    xiaomiHeader = list(pdXiaomi[0:0])
    mateHeader = list(pdMate[0:0])
    xiaomiEvents = pdXiaomi['event_name']
    mateEvents = pdMate['event_name']

    # with pd.ExcelWriter('geekbench_huawei_second_all.xlsx') as writer:
    #
    #
    #     pd.DataFrame(source).to_excel(writer, sheet_name='Alipay')
    #     pd.DataFrame(source).to_excel(writer, sheet_name='Alipay1')
    i = 0
    cpuCycles = []
    instructions = []
    event_name = []
    for header in xiaomiHeader:
        if i > 5:
            if 'cpu-cycles_' in header:
                cpuCycles.append(i)
            elif 'instructions_' in header:
                instructions.append(i)
            elif 'event_' in header and 'name' not in header:
                event_name.append(i)
        i += 1

    insterRow = []
    j = 0
    for header in xiaomiHeader:
        if j in cpuCycles or j in instructions:
            insterRow.append(1)
        elif j in event_name:
            insterRow.append(0)
        else:
            insterRow.append(0)
        j += 1

    k = 0
    newRows = []
    for mateEvent in mateEvents:
        if mateEvent not in list(xiaomiEvents):
            newRows.append(k)
        k += 1

    newXiaomiDf = pd.DataFrame()
    newXiaomiList = []
    l = 0
    for index in pdXiaomi.index:
        if l in newRows:
            newXiaomiList.append(insterRow)
        newXiaomiList.append(list(pdXiaomi.loc[index]))
        l += 1
    newXiaomiDf = newXiaomiDf.append(newXiaomiList)
    newXiaomiDf.columns = xiaomiHeader

    for event in xiaomiHeader:
        if 'event_name' in event:
            newXiaomiDf[event] = mateEvents

    return newXiaomiDf

if __name__ == '__main__':
    main()