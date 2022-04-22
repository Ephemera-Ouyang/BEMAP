import re
import os
import pandas as pd
from openpyxl import load_workbook
from tqdm import tqdm

total_data_Excel_dir = ''


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
    return CPI_list,APP_list

def get_event(event_file_dir):
    # 事件名处理
    file_handle = open(event_file_dir, 'r')
    for line in file_handle.readlines():
        line = line.strip()
        event = line.split(" ")
    for i in range(len(event)):
        event[i] = event[i].replace("\"", '')

    '''
    event_temp = ['context-switches',
                  'cpu-migrations',
                  'emulation-faults',
                  'page-faults',
                  'major-faults',
                  'minor-faults',
                  'cpu-clock',
                  'task-clock',
                  'raw-cpu-cycles']
    '''
    #event.extend(event_temp)
    return event

def build_event_reg_pattern(event):
    #根据所有event名建立相应的pattern
    #event_id_pattern_list = []
    event_name_pattern_list = []
    for i in range(len(event)):
        #temp = '\d{1,30}(?=  '+ event[i] +')'
        #event_id_pattern_list.append(re.compile(temp))
        event_name_pattern_list.append(re.compile('\s{1}'+event[i]+'\s{1}'))#加的idea是为了避免返回子串
    #print(event_name_pattern_list)
    return event_name_pattern_list

def get_feature_name(txt_dir, operation_type):
    #temp = txt_dir.strip().rsplit('/')[2] + '_'  # 1.1
    #仅从Alipay中提取特征名，因为其他txt文件与alipay特征名都一样
    feature_list = ['instructions','cycles per instruction','cpu-cycles','miss rate']
    # 目前已知feature

    # temp =  '(?<=\d).*(?=# )'
    # pattern_temp = re.compile(temp)

    reg_find_feature = '(?<=%).*(?=\(100%\))'
    pattern_find_feature = re.compile(reg_find_feature)

    # 处理带逗号的数值为了后期进行pandas计算
    num_handle = '\d+,\d+?'
    pattern_num_handle = re.compile(num_handle)

    file_handle = open(txt_dir + operation_type +'_Alipay.txt', 'r')  # 文件名 # 1.1
    #file_handle = open(txt_dir + 'M_AEX_XTS.txt', 'r')  # 文件名

    line_ana = ''
    for line in file_handle.readlines():
        line.strip()
        for st in pattern_num_handle.finditer(line):
            mm = st.group()
            line = line.replace(mm, mm.replace(",", ""))
        # print(pattern_temp.findall(line,re.I))
        m = pattern_find_feature.findall(line, re.I)
        if m != []:
            feature = m[0].strip()
            if feature not in feature_list:
                feature_list.append(feature)

    return feature_list

def build_feature_reg_pattern(feature_list):
    feature_name_pattern_list = []
    for feature in feature_list:
        if feature == 'memory read operation miss rate' or feature == 'miss rate':
            # avoid find subset result when check 'memory read operation miss rate',
            # but return 'miss rate'
            feature_name_pattern_list.append(re.compile('%\s{1}' + feature + '\s{1}'))
        else:
            feature_name_pattern_list.append(re.compile('\s{1}' + feature + '\s{1}'))
    return feature_name_pattern_list


def get_mean(lst):
    t = list(map(float,lst))
    return round(sum(t)/len(lst),7)



def run_1(txt_dir,app,writer,event_name_pattern_list,
          feature_name_pattern_list, operation_type):
    #temp = txt_dir.strip().rsplit('/')[2] + '_'  #1.1
    #print('Now handle file ' + txt_dir + temp + app + '.txt') #1.1
    #file_handle = open(txt_dir + temp + app + '.txt', 'r') #1.1
    print('Now handle file ' + txt_dir + operation_type + '_' + app + '.txt')
    file_handle = open(txt_dir + operation_type + '_' + app + '.txt', 'r')
    create_table(app,file_handle,writer,event_name_pattern_list
                 ,feature_name_pattern_list)
    file_handle.close()

