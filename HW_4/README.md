
Pymoli Analysis 

Observable Trend 1:
-Younger players make more and more purchases as they enter their early-twenties. As age increases, after their
 early twenties, players make fewer and fewer purchases.

Observable Trend 2: 
-Male users account for 81% of all sales.

Observable Trend 3:
-The most profitable items have price at about $4 while the most popular items are priced at about $2.



```python
import pandas as pd 

```

Total Number of Players


```python
gamedata = pd.read_json('purchase_data.json')
print('Number of Players: %s' %(str(len(gamedata['SN'].unique()))))

```

    Number of Players: 573


Purchasing Analysis (Total)


```python
Unique = str(len(gamedata['Item ID'].unique())) 
Average_Price = gamedata['Price'].mean()
Total_Purch = gamedata['Price'].count()
Revenue = gamedata['Price'].sum()
print('Number of Unique Items: %s\nAverage Purchase Price: %s\nTotal \
Number of Purchases: %s\nTotal Revenue: %s' %(Unique, '{:00.2f}'.format(Average_Price),Total_Purch,\
                                              '{:06.2f}'.format(Revenue)))

```

    Number of Unique Items: 183
    Average Purchase Price: 2.93
    Total Number of Purchases: 780
    Total Revenue: 2286.33


Gender Demographics 


```python
Male = len(gamedata.loc[gamedata['Gender'] == 'Male', :])
Female = len(gamedata.loc[gamedata['Gender'] == 'Female', :])
Other = len(gamedata.loc[gamedata['Gender'] == 'Other / Non-Disclosed', :])
Total = len(gamedata['Gender'])

print('Males: (%s%%) %s' %('{:00.2f}'.format(((Male / Total)*100)), Male))
print('Females: (%s%%) %s' %('{:00.2f}'.format(((Female / Total)*100)), Female))
print('Other/Non-Disclosed: (%s%%) %s' %('{:00.2f}'.format(((Other / Total)*100)), Other))
```

    Males: (81.15%) 633
    Females: (17.44%) 136
    Other/Non-Disclosed: (1.41%) 11


Purchasing Analysis (Gender)


```python
# Create group object
genderpivot = gamedata.groupby(['Gender'])

#Create DFs for for the different price aggregations(count, mean, sum)
purchases = pd.DataFrame(genderpivot['Price'].count())
avgpurch = pd.DataFrame(genderpivot['Price'].mean())
totalpurch = pd.DataFrame(genderpivot['Price'].sum())

#Give DFs appropriate column names
purchases.columns = ['Purchase Count']
avgpurch.columns = ['Average Purchase Price']
totalpurch.columns = ['Total Purchase Value']

#Apply formatting to Average Purchase Price column to remove extra decimal places
avgpurch['Average Purchase Price'] = avgpurch['Average Purchase Price'].apply('{:00.2f}'.format)

#Merge all of the DFs by their index 
merge1 = pd.merge(purchases, avgpurch, left_index=True, right_index=True)
pd.merge(merge1, totalpurch, left_index=True, right_index=True)

```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Purchase Count</th>
      <th>Average Purchase Price</th>
      <th>Total Purchase Value</th>
    </tr>
    <tr>
      <th>Gender</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Female</th>
      <td>136</td>
      <td>2.82</td>
      <td>382.91</td>
    </tr>
    <tr>
      <th>Male</th>
      <td>633</td>
      <td>2.95</td>
      <td>1867.68</td>
    </tr>
    <tr>
      <th>Other / Non-Disclosed</th>
      <td>11</td>
      <td>3.25</td>
      <td>35.74</td>
    </tr>
  </tbody>
</table>
</div>



Age Demographics


