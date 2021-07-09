#!/usr/bin/env python
# coding: utf-8

# In[19]:


#Import Libraries 

import pandas as pd 
import seaborn as sns 
import numpy as np
import matplotlib
import matplotlib.pyplot as plt
plt.style.use('ggplot')
from matplotlib.pyplot import figure 

get_ipython().run_line_magic('matplotlib', 'inline')
matplotlib.rcParams['figure.figsize'] = (12,8) 

#Read in the data 

df = pd.read_csv(r'C:\Users\dao17\Downloads\movies.csv')
            


# In[16]:


#Let's look at the data 

df.head()


# In[20]:


#Let's see if there is any misssing data

for col in df.columns:
    pct_missing = np.mean(df[col].isnull())
    print('{} - {}%'. format(col,pct_missing))


# In[21]:


#Data types for our colunmns 

df.dtypes


# In[22]:


#Changing the data types for the columns 

df['budget'] = df['budget'].astype('int64')

df['gross'] = df['gross'].astype('int64')


# In[23]:


df


# In[24]:


#Create correct Year column

df['yearcorrect']= df['released'].astype(str).str[:4]
df


# In[33]:


df= df.sort_values(by = ['gross'], inplace=False, ascending=False)


# In[27]:


pd.set_option('display.max_rows', None)


# In[31]:


#Drop any duplicates

df['company'].drop_duplicates().sort_values(ascending=False)



# In[ ]:


#Budget high correlation
#Company high correlation


# In[34]:


#scatter plot with budget vs gross

plt.scatter(x=df['budget'], y=df['gross'])

plt.title('Budget vs Gross Earnings')

plt.xlabel('Gross Earnings')

plt.ylabel('Budget for Film')

plt.show


# In[36]:


#Plot the budget vs gross using seaborn

sns.regplot(x='budget', y='gross', data=df, scatter_kws={"color": "red"}, line_kws={"color":"blue"})


# In[37]:


#Let's start looking at correlation
 
df.corr(method='pearson')


# In[39]:


correlation_matrix = df.corr(method='pearson')

sns.heatmap(correlation_matrix, annot= True)

plt.title('Corrleation Matric for Numeric Features')

plt.xlabel('Movie Features')

plt.ylabel('Movie Features')

plt.show()


# In[40]:


#Looks at the company 

df.head()


# In[44]:


df_numerized = df

for col_name in df_numerized.columns:
    if(df_numerized[col_name].dtype == 'object'):
        df_numerized[col_name]= df_numerized[col_name].astype('category')
        df_numerized[col_name]= df_numerized[col_name].cat.codes
df_numerized


# In[ ]:


df


# In[45]:


correlation_matrix = df_numerized.corr(method='pearson')

sns.heatmap(correlation_matrix, annot= True)

plt.title('Corrleation Matric for Numeric Features')

plt.xlabel('Movie Features')

plt.ylabel('Movie Features')

plt.show()


# In[46]:


df_numerized.corr()


# In[48]:


correlation_mat = df_numerized.corr()

corr_pairs = correlation_mat.unstack()

corr_pairs


# In[51]:


sorted_pairs = corr_pairs.sort_values()

sorted_pairs


# In[52]:


high_corr = sorted_pairs[(sorted_pairs) > 0.5]

high_corr


# In[ ]:


#Votes and budget have the highest correlation to gross earning 
#Company hss the low correlation