def create_table(file_txt,file_handle,writer,
                 event_name_pattern_list,feature_name_pattern_list):


    colnm = ['event_name', 'event']
    colnm.extend(feature_list)
    df = pd.DataFrame(columns=colnm)  # 建立空表

    # 处理带逗号的数据
    num_handle = '\d+,\d+?'
    pattern_num_handle = re.compile(num_handle)

    line_ana = ''
    for line in file_handle.readlines():
        if line == '\n':
            # 处理带逗号的数据
            for st in pattern_num_handle.finditer(line_ana):
                mm = st.group()
                line_ana = line_ana.replace(mm, mm.replace(",", ""))
            information = []
            # 先读取事件名以及id
            for pattern_event_name in event_name_pattern_list:
                event_name = pattern_event_name.findall(line_ana, re.I)
                if event_name != []:
                    event_name = event_name[0].strip()  # 对event_name的处理
                    information.append(event_name)
                    # event_id_reg = '\d{1,30}(?=  '+ event_name[0] +')'
                    pattern_event_id = re.compile('\d{1,30}.*(?=  ' + event_name + ')')  # 构建event_id正则表达式
                    event_id = pattern_event_id.findall(line_ana, re.I)
                    information.append(event_id[0].strip())

                    for pattern_feature_name in feature_name_pattern_list:
                        feature_name = pattern_feature_name.findall(line_ana, re.I)
                        if feature_name == []:
                            information.append(0.0)
                        else:

                            feature_name = feature_name[0]
                            if feature_name[0] == '%':  # 特意处理memory read operation miss rate会由miss rate 匹配上(字串)
                                feature_name = feature_name[1:]  # 去掉%号
                                feature_name = feature_name.strip()
                            else:
                                feature_name = feature_name.strip()
                            if feature_name == feature_list[0] or feature_name == feature_list[2]:
                                # 'insturctions' and 'cpu-cycles' position is stable use below pattern
                                # print(feature_name,feature_list[0])
                                pattern_feature_value = re.compile('\d{1,30}.*(?=  ' + feature_name + ')')
                                feature_value = pattern_feature_value.findall(line_ana, re.I)[0].strip()
                                information.append(feature_value)
                            else:
                                pattern_feature_value = re.compile(
                                    '(?<=#)\s+\d{1,5}.\d{1,20}%?\s+(?=' + feature_name + ')')
                                # print(feature_name,pattern_feature_value.findall(line_ana,re.I))
                                feature_value = pattern_feature_value.findall(line_ana, re.I)[0].strip()
                                information.append(feature_value)

                    #print(information)
                    df.loc[df.shape[0]] = information
                information = []
                # 读取相关feature信息
                # information = []

            line_ana = ''
        else:
            # line = line.strip()
            line_ana = line_ana + " " + line

    # 将带%号数据进行处理为小数
    for col in df.columns[5:]:
        for data in df[col]:
            if data != 0:
                #print(data)
                try:
                    temp = round(float(data[:-1]) * 0.01, 8)
                    df.loc[df[col] == data, col] = temp
                except Exception as e:
                    #print('this data has already replace before')
                    pass
    # 检测实验次数
    experm_num = len(df[df['event_name'] == event[0]])
    print(event[0] + ' repeat experiment ' + str(experm_num) + " times")

    if experm_num > 5:
        experm_num = 5

    for event_name in event[1:]:
        if len(df[df['event_name'] == event_name]) < experm_num:
            print('something wrong of ' + event_name + ' it only run ' +
                  str(len(df[df['event_name'] == event_name])) + ' times' + ' file name is '
                  + file_txt)
            experm_num = len(df[df['event_name'] == event_name])
        #else:
        #    print(event_name + 'reapeat experiment ' + str(experm_num) + " times")


    # 分别存储每次实验的表为后续merge做准备
    df_divide = []  # 分别存储分割后的表为后续merge做准备
    for epoch in range(experm_num):
        temp = df[df['event_name'] == event[0]][epoch:epoch + 1]
        for event_name in event[1:]:
            t = df[df['event_name'] == event_name][epoch:epoch + 1]
            temp = pd.concat([temp, t], 0)
        temp = temp.reset_index(drop=True)  # 添加drop=True就是为了去掉index，不然表里面会多一列记录index
        # temp = temp.rename(columns={'event_name':'event_name_' + str(epoch)})#修改列名以表示第几次实验
        temp_colnms = list(temp.columns)
        for i in range(len(temp_colnms)):
            temp_colnms[i] = temp_colnms[i] + '_' + str(epoch)
        temp.columns = temp_colnms
        df_divide.append(temp)

    # 将每次实验的表进行merge合成一张表
    for i in range(len(df_divide)):
        if i == 0:
            temp = df_divide[0]
        else:
            temp = pd.merge(temp, df_divide[i], left_on='event_name_0', right_on=df_divide[i].columns[0])
    df_detail = temp

    # 处理平均表
    df_mean_columns = []
    for col in df.columns[:6]:
        if col != 'event_name':
            col += '/均值'
        df_mean_columns.append(col)

    df_mean = pd.DataFrame(columns=df_mean_columns)
    for event_name in event:
        data = []
        data.append(event_name)
        for col in df.columns[1:]:
            try:
                mean = get_mean(list(df[col][df['event_name'] == event_name]))
            except Exception as e:
                temp_list = list(df[col][df['event_name'] == event_name])
                print('some char in data' + str(temp_list) + 'file name is ' + file_txt)
                for i in range(len(temp_list)):
                    temp_list[i] = temp_list[i].replace('(ms)', '')
                mean = str(get_mean(temp_list)) + '(ms)'
            data.append(mean)
        data[5] = sum(data[5:])  # 将其他的和rate相关的数据全部放进miss rate当中
        data = data[:6]  # 将其他的和rate相关的数据全部放进miss rate当中
        #print(data)
        if data[3] == 0.0: # 基于某些数据没有cycles per instruction/均值 手动计算
            if data[4] == 0 and data[2] == 0:
                data[3] = 0
            else:
                data[3] = round(data[4] / data[2], 9)
        df_mean.loc[df_mean.shape[0]] = data


    #将每次实验表和平均表合在一块
    df_total = pd.merge(df_mean, df_detail, left_on=df_mean.columns[0], right_on=df_detail.columns[0])



    _excelAddSheet(df_total, writer, file_txt)
    print('Finsh file ' + file_txt)