```python

#Create bins and groups for binning 
bins = [0,10,14,19,24,29,34,39,100]
groups = ['<10','10-14','15-19', '20-24', '25-29', '30-34', '35-39', '>40']

#Add new bin column to main dataset 
gamedata['Age Groups'] = pd.cut(gamedata['Age'], bins, labels = groups)

#Group main dataset by new bin column
agegroup = gamedata.groupby(['Age Groups'])

#Create DFs that aggregate group object by count, mean, sum
purchases = pd.DataFrame(agegroup['Price'].count())
avgpurch = pd.DataFrame(agegroup['Price'].mean())
totalpurch = pd.DataFrame(agegroup['Price'].sum())

#Give columns appropriate names
purchases.columns = ['Purchase Count']
avgpurch.columns = ['Average Purchase Price']
totalpurch.columns = ['Total Purchase Value']

#Apply formatting to Average Purchase Price column to remove extra decimal places
avgpurch['Average Purchase Price'] = avgpurch['Average Purchase Price'].apply('{:00.2f}'.format)

#Merge all of the DFs by their index 
merge1 = pd.merge(purchases, avgpurch, left_index=True, right_index=True)
pd.merge(merge1, totalpurch, left_index=True, right_index=True)
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Purchase Count</th>
      <th>Average Purchase Price</th>
      <th>Total Purchase Value</th>
    </tr>
    <tr>
      <th>Age Groups</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>&lt;10</th>
      <td>32</td>
      <td>3.02</td>
      <td>96.62</td>
    </tr>
    <tr>
      <th>10-14</th>
      <td>31</td>
      <td>2.70</td>
      <td>83.79</td>
    </tr>
    <tr>
      <th>15-19</th>
      <td>133</td>
      <td>2.91</td>
      <td>386.42</td>
    </tr>
    <tr>
      <th>20-24</th>
      <td>336</td>
      <td>2.91</td>
      <td>978.77</td>
    </tr>
    <tr>
      <th>25-29</th>
      <td>125</td>
      <td>2.96</td>
      <td>370.33</td>
    </tr>
    <tr>
      <th>30-34</th>
      <td>64</td>
      <td>3.08</td>
      <td>197.25</td>
    </tr>
    <tr>
      <th>35-39</th>
      <td>42</td>
      <td>2.84</td>
      <td>119.40</td>
    </tr>
    <tr>
      <th>&gt;40</th>
      <td>17</td>
      <td>3.16</td>
      <td>53.75</td>
    </tr>
  </tbody>
</table>
</div>



Top Spenders


```python
#Group by 'SN'
topspenders = gamedata.groupby(['SN'])

#Aggregate groupings by sum
top = pd.DataFrame(topspenders.sum())

#Sort Price column so that top spenders are first five rows
top = top.sort_values('Price', ascending = False )

#top5 is dataframe with the top 5 spenders and the amount they spent
top5 = top.iloc[0:5, 2] 

#Create DFs to calculate top spenders average purchases and number of purchases
average = pd.DataFrame(topspenders['Price'].mean())
items = pd.DataFrame(topspenders['Price'].count())

#Use the top5 object to index the above DFs and find the top spenders' purchases and number of purchases
average = average.loc[top5.index, :]
items = items.loc[top5.index, :]
top5 = pd.DataFrame(top5)

#Give columns appropriate names
items.columns = ['Purchase Count']
average.columns = ['Average Purchase Price']
top5.columns = ['Total Purchase Value']

#Apply formatting to Average Purchase Price column to remove extra decimal places
average['Average Purchase Price'] = average['Average Purchase Price'].apply('{:00.2f}'.format)

#Merge all of the DFs by their index 
merge1 = pd.merge(items, average ,left_index=True, right_index=True)
pd.merge(merge1, top5, left_index=True, right_index=True)

```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Purchase Count</th>
      <th>Average Purchase Price</th>
      <th>Total Purchase Value</th>
    </tr>
    <tr>
      <th>SN</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Undirrala66</th>
      <td>5</td>
      <td>3.41</td>
      <td>17.06</td>
    </tr>
    <tr>
      <th>Saedue76</th>
      <td>4</td>
      <td>3.39</td>
      <td>13.56</td>
    </tr>
    <tr>
      <th>Mindimnya67</th>
      <td>4</td>
      <td>3.18</td>
      <td>12.74</td>
    </tr>
    <tr>
      <th>Haellysu29</th>
      <td>3</td>
      <td>4.24</td>
      <td>12.73</td>
    </tr>
    <tr>
      <th>Eoda93</th>
      <td>3</td>
      <td>3.86</td>
      <td>11.58</td>
    </tr>
  </tbody>
</table>
</div>



Most Popular Items


```python
#Group data by Item ID
top_items = gamedata.groupby(['Item ID'])

#Create data frame that aggregates group object by count
itemdf = pd.DataFrame(top_items['Price'].count())

#Sort the DF to see the most popular items
itemdf_sorted = itemdf.sort_values('Price', ascending = False)

#Top5 is a DF with top five most popular items and their names
Top5 = pd.DataFrame(itemdf_sorted.iloc[0:5, :])
Top5.columns = ['Purchase Count']


