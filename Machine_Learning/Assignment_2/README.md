# Machine Learning Assignment 2
### Process
<li>I started by exporting all the necessary libraries. Then we read and processed the text files </li>
<li>I then used numpy and a for loop to create a sparse matrix where the wordIDs were the rows and the docIDs the columns. I did this manually. </li>
<li>Then using the inbuilt python function pairwise distance we calculated the jaccard index and after subtracting it from one we got the jaccard similarity
  matrix to get a square matrix with dimension the number of unique docIds. </li>
<li>From the library sklearn we utilised the inbuilt kmeans function. We ran a for
loop and found out the inertia for a range of k values. On plotting the inertia
for all these different kmeans we found the best fit (Elbow Method) </li>
<li>We reduced the dimension of the Jaccard Matrix using PCA and then plotted
the subsequent points which helped in visualising the clusters. </li>

### Remarks
<li>NIPS DATASET : This dataset had approximately 1500 documents and
12419 unique words in the vocabulary. The dataset was not very huge
and ran smoothly. The time taken to run the entire algorithm was 50
secs. According to the graph of the different values of inertia k=4 would
give the best fit. </li>
<li>KOS DATASET: This was a relatively small dataset with 3430
documents and 6906 unique words. The process to generate the
optimal value of the number of clusters was the same as that of the
NIPS dataset. The best value for k was 2 according to the elbow
method. The time complexity for this program was 59 secs. </li>
<li>ENRON DATASET: This dataset was vast and huge. It had
approximately 39861 documents and 28102 unique words. It was
impossible to use the earlier method on the dataset without optimising
it. So we reduced the dataset by taking stratified sampling. So here we
have multiple stratas o based on the frequency of the word. On thisreduced dataset we used the same procedure to get the jaccard
similarity matrix and then the kmeans clustering. This dataset was
huge and our laptops stopped working a few times in between, so it
takes much higher time to solve the dataset. The process to generate
the optimal value of the number of clusters was the same as that of the
NIPS dataset. The best value for k was 3 according to the elbow
method. </li>
###results
<table style="width:100%">
  <tr>
    <th>       </th>
    <th>Nips</th>
    <th>KOS</th>
    <th>ENRON</th>
  </tr>
  <tr>
    <td>Time Taken</td>
    <td>50 sec</td>
    <td>81 sec</td>
    <td>3401 sec</td>
  </tr>
  <tr>
    <td>Memory Used</td>
    <td>341 MiB</td>
    <td>880 MiB</td>
    <td>4446 MiB</td>
  </tr>
</table>
