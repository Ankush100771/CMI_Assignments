# CLASSIFICATION MODELS ON THE “BANK MARKETING DATA SET” 

#### INTRODUCTION: 
<ul>
In this project, we have been provided a secondary dataset given -
“BANK MARKETING DATA SET” obtained from the UCI Machine
Learning Repository. It is related with direct marketing campaigns
(phone calls) of a Portuguese banking institution.
The classification goal is to predict if the client will subscribe a term
deposit (variable y).\
We have built three classifiers for this data set: a decision tree, a
naïve Bayes classifier, and a random forest and done a comparative
study of their performances using F-score as the primary evaluation
metric since the dataset is highly skewed.
</ul>

#### EXPLORATORY DATA ANALYSIS:
<ul>
<li> We have used barplots to visualize the categorical variables (including the binary outcome variable ‘y’) of the dataset and histograms to visualize the numerical variables.</li>
<li> From the barplot for ‘y’ we find that the data is highly imbalanced since the number of ‘yes’s is much lesser than the number of ‘no’s. Hence, F1-score,which balances the precisionrecall trade-off, will be a much better evaluation metric than Accuracy.</li>
<li> We have also found that the variables ‘default’ and ‘pdays’ as the former contained high number of unknown samples and the latter contained high number of null samples.</li>
</ul>

#### Data pre-processing
<u> For Decision Tree and Random Forest classifiers,</u>
<li> Since we have visualized that the variables ‘default’ and ‘pdays’
did not play such an important role in predicting the outcome
variable ‘y’, we have dropped them from our training and test
sets.</li>
<li> We have removed the ‘unknown’s in the categorical variables
with the maximum value of that feature variable.</li>
<li> We have labelled the ordinal features using a labelling
dictionary.</li>
<li> We have used One Hot Encoding to label the nominal features.</li>
<li> The numerical variables have also been normalized using
MinMaxScaler.</li>
<u> For,Naïve Bayes, </u>

<li> We have performed outlier detection using EDA and replaced
the outliers of the corresponding columns(‘campaign’,
’duration’ and ‘previous’) with the means of the respective
features.</li>
<li> All the other pre-processing steps are same, except instead of
labelling the ordinal and nominal features separately, we have
used get_dummies() of pandas to label the categorical
variables.</li>

#### COMPARITIVE STUDY OF THE THREE CLASSIFIERS:
<table style="width:100%">
  <tr>
    <th>       </th>
    <th>Decision tree</th>
    <th>Naive Bayes</th>
    <th>Random Forest</th>
  </tr>
  
  <tr>
    <td>Accuracy</td>
    <td>89.71%</td>
    <td>86.38%</td>
    <td>90.51%</td>
  </tr>
  <tr>
    <td>Precision</td>
    <td>50.09%</td>
    <td>41.90%</td>
    <td>56.13%</td>
  </tr>
  <tr>
    <td>F1 Score</td>
    <td>74.14%</td>
    <td>54.72%</td>
    <td>71.98%</td>
  </tr>
  <tr>
    <td>Time Taken</td>
    <td>6.71 sec</td>
    <td>2.23 sec</td>
    <td>5.10 sec</td>
  </tr>
  <tr>
    <td>Memory space taken</td>
    <td>4.06 MiB</td>
    <td>15.92 MiB</td>
    <td>49.50 MiB</td>
  </tr>
</table>


