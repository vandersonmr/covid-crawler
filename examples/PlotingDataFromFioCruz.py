# Example of how to gather data from FioCruz API

import requests
import json
import pandas
import matplotlib.pyplot as plt
import numpy as np

from requests.auth import HTTPDigestAuth
from pandas import json_normalize
from pandas import DataFrame

base = 'https://bigdata-api.fiocruz.br/numero/casos/pais/'
endpoint = 'Brasil'
url = base + endpoint

# It is a good practice not to hardcode the credentials. So ask the user to enter credentials at runtime
# myResponse = requests.get(url,auth=HTTPDigestAuth(raw_input("username: "), raw_input("Password: ")), verify=True)

myResponse = requests.get(url, verify=True)

if(myResponse.ok):
    jData = json.loads(myResponse.content)
    data = json_normalize(jData)

    total_deaths = int(data['total_mortes'].values[0])
    total_cases = int(data['total_casos'].values[0])
    daily_details = data['detalhes_por_dia'].values[0]

    table_daily_details = json_normalize(daily_details)
    data_frame = DataFrame(table_daily_details)
    filtered_cases = data_frame.loc[data_frame['new_cases'] > 1000]

    # Plotting data directly
    plt.plot('new_cases', data=data_frame, color='red')
    plt.show()

else:
    myResponse.raise_for_status()