
# coding: utf-8

# In[16]:


from __future__ import print_function
import httplib2
import os

from apiclient import discovery
from oauth2client import client
from oauth2client import tools
from oauth2client.file import Storage

import datetime
from datetime import timezone
import dateutil.parser


# In[12]:

starttime = '2017-05-08T16:00:00-04:00'


# In[13]:

timenow = '2017-05-03T22:10:43.813367Z'


# In[14]:

t = datetime.datetime.strptime(timenow, "%Y-%m-%dT%H:%M:%S.%fZ")


# In[15]:

t


# In[17]:

dt = dateutil.parser.parse(starttime)


# In[18]:

dt


# In[21]:

dt2 = dateutil.parser.parse(timenow)


# In[22]:

dt2


# In[24]:

difference = dt- dt2


# In[30]:

t_delta = difference.__str__()


# In[37]:

difference.seconds


# In[39]:

s = difference.seconds
hours, remainder = divmod(s, 3600)
minutes, seconds = divmod(remainder, 60)
# print '%s:%s:%s' % (hours, minutes, seconds)
# result: 3:43:40


# In[41]:

hours > 1


# In[ ]:



