# coding=utf-8
import re
import os
import pandas as pd
from openpyxl import load_workbook
from tqdm import tqdm


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
            print(line)
            temp = line.split(",")
            for i in range(len(temp)):
                temp[i] = temp[i].replace("\'", '')
                temp[i] = temp[i].replace("\"", '')
            APP_list.extend(temp)
        iteration += 1
    return CPI_list, APP_list


def get_APP_name_2(APP_dir):
    APP_list = []
    # APP_list = []
    file_handle = open(APP_dir, 'r')
    iteration = 0
    for line in file_handle.readlines():
        if iteration == 0:
            line = line.strip()
            temp = line.split(",")
            for i in range(len(temp)):
                temp[i] = temp[i].replace("\'", '')
                temp[i] = temp[i].replace("\"", '')
            APP_list.extend(temp)

        iteration += 1
    return APP_list


def get_event(event_file_dir):
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
    # event.extend(event_temp)
    return event


def build_event_reg_pattern(event):
    # event_id_pattern_list = []
    event_name_pattern_list = []
    for i in range(len(event)):
        # temp = '\d{1,30}(?=  '+ event[i] +')'
        # event_id_pattern_list.append(re.compile(temp))
        event_name_pattern_list.append(re.compile('\s{1}' + event[i] + '\s{1}'))
    # print(event_name_pattern_list)
    return event_name_pattern_list


def get_feature_name(txt_dir):
    # temp = txt_dir.strip().rsplit('/')[2] + '_'
    # print(temp)
    print(txt_dir)
    feature_list = ['instructions', 'instruction per cycles', 'cpu-cycles', 'miss rate']

    # temp =  '(?<=\d).*(?=# )'
    # pattern_temp = re.compile(temp)

    reg_find_feature = '(?<=%).*(?=\(100%\))'
    pattern_find_feature = re.compile(reg_find_feature)

    num_handle = '\d+,\d+?'
    pattern_num_handle = re.compile(num_handle)

    # file_handle = open(txt_dir + temp + 'Alipay.txt', 'r')
    # file_handle = open(txt_dir + 'M_AEX_XTS.txt', 'r')
    file_handle = open(txt_dir + 'bigolive.txt', 'r')
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
    # print(feature_list)
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
    t = list(map(float, lst))
    return round(sum(t) / len(lst), 7)


def run_1(txt_dir, app, writer, event_name_pattern_list,
          feature_name_pattern_list):
    # temp = txt_dir.strip().rsplit('/')[2] + '_'  #1.1
    """
    try:
        #print('Now handle file ' + txt_dir + temp + app + '.txt') #1.1
        #file_handle = open(txt_dir + temp + app + '.txt', 'r') #1.1
        print('Now handle file ' + txt_dir + app + '.txt')
        file_handle = open(txt_dir + app + '.txt', 'r')
        create_table(app,file_handle,writer,event_name_pattern_list
                     ,feature_name_pattern_list)
        file_handle.close()
    except Exception as e:
        print(e,'question in here1')
    """
    print('Now handle file ' + txt_dir + app + '.txt')
    file_handle = open(txt_dir + app + '.txt', 'r')
    create_table(app, file_handle, writer, event_name_pattern_list
                 , feature_name_pattern_list)
    file_handle.close()