def _excelAddSheet(dataframe,excelWriter,sheet_name):

    book = load_workbook(excelWriter.path)
    excelWriter.book = book
    dataframe.to_excel(excel_writer=excelWriter,sheet_name=sheet_name,index=None)
    excelWriter.close()


if __name__ == '__main__':

    operationTypes = ['change', 'quench', 'slide']
    for operation in operationTypes:
        curLoc = os.getcwd()
        #txt_dir = './geekbench/huawei/geekbench_huawei/' # path which save txt file(original data)
        txt_dir = curLoc + '/xiaomi11/' + operation + '/'  # path which save txt file(original data)

        CPI_and_APP_dir = curLoc + '/APP.txt'
        CPI_list,APP_list = get_APP_name(CPI_and_APP_dir)

        event_file_dir = curLoc + '/event2.txt'
        event = get_event(event_file_dir)# get all event name:e.g. 'branch-load-misses'
        event_name_pattern_list = build_event_reg_pattern(event) # build reg pattern for event name
        feature_list = get_feature_name(txt_dir, operation) # get feature name
        feature_name_pattern_list = build_feature_reg_pattern(feature_list) # build feature reg pattern

        total_data_Excel_dir = curLoc + '/Outputs/xiaomi' + '_' + operation + '.xlsx'  # after data operation, all data will save in this file
        pd.DataFrame().to_excel(total_data_Excel_dir)
        writer = pd.ExcelWriter(total_data_Excel_dir, engine='openpyxl')

        for app in tqdm(APP_list):
            run_1(txt_dir,app,writer,event_name_pattern_list,feature_name_pattern_list,operation)




