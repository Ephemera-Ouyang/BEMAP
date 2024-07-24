# coding: utf-8

"""
=========================================
Train with Cross-validation. SGBRT
=========================================

"""

from __future__ import print_function
print(__doc__)

import os
import pickle
import numpy as np
import pandas as pd
from sklearn.model_selection import KFold
from sklearn.model_selection import train_test_split
from sklearn.ensemble import GradientBoostingRegressor
from sklearn.model_selection import cross_val_score


class Train_CV_SGBRT(object):
    def __init__(self,dpath,filename):

        self.data_path = dpath

        self.algorithm_name = filename


    def train_sk_cv(self):

        if ".csv" in self.algorithm_name:
            algorithm = str(self.algorithm_name)
        else:
            algorithm = str(self.algorithm_name + '.csv')

        algorithm = os.path.join(self.data_path, algorithm)
        data = pd.read_csv(algorithm)
        #data = data.reset_index()

        if "top16" in self.algorithm_name:  # for top 16 events
            X = data.iloc[:, 1:16]
            y = data.iloc[:, 16]
            Itera = 1
        else:
            X = data.iloc[:, 1:127]
            y = data.iloc[:, 127]

            #X = X.reindex(columns=['RSSA', 'CCR0', 'BIRB', 'REEC', 'OROR', 'IMDU', 'RSSO', 'MCSM', 'UISL', 'PWD1', 'ISIF', 'ML1H', 'BINR', 'UEP2', 'IRAP', 'MEIE', 'UEP0', 'UEP1', 'UEP4', 'BIRC', 'RSSS', 'UEP5', 'MRAS', 'CA2P', 'CADP', 'OROC', 'LLII', 'MLMD'])

        #训练次数
            Itera = 23
        # X = X[:500]
        # y = y[:500]
        # X = X.iloc[:-1]
        # y = y.iloc[:-1]
        events_name = X.columns


        def feature_importances_(self):
            """
            Returns
            -------
            feature_importances_ : array of shape = [n_features]

            """
            b = self.booster()
            fs = b.get_fscore()
            all_features = [fs.get(f, 0.) for f in b.feature_names]
            all_features = np.array(all_features, dtype=np.float32)
            return all_features / all_features.sum()


        def data_process_remove_zero(ytest, predict):
            """ removing zero in ytest, predict for computing error
            :param ytest:
            :param predict:
            :return:
            """
            ytest = ytest.tolist()
            predict = predict.tolist()
            zero = []
            for i in range(len(ytest)):
                if ytest[i] == 0:
                    print('-----> zero value in ytest: {}'.format(ytest[i]))
                    zero.append(i)
                    ytest[i] = "zero"
                    predict[i] = "zero"
            if "zero" in ytest:
                ytest.remove("zero")
                predict.remove("zero")
            ytest = np.asarray(ytest).astype(float)
            predict = np.asarray(predict).astype(float)
            return ytest, predict


        def cv_estimate(X_train, y_train):
            """
            corss validation: split the X_train to train dataset and valid dataset
            -------
            :param X_train: Event value. type: Pandas DataFrame
            :param y_train: IPC value. type: Pandas DataFrame
            :return: GBM model which has lowest error
            """
            n_splits = 9
            if X_train is None or y_train is None:
                return -1
            cv_clf_list = []
            err_list = []
            cv = KFold(n_splits=n_splits)
            forest = GradientBoostingRegressor()
            #参数
            forest = GradientBoostingRegressor(#n_estimators=400,    #800,
                                               #loss='huber'
                                               #max_depth=5,           #20,
                                               #learning_rate=0.2
                                               #min_samples_leaf=1,
                                               #min_samples_split=2
                                               )

            for train, valid in cv.split(X_train, y_train):
                forest.fit(X_train.iloc[train], y_train.iloc[train])
                preds = forest.predict(X_train.iloc[valid])
                predicted = preds
                y_test = y_train.iloc[valid]
                assert len(predicted) == len(y_test)
                y_test = np.asarray(y_test).astype(float)
                predicted = np.asarray(predicted).astype(float)
                y_test, predicted = data_process_remove_zero(ytest=y_test, predict=predicted)
                err = np.mean(np.abs(y_test - predicted) / y_test)
                cv_clf_list.append(forest)
                err_list.append(err)

            cv_clf_lowest = cv_clf_list[np.argmin(err_list)]
            return cv_clf_lowest

        Err = []
        Importances = []
        Indices = []
        Events_Name = []
        #Itera = 24
        forest = GradientBoostingRegressor(max_depth=0, n_estimators=1)
        for _ in range(Itera):
            """ Event Importance Refinement (EIR) """
            print('the %s th training' % _)
            assert len(X) == len(y)
            X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=0)
            forest = cv_estimate(X_train, y_train)
            forest = forest.fit(X_train, y_train)

            predicted = forest.predict(X_test)
            assert len(predicted) == len(y_test)
            y_test = np.asarray(y_test).astype(float)
            predicted = np.asarray(predicted).astype(float)
            y_test,predicted = data_process_remove_zero(ytest=y_test,predict=predicted)
            err = np.mean(np.abs(y_test - predicted) / y_test)

            #importances = feature_importances_(forest)
            #indices = np.argsort(importances)[::-1]

            importances = forest.feature_importances_
            indices = np.argsort(importances)[::-1]

            importances_sum = sum(importances)
            if (importances_sum < 0.9999) or (importances_sum > 1.0002):
                print('------> Sum of importance: {}'.format(importances_sum))
                os._exit(1)

            Err.append(err)
            Indices.append(indices)
            events_Name = []
            importanceS = []
            print("Feature ranking:")
            for f in range(X.shape[1]):
                events_Name.append(events_name[indices[f]])
                importanceS.append(importances[indices[f]])
                print("%d. feature %d  %s (%f)" % (f + 1, indices[f], events_name[indices[f]], importances[indices[f]]))
            Events_Name.append(events_Name)
            Importances.append(importanceS)
            
            #if _ < Itera - 1:
            #    """ Deleting the least important 7(10) events in each Iteration 206 """
            #    X = pd.DataFrame(X)
            #    X[X.columns[indices[-5 * (_ + 1):]]] = 0
                #X = np.array(X)
            
            print('Error: ', err * 100, '%')


        res = {}
        res['result'] = [Err, Indices, Events_Name, Importances]
        #output = open(r'C:/Users/OUYANG/Desktop/single/result_' + self.algorithm_name[32:-5] + '_cv_SGBRT.pkl', 'wb')
        #pickle.dump(res, output)
        
        res_data = pd.DataFrame()
        res_error = pd.DataFrame()
        res_error['Error'] = Err
        for i in range(125):
          list_zero.append(0)
        res_data.loc[0:126,'Error'] = list_zero + [Err[-1]]
        res_data['Indices'] = Indices[-1][0:126]
        res_data['Events_Name'] = Events_Name[-1][0:126]
        res_data['Importances'] = Importances[-1][0:126]
       
        #res_error.to_excel(writer1, sheet_name=self.algorithm_name[dfilename_len+5:-5])
        #res_data.to_excel(writer, sheet_name=self.algorithm_name[dfilename_len+5:-5])
        
        return res

    def build(self):
        self.train_sk_cv()

    def  build_loop(self):
        """
        整个文件夹遍历
        :return:
        """
        path_list = os.listdir(self.data_path)
        print(path_list)

        for i in path_list:
            print(i)
            self.algorithm_name = i
            self.train_sk_cv()
            #os._exit(1)

if __name__ == '__main__':


    writer = pd.ExcelWriter('/MFC/all_top_result.xlsx')
    writer1 = pd.ExcelWriter('/MFC/all_top_error_result.xlsx')

    dtpath = '/MFC/'
    alg_name = 'mate30_note10_xiaomi11_pred_sgbrt.csv'

    Train_CV_SGBRT(dtpath,alg_name,dfilename_len).__init__(dtpath,alg_name,dfilename_len)
    Train_CV_SGBRT(dtpath,alg_name,dfilename_len).build()
    writer1.save()
    writer1.close()
    writer.save()
    writer.close()
    #train_cv_sgbrt.build_loop()