#This section of code searches for all the rows in the orginal data set \
#whose Item ID is one of the top 5 and returns a DF. The DF is then set to\
#remove duplicates, getting rid of the all of the duplicate Item ID rows.\
#Then the DF's index is set to be the Item ID for easy merging later on.
ndata = gamedata.loc[gamedata['Item ID'].isin(Top5.index), ['Item ID','Price', 'Item Name',]]
price_name = ndata.drop_duplicates(subset = 'Item ID')
price_name = price_name.reset_index(drop = True)
price_name = price_name.set_index('Item ID')


#This DF is the group object aggregated by sum and is used to find the Total Purchase value
revdf = pd.DataFrame(top_items['Price'].sum())

#The revdf is then reduced to just have the rows of the most popular items
revdf = revdf.loc[revdf.index.isin(Top5.index), ['Price']]
revdf.columns = ['Total Purchase Value']

#All of the DFs are merged and then the columns are put in their proper order
merge1 = pd.merge(Top5, price_name ,left_index=True, right_index=True)
answer = pd.merge(merge1, revdf, left_index=True, right_index=True)
answer = answer[['Item Name', 'Purchase Count', 'Price', 'Total Purchase Value']]
answer

```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Item Name</th>
      <th>Purchase Count</th>
      <th>Price</th>
      <th>Total Purchase Value</th>
    </tr>
    <tr>
      <th>Item ID</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>39</th>
      <td>Betrayal, Whisper of Grieving Widows</td>
      <td>11</td>
      <td>2.35</td>
      <td>25.85</td>
    </tr>
    <tr>
      <th>84</th>
      <td>Arcane Gem</td>
      <td>11</td>
      <td>2.23</td>
      <td>24.53</td>
    </tr>
    <tr>
      <th>31</th>
      <td>Trickster</td>
      <td>9</td>
      <td>2.07</td>
      <td>18.63</td>
    </tr>
    <tr>
      <th>175</th>
      <td>Woeful Adamantite Claymore</td>
      <td>9</td>
      <td>1.24</td>
      <td>11.16</td>
    </tr>
    <tr>
      <th>13</th>
      <td>Serenity</td>
      <td>9</td>
      <td>1.49</td>
      <td>13.41</td>
    </tr>
  </tbody>
</table>
</div>



Most Profitable Items


```python
#This script is the same as the one above. The only differences are the \
#group object is aggregated by sum in the beginning instead of count and \
#later in the script a count aggregated group object is used instead of a sum aggregated group object.

top_items = gamedata.groupby(['Item ID'])

itemdf = pd.DataFrame(top_items['Price'].sum())
itemdf_sorted = itemdf.sort_values('Price', ascending = False)

Top5 = pd.DataFrame(itemdf_sorted.iloc[0:5, :])
Top5.columns = ['Total Purchase Value']

ndata = gamedata.loc[gamedata['Item ID'].isin(Top5.index), ['Item ID','Price', 'Item Name',]]
price_name = ndata.drop_duplicates(subset = 'Item ID')
price_name = price_name.reset_index(drop = True)
price_name = price_name.set_index('Item ID')

countdf = pd.DataFrame(top_items['Price'].count())
countdf = countdf.loc[countdf.index.isin(Top5.index), ['Price']]
countdf.columns = ['Purchase Count']

merge1 = pd.merge(Top5, price_name ,left_index=True, right_index=True)
answer = pd.merge(merge1, countdf, left_index=True, right_index=True)
answer = answer[['Item Name', 'Purchase Count', 'Price', 'Total Purchase Value']]
answer 

```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Item Name</th>
      <th>Purchase Count</th>
      <th>Price</th>
      <th>Total Purchase Value</th>
    </tr>
    <tr>
      <th>Item ID</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>34</th>
      <td>Retribution Axe</td>
      <td>9</td>
      <td>4.14</td>
      <td>37.26</td>
    </tr>
    <tr>
      <th>115</th>
      <td>Spectral Diamond Doomblade</td>
      <td>7</td>
      <td>4.25</td>
      <td>29.75</td>
    </tr>
    <tr>
      <th>32</th>
      <td>Orenmir</td>
      <td>6</td>
      <td>4.95</td>
      <td>29.70</td>
    </tr>
    <tr>
      <th>103</th>
      <td>Singed Scalpel</td>
      <td>6</td>
      <td>4.87</td>
      <td>29.22</td>
    </tr>
    <tr>
      <th>107</th>
      <td>Splitter, Foe Of Subtlety</td>
      <td>8</td>
      <td>3.61</td>
      <td>28.88</td>
    </tr>
  </tbody>
</table>
</div>