def create_table(file_txt, file_handle, writer,
                 event_name_pattern_list, feature_name_pattern_list):
    colnm = ['event_name', 'event']
    colnm.extend(feature_list)
    df = pd.DataFrame(columns=colnm)

    num_handle = '\d+,\d+?'
    pattern_num_handle = re.compile(num_handle)

    line_ana = ''
    for line in file_handle.readlines():
        if line == '\n':
            for st in pattern_num_handle.finditer(line_ana):
                mm = st.group()
                line_ana = line_ana.replace(mm, mm.replace(",", ""))
            information = []

            for pattern_event_name in event_name_pattern_list:
                event_name = pattern_event_name.findall(line_ana, re.I)
                if event_name != []:
                    event_name = event_name[0].strip()  # event_name
                    information.append(event_name)
                    # event_id_reg = '\d{1,30}(?=  '+ event_name[0] +')'
                    pattern_event_id = re.compile('\d{1,30}.*(?=  ' + event_name + ')')
                    event_id = pattern_event_id.findall(line_ana, re.I)
                    information.append(event_id[0].strip())

                    for pattern_feature_name in feature_name_pattern_list:
                        feature_name = pattern_feature_name.findall(line_ana, re.I)
                        if feature_name == []:
                            information.append(0.0)
                        else:

                            feature_name = feature_name[0]
                            if feature_name[0] == '%':
                                # print(feature_name)
                                feature_name = feature_name[1:]
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

                    # print(information)
                    df.loc[df.shape[0]] = information
                information = []
            line_ana = ''
        else:
            # line = line.strip()
            line_ana = line_ana + " " + line
            # print(line_ana)
    for col in df.columns[5:]:

        for data in df[col]:
            if data != 0:
                try:
                    float_value = float(data[:-1])
                    # print(type(data[:-1]))
                    temp = round(float_value * 0.01, 8)
                    df.loc[df[col] == data, col] = temp
                except Exception as e:
                    # print('% value has already replaced')
                    # print('this data has already replace before') #core idea 注释掉是为了会打很多次
                    pass
    experm_num = len(df[df['event_name'] == event[0]])
    print(event[0] + ' repeat experiment ' + str(experm_num) + " times")
    experm_num = 2
    if experm_num > 5:
        experm_num = 5

    for event_name in event[0:]:
        if len(df[df['event_name'] == event_name]) < experm_num:
            print('something wrong of ' + event_name + ' it only run ' +
                  str(len(df[df['event_name'] == event_name])) + ' times' + ' file name is '
                  + file_txt)
            #experm_num = len(df[df['event_name'] == event_name]) #2022/3/24
        # else:
        #    print(event_name + 'reapeat experiment ' + str(experm_num) + " times")

    df_divide = []
    for epoch in range(experm_num):
        temp = df[df['event_name'] == event[0]][epoch:epoch + 1]
        #print(temp)
        for event_name in event[1:]:
            t = df[df['event_name'] == event_name][epoch:epoch + 1]
            temp = pd.concat([temp, t], axis=0)
        temp = temp.reset_index(drop=True)
        # temp = temp.rename(columns={'event_name':'event_name_' + str(epoch)})
        temp_colnms = list(temp.columns)
        for i in range(len(temp_colnms)):
            temp_colnms[i] = temp_colnms[i] + '_' + str(epoch)
        temp.columns = temp_colnms
        df_divide.append(temp)

    for i in range(len(df_divide)):
        if i == 0:
            temp = df_divide[0]
        else:
            temp = pd.merge(temp, df_divide[i], left_on='event_name_0', right_on=df_divide[i].columns[0])
    df_detail = temp

    df_mean_columns = []
    for col in df.columns[:6]:
        if col != 'event_name':
            col += '/average value'
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
        data[5] = sum(data[5:])
        data = data[:6]
        # print(data)
        """
        if data[3] == 0.0: # 基于某些数据没有cycles per instruction/均值 手动计算
            if data[4] == 0 and data[2] == 0:
                data[3] = 0
            else:
                data[3] = round(data[4] / data[2], 9)
        """
        if data[3] == 0.0:  # 手动计算
            if data[4] == 0 and data[2] == 0:
                data[3] = 0
            else:
                data[3] = round(data[2] / data[4], 9)

        df_mean.loc[df_mean.shape[0]] = data

    df_total = pd.merge(df_mean, df_detail, left_on=df_mean.columns[0], right_on=df_detail.columns[0])

    _excelAddSheet(df_total, writer, file_txt)
    print('Finsh file ' + file_txt)


def _excelAddSheet(dataframe, excelWriter, sheet_name):
    dataframe.to_excel(excel_writer=excelWriter, sheet_name=sheet_name, index=None)


if __name__ == '__main__':
	print("Enter your smart phone(mate30,note10,or mi11):")
	smartphone = input()
	print("Enter your operation(sliding,switching,or quenching):")
	operation = input()	
	phone
    # txt_dir = './geekbench/huawei/geekbench_huawei/' # path which save txt file(original data)
    txt_dir = '../AutoProfiler/'+ smartphone +'/' + operation +'/'  # path which save txt file(original data)

    # CPI_and_APP_dir = './geekbench/app.txt'
    # CPI_and_APP_dir = './APP.txt'
    # CPI_list,APP_list = get_APP_name(CPI_and_APP_dir)

    APP_list = get_APP_name_2('./APP.txt')
    #APP_list = get_APP_name_2('./xiaomi-20220327-100/APP.txt')
    #APP_list_20 = get_APP_name_2('./xiaomi-20220327-100/new_added_app.txt')
    #APP_list.extend(APP_list_20)
    print(len(APP_list))

    # event_file_dir = './event.txt'
	if  smartphone == "mi11":
		event_file_dir = './event2.txt' #xiaomi only use event2
	else:
		event_file_dir = './event.txt'
    event = get_event(event_file_dir)  # get all event name:e.g. 'branch-load-misses'
    print(len(event))

    event_name_pattern_list = build_event_reg_pattern(event)  # build reg pattern for event name
    feature_list = get_feature_name(txt_dir)  # get feature name
    feature_name_pattern_list = build_feature_reg_pattern(feature_list)  # build feature reg pattern

    total_data_Excel_dir = './all.xlsx'  # after data operation, all data will save in this file
    pd.DataFrame().to_excel(total_data_Excel_dir)
    writer = pd.ExcelWriter(total_data_Excel_dir, engine='openpyxl')
    #print(writer.path,'here3')
    for app in tqdm(APP_list):
        run_1(txt_dir, app, writer, event_name_pattern_list, feature_name_pattern_list)

    writer.close()