
Trends:
1. Temperature increases across the world as you approach the equator. In March, the rate of temperature increase is greater in the Northern Hemisphere.
2. On average humidity levels rise as you approach the equator.
3. Cloudiness and wind speed are independent of latitude.


```python
from citipy import citipy
import random 
import requests
import pandas as pd
import matplotlib.pyplot as plt
from config import api_key

#cities list will store the names of 700 cities whose longitude and latitude have been randomly selected
cities = []
#lat collects the latitudes of the cities
lat = []
#lng collects the longitudes of the cities
lng = []
#temp collects the current temperatutes of cities
temp = []
#humidity collects the current humidity of cities
humidity = []
#wspeed collects the current wind speed in cities
wspeed = []
#cloudiness collects the current cloudiness in cities
cloudiness = []

#randomly select a longitude and latitude and find the nearest city to this value, append city to cities list
#also append latitude and longitude to respective lists
#loop through 700 times to make sure at least 500 cities are included in graphs

for i in range(700):
    latitude = random.uniform(-90, 90)
    longitude = random.uniform(-180,180)
    
    city = citipy.nearest_city(float("{0:.2f}".format(latitude)), float("{0:.2f}".format(longitude)) )
    cities.append(city.city_name)
    
    lat.append("{0:.2f}".format(latitude))
    lng.append("{0:.2f}".format(longitude))

#this is the API that will be searched for weather data
url = "http://api.openweathermap.org/data/2.5/weather?"

#this variable is used to print the number of cities that have been searched
num = 1

print("Beginning Data Retrieval\n----------------------")

#this loops through 700 randomly selected cities and makes an API request to openweathermap for each city
#the json object that is returned is indexed to find the relevant weather data

for city in cities:
    query_url = '{0}appid={1}&q={2}&units=Imperial'.format(url,api_key,city)
    weather_response = requests.get(query_url)
    weather_json = weather_response.json()
    
    print("Processing Record {0} | {1}".format(num, city))
    print(query_url)
    
    #this try/except block is used to account for cities that openweather does not recognize
    try:
        temp.append(weather_json['main']['temp'])
        humidity.append(weather_json['main']['humidity'])
        wspeed.append(weather_json['wind']['speed'])
        cloudiness.append(weather_json['clouds']['all'])
        num += 1
    except KeyError:
        print("City not found")
        temp.append('NA')
        humidity.append('NA')
        wspeed.append('NA')
        cloudiness.append('NA')
        num += 1
        
print("-----------------------------\nData Retrieval Complete")

#all the above lists are combined into one dataframe that can be used for graphing weather data
weatherDF = pd.DataFrame({'Cities': cities, 'Temp': temp, 'Humidity': humidity, "Wind Speed": wspeed, 'Cloudiness':cloudiness, 'Latitude': lat, 'Longitude': lng})

#this removes all of the rows in the dataframe that are missing information
weatherDF = weatherDF.loc[weatherDF.loc[:, 'Temp'] != 'NA', :]

#create csv of data
weatherDF.to_csv('City_Weather_Data')

#display number of rows in new dataframe
weatherDF.count()
```

    Beginning Data Retrieval
    ----------------------
    Processing Record 1 | quatre cocos
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=quatre cocos&units=Imperial
    Processing Record 2 | ushuaia
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=ushuaia&units=Imperial
    Processing Record 3 | georgetown
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=georgetown&units=Imperial
    Processing Record 4 | dikson
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=dikson&units=Imperial
    Processing Record 5 | butaritari
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=butaritari&units=Imperial
    Processing Record 6 | puerto ayora
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=puerto ayora&units=Imperial
    Processing Record 7 | kondinskoye
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=kondinskoye&units=Imperial
    Processing Record 8 | indianola
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=indianola&units=Imperial
    Processing Record 9 | rikitea
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=rikitea&units=Imperial
    Processing Record 10 | taolanaro
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=taolanaro&units=Imperial
    City not found
    Processing Record 11 | caravelas
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=caravelas&units=Imperial
    Processing Record 12 | ushuaia
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=ushuaia&units=Imperial
    Processing Record 13 | qaanaaq
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=qaanaaq&units=Imperial
    Processing Record 14 | uribia
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=uribia&units=Imperial
    Processing Record 15 | ruatoria
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=ruatoria&units=Imperial
    City not found
    Processing Record 16 | katsuura
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=katsuura&units=Imperial
    Processing Record 17 | attawapiskat
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=attawapiskat&units=Imperial
    City not found
    Processing Record 18 | kizukuri
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=kizukuri&units=Imperial
    Processing Record 19 | belushya guba
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=belushya guba&units=Imperial
    City not found
    Processing Record 20 | illoqqortoormiut
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=illoqqortoormiut&units=Imperial
    City not found
    Processing Record 21 | atuona
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=atuona&units=Imperial
    Processing Record 22 | sitionuevo
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=sitionuevo&units=Imperial
    Processing Record 23 | ushuaia
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=ushuaia&units=Imperial
    Processing Record 24 | haines junction
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=haines junction&units=Imperial
    Processing Record 25 | saint-pierre
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=saint-pierre&units=Imperial
    Processing Record 26 | chokurdakh
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=chokurdakh&units=Imperial
    Processing Record 27 | albany
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=albany&units=Imperial
    Processing Record 28 | hobyo
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=hobyo&units=Imperial
    Processing Record 29 | adrar
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=adrar&units=Imperial
    Processing Record 30 | sinnamary
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=sinnamary&units=Imperial
    Processing Record 31 | atuona
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=atuona&units=Imperial
    Processing Record 32 | mataura
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=mataura&units=Imperial
    Processing Record 33 | sept-iles
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=sept-iles&units=Imperial
    Processing Record 34 | coahuayana
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=coahuayana&units=Imperial
    Processing Record 35 | olutanga
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=olutanga&units=Imperial
    Processing Record 36 | vaini
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=vaini&units=Imperial
    Processing Record 37 | maniitsoq
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=maniitsoq&units=Imperial
    Processing Record 38 | tuktoyaktuk
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=tuktoyaktuk&units=Imperial
    Processing Record 39 | leningradskiy
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=leningradskiy&units=Imperial
    Processing Record 40 | castro
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=castro&units=Imperial
    Processing Record 41 | thompson
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=thompson&units=Imperial
    Processing Record 42 | lengshuitan
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=lengshuitan&units=Imperial
    Processing Record 43 | kropotkin
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=kropotkin&units=Imperial
    Processing Record 44 | ushuaia
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=ushuaia&units=Imperial
    Processing Record 45 | kamenka
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=kamenka&units=Imperial
    Processing Record 46 | gravelbourg
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=gravelbourg&units=Imperial
    Processing Record 47 | waipawa
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=waipawa&units=Imperial
    Processing Record 48 | anastacio
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=anastacio&units=Imperial
    Processing Record 49 | tetouan
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=tetouan&units=Imperial
    Processing Record 50 | bur gabo
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=bur gabo&units=Imperial
    City not found
    Processing Record 51 | dingle
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=dingle&units=Imperial
    Processing Record 52 | kapaa
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=kapaa&units=Imperial
    Processing Record 53 | georgetown
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=georgetown&units=Imperial
    Processing Record 54 | sturgis
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=sturgis&units=Imperial
    Processing Record 55 | rikitea
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=rikitea&units=Imperial
    Processing Record 56 | tiksi
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=tiksi&units=Imperial
    Processing Record 57 | balkhash
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=balkhash&units=Imperial
    Processing Record 58 | alta floresta
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=alta floresta&units=Imperial
    Processing Record 59 | vila do maio
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=vila do maio&units=Imperial
    Processing Record 60 | moen
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=moen&units=Imperial
    Processing Record 61 | puerto ayora
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=puerto ayora&units=Imperial
    Processing Record 62 | narsaq
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=narsaq&units=Imperial
    Processing Record 63 | kieta
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=kieta&units=Imperial
    Processing Record 64 | tuktoyaktuk
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=tuktoyaktuk&units=Imperial
    Processing Record 65 | port elizabeth
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=port elizabeth&units=Imperial
    Processing Record 66 | tomigusuku
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=tomigusuku&units=Imperial
    Processing Record 67 | marzuq
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=marzuq&units=Imperial
    Processing Record 68 | latung
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=latung&units=Imperial
    Processing Record 69 | georgetown
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=georgetown&units=Imperial
    Processing Record 70 | san luis
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=san luis&units=Imperial
    Processing Record 71 | mahebourg
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=mahebourg&units=Imperial
    Processing Record 72 | avarua
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=avarua&units=Imperial
    Processing Record 73 | devils lake
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=devils lake&units=Imperial
    Processing Record 74 | arman
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=arman&units=Imperial
    Processing Record 75 | rikitea
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=rikitea&units=Imperial
    Processing Record 76 | yerbogachen
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=yerbogachen&units=Imperial
    Processing Record 77 | severo-kurilsk
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=severo-kurilsk&units=Imperial
    Processing Record 78 | ancud
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=ancud&units=Imperial
    Processing Record 79 | cherskiy
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=cherskiy&units=Imperial
    Processing Record 80 | punta arenas
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=punta arenas&units=Imperial
    Processing Record 81 | parrita
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=parrita&units=Imperial
    Processing Record 82 | luderitz
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=luderitz&units=Imperial
    Processing Record 83 | cabo san lucas
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=cabo san lucas&units=Imperial
    Processing Record 84 | tsihombe
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=tsihombe&units=Imperial
    City not found
    Processing Record 85 | taolanaro
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=taolanaro&units=Imperial
    City not found
    Processing Record 86 | upernavik
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=upernavik&units=Imperial
    Processing Record 87 | cheney
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=cheney&units=Imperial
    Processing Record 88 | vestmannaeyjar
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=vestmannaeyjar&units=Imperial
    Processing Record 89 | half moon bay
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=half moon bay&units=Imperial
    Processing Record 90 | bredasdorp
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=bredasdorp&units=Imperial
    Processing Record 91 | jamestown
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=jamestown&units=Imperial
    Processing Record 92 | busselton
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=busselton&units=Imperial
    Processing Record 93 | castro
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=castro&units=Imperial
    Processing Record 94 | bonthe
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=bonthe&units=Imperial
    Processing Record 95 | kapaa
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=kapaa&units=Imperial
    Processing Record 96 | saldanha
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=saldanha&units=Imperial
    Processing Record 97 | georgetown
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=georgetown&units=Imperial
    Processing Record 98 | busselton
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=busselton&units=Imperial
    Processing Record 99 | bardiyah
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=bardiyah&units=Imperial
    City not found
    Processing Record 100 | cidreira
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=cidreira&units=Imperial
    Processing Record 101 | colares
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=colares&units=Imperial
    Processing Record 102 | flic en flac
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=flic en flac&units=Imperial
    Processing Record 103 | busselton
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=busselton&units=Imperial
    Processing Record 104 | atuona
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=atuona&units=Imperial
    Processing Record 105 | sentyabrskiy
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=sentyabrskiy&units=Imperial
    City not found
    Processing Record 106 | verkhnetulomskiy
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=verkhnetulomskiy&units=Imperial
    Processing Record 107 | tumannyy
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=tumannyy&units=Imperial
    City not found
    Processing Record 108 | khatanga
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=khatanga&units=Imperial
    Processing Record 109 | bredasdorp
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=bredasdorp&units=Imperial
    Processing Record 110 | praia da vitoria
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=praia da vitoria&units=Imperial
    Processing Record 111 | saint george
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=saint george&units=Imperial
    Processing Record 112 | sao filipe
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=sao filipe&units=Imperial
    Processing Record 113 | hermanus
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=hermanus&units=Imperial
    Processing Record 114 | bethel
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=bethel&units=Imperial
    Processing Record 115 | komsomolskiy
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=komsomolskiy&units=Imperial
    Processing Record 116 | vaini
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=vaini&units=Imperial
    Processing Record 117 | narsaq
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=narsaq&units=Imperial
    Processing Record 118 | rikitea
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=rikitea&units=Imperial
    Processing Record 119 | hobart
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=hobart&units=Imperial
    Processing Record 120 | balimo
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=balimo&units=Imperial
    City not found
    Processing Record 121 | nanortalik
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=nanortalik&units=Imperial
    Processing Record 122 | hobart
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=hobart&units=Imperial
    Processing Record 123 | ushuaia
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=ushuaia&units=Imperial
    Processing Record 124 | pathankot
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=pathankot&units=Imperial
    Processing Record 125 | arraial do cabo
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=arraial do cabo&units=Imperial
    Processing Record 126 | kirakira
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=kirakira&units=Imperial
    Processing Record 127 | ilulissat
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=ilulissat&units=Imperial
    Processing Record 128 | bluff
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=bluff&units=Imperial
    Processing Record 129 | kupang
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=kupang&units=Imperial
    Processing Record 130 | saleaula
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=saleaula&units=Imperial
    City not found
    Processing Record 131 | hobart
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=hobart&units=Imperial
    Processing Record 132 | launceston
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=launceston&units=Imperial
    Processing Record 133 | puerto ayora
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=puerto ayora&units=Imperial
    Processing Record 134 | iqaluit
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=iqaluit&units=Imperial
    Processing Record 135 | port elizabeth
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=port elizabeth&units=Imperial
    Processing Record 136 | north platte
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=north platte&units=Imperial
    Processing Record 137 | kamenskoye
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=kamenskoye&units=Imperial
    City not found
    Processing Record 138 | svistov
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=svistov&units=Imperial
    City not found
    Processing Record 139 | karratha
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=karratha&units=Imperial
    Processing Record 140 | marcona
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=marcona&units=Imperial
    City not found
    Processing Record 141 | cidreira
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=cidreira&units=Imperial
    Processing Record 142 | coxim
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=coxim&units=Imperial
    Processing Record 143 | taolanaro
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=taolanaro&units=Imperial
    City not found
    Processing Record 144 | hobart
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=hobart&units=Imperial
    Processing Record 145 | bubaque
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=bubaque&units=Imperial
    Processing Record 146 | chuy
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=chuy&units=Imperial
    Processing Record 147 | east london
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=east london&units=Imperial
    Processing Record 148 | colon
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=colon&units=Imperial
    Processing Record 149 | thiers
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=thiers&units=Imperial
    Processing Record 150 | taolanaro
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=taolanaro&units=Imperial
    City not found
    Processing Record 151 | hermanus
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=hermanus&units=Imperial
    Processing Record 152 | palu
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=palu&units=Imperial
    Processing Record 153 | barentsburg
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=barentsburg&units=Imperial
    City not found
    Processing Record 154 | rikitea
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=rikitea&units=Imperial
    Processing Record 155 | qaanaaq
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=qaanaaq&units=Imperial
    Processing Record 156 | punta arenas
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=punta arenas&units=Imperial
    Processing Record 157 | avarua
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=avarua&units=Imperial
    Processing Record 158 | hilo
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=hilo&units=Imperial
    Processing Record 159 | airai
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=airai&units=Imperial
    Processing Record 160 | chokurdakh
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=chokurdakh&units=Imperial
    Processing Record 161 | sibolga
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=sibolga&units=Imperial
    Processing Record 162 | punta arenas
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=punta arenas&units=Imperial
    Processing Record 163 | uruguaiana
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=uruguaiana&units=Imperial
    Processing Record 164 | hermanus
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=hermanus&units=Imperial
    Processing Record 165 | mataura
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=mataura&units=Imperial
    Processing Record 166 | jamestown
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=jamestown&units=Imperial
    Processing Record 167 | victoria
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=victoria&units=Imperial
    Processing Record 168 | illoqqortoormiut
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=illoqqortoormiut&units=Imperial
    City not found
    Processing Record 169 | nouadhibou
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=nouadhibou&units=Imperial
    Processing Record 170 | hilo
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=hilo&units=Imperial
    Processing Record 171 | buala
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=buala&units=Imperial
    Processing Record 172 | ulladulla
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=ulladulla&units=Imperial
    Processing Record 173 | bonfim
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=bonfim&units=Imperial
    Processing Record 174 | mar del plata
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=mar del plata&units=Imperial
    Processing Record 175 | bermejillo
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=bermejillo&units=Imperial
    Processing Record 176 | puerto ayora
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=puerto ayora&units=Imperial
    Processing Record 177 | paamiut
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=paamiut&units=Imperial
    Processing Record 178 | narsaq
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=narsaq&units=Imperial
    Processing Record 179 | kapaa
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=kapaa&units=Imperial
    Processing Record 180 | talnakh
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=talnakh&units=Imperial
    Processing Record 181 | dwarka
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=dwarka&units=Imperial
    Processing Record 182 | mataura
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=mataura&units=Imperial
    Processing Record 183 | saskylakh
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=saskylakh&units=Imperial
    Processing Record 184 | barrow
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=barrow&units=Imperial
    Processing Record 185 | ushuaia
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=ushuaia&units=Imperial
    Processing Record 186 | utete
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=utete&units=Imperial
    Processing Record 187 | ribeira grande
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=ribeira grande&units=Imperial
    Processing Record 188 | carnarvon
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=carnarvon&units=Imperial
    Processing Record 189 | rikitea
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=rikitea&units=Imperial
    Processing Record 190 | esperance
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=esperance&units=Imperial
    Processing Record 191 | lima
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=lima&units=Imperial
    Processing Record 192 | puerto ayora
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=puerto ayora&units=Imperial
    Processing Record 193 | soyo
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=soyo&units=Imperial
    Processing Record 194 | rikitea
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=rikitea&units=Imperial
    Processing Record 195 | tucumcari
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=tucumcari&units=Imperial
    Processing Record 196 | dikson
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=dikson&units=Imperial
    Processing Record 197 | carnarvon
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=carnarvon&units=Imperial
    Processing Record 198 | saint-francois
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=saint-francois&units=Imperial
    Processing Record 199 | muroto
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=muroto&units=Imperial
    Processing Record 200 | lemesos
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=lemesos&units=Imperial
    City not found
    Processing Record 201 | avarua
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=avarua&units=Imperial
    Processing Record 202 | port hedland
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=port hedland&units=Imperial
    Processing Record 203 | camocim
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=camocim&units=Imperial
    Processing Record 204 | aldan
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=aldan&units=Imperial
    Processing Record 205 | deputatskiy
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=deputatskiy&units=Imperial
    Processing Record 206 | ushuaia
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=ushuaia&units=Imperial
    Processing Record 207 | bubaque
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=bubaque&units=Imperial
    Processing Record 208 | busselton
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=busselton&units=Imperial
    Processing Record 209 | punta arenas
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=punta arenas&units=Imperial
    Processing Record 210 | laguna
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=laguna&units=Imperial
    Processing Record 211 | bethel
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=bethel&units=Imperial
    Processing Record 212 | east london
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=east london&units=Imperial
    Processing Record 213 | mataura
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=mataura&units=Imperial
    Processing Record 214 | yar-sale
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=yar-sale&units=Imperial
    Processing Record 215 | port elizabeth
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=port elizabeth&units=Imperial
    Processing Record 216 | vestmannaeyjar
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=vestmannaeyjar&units=Imperial
    Processing Record 217 | norman wells
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=norman wells&units=Imperial
    Processing Record 218 | talnakh
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=talnakh&units=Imperial
    Processing Record 219 | talara
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=talara&units=Imperial
    Processing Record 220 | klaksvik
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=klaksvik&units=Imperial
    Processing Record 221 | cherskiy
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=cherskiy&units=Imperial
    Processing Record 222 | hobart
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=hobart&units=Imperial
    Processing Record 223 | belushya guba
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=belushya guba&units=Imperial
    City not found
    Processing Record 224 | barentsburg
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=barentsburg&units=Imperial
    City not found
    Processing Record 225 | grand gaube
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=grand gaube&units=Imperial
    Processing Record 226 | illoqqortoormiut
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=illoqqortoormiut&units=Imperial
    City not found
    Processing Record 227 | flinders
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=flinders&units=Imperial
    Processing Record 228 | atuona
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=atuona&units=Imperial
    Processing Record 229 | udachnyy
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=udachnyy&units=Imperial
    Processing Record 230 | sorland
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=sorland&units=Imperial
    Processing Record 231 | caconda
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=caconda&units=Imperial
    Processing Record 232 | olafsvik
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=olafsvik&units=Imperial
    City not found
    Processing Record 233 | provideniya
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=provideniya&units=Imperial
    Processing Record 234 | mahebourg
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=mahebourg&units=Imperial
    Processing Record 235 | bowen
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=bowen&units=Imperial
    Processing Record 236 | victoria
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=victoria&units=Imperial
    Processing Record 237 | albany
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=albany&units=Imperial
    Processing Record 238 | vardo
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=vardo&units=Imperial
    Processing Record 239 | rikitea
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=rikitea&units=Imperial
    Processing Record 240 | belushya guba
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=belushya guba&units=Imperial
    City not found
    Processing Record 241 | new norfolk
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=new norfolk&units=Imperial
    Processing Record 242 | suntar
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=suntar&units=Imperial
    Processing Record 243 | butaritari
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=butaritari&units=Imperial
    Processing Record 244 | sitka
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=sitka&units=Imperial
    Processing Record 245 | makakilo city
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=makakilo city&units=Imperial
    Processing Record 246 | bluff
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=bluff&units=Imperial
    Processing Record 247 | georgetown
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=georgetown&units=Imperial
    Processing Record 248 | puerto ayora
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=puerto ayora&units=Imperial
    Processing Record 249 | iranshahr
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=iranshahr&units=Imperial
    Processing Record 250 | axim
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=axim&units=Imperial
    Processing Record 251 | antofagasta
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=antofagasta&units=Imperial
    Processing Record 252 | margate
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=margate&units=Imperial
    Processing Record 253 | lolua
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=lolua&units=Imperial
    City not found
    Processing Record 254 | tuktoyaktuk
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=tuktoyaktuk&units=Imperial
    Processing Record 255 | attawapiskat
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=attawapiskat&units=Imperial
    City not found
    Processing Record 256 | lagoa
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=lagoa&units=Imperial
    Processing Record 257 | rikitea
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=rikitea&units=Imperial
    Processing Record 258 | okandja
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=okandja&units=Imperial
    City not found
    Processing Record 259 | craigieburn
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=craigieburn&units=Imperial
    Processing Record 260 | bronnoysund
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=bronnoysund&units=Imperial
    Processing Record 261 | dondo
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=dondo&units=Imperial
    Processing Record 262 | ushuaia
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=ushuaia&units=Imperial
    Processing Record 263 | grand river south east
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=grand river south east&units=Imperial
    City not found
    Processing Record 264 | san patricio
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=san patricio&units=Imperial
    Processing Record 265 | east london
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=east london&units=Imperial
    Processing Record 266 | kapaa
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=kapaa&units=Imperial
    Processing Record 267 | butaritari
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=butaritari&units=Imperial
    Processing Record 268 | barrow
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=barrow&units=Imperial
    Processing Record 269 | lebu
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=lebu&units=Imperial
    Processing Record 270 | yellowknife
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=yellowknife&units=Imperial
    Processing Record 271 | oranjemund
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=oranjemund&units=Imperial
    Processing Record 272 | taolanaro
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=taolanaro&units=Imperial
    City not found
    Processing Record 273 | chiang klang
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=chiang klang&units=Imperial
    Processing Record 274 | ushuaia
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=ushuaia&units=Imperial
    Processing Record 275 | busselton
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=busselton&units=Imperial
    Processing Record 276 | castro
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=castro&units=Imperial
    Processing Record 277 | taolanaro
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=taolanaro&units=Imperial
    City not found
    Processing Record 278 | la crosse
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=la crosse&units=Imperial
    Processing Record 279 | talas
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=talas&units=Imperial
    Processing Record 280 | albany
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=albany&units=Imperial
    Processing Record 281 | qaanaaq
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=qaanaaq&units=Imperial
    Processing Record 282 | castro
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=castro&units=Imperial
    Processing Record 283 | rikitea
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=rikitea&units=Imperial
    Processing Record 284 | kirovskiy
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=kirovskiy&units=Imperial
    Processing Record 285 | barrow
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=barrow&units=Imperial
    Processing Record 286 | lucea
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=lucea&units=Imperial
    Processing Record 287 | hasaki
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=hasaki&units=Imperial
    Processing Record 288 | tekeli
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=tekeli&units=Imperial
    Processing Record 289 | mataura
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=mataura&units=Imperial
    Processing Record 290 | port alfred
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=port alfred&units=Imperial
    Processing Record 291 | cabo san lucas
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=cabo san lucas&units=Imperial
    Processing Record 292 | kamina
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=kamina&units=Imperial
    Processing Record 293 | illoqqortoormiut
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=illoqqortoormiut&units=Imperial
    City not found
    Processing Record 294 | verkhnyaya inta
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=verkhnyaya inta&units=Imperial
    Processing Record 295 | busselton
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=busselton&units=Imperial
    Processing Record 296 | arraial do cabo
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=arraial do cabo&units=Imperial
    Processing Record 297 | puerto escondido
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=puerto escondido&units=Imperial
    Processing Record 298 | ancud
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=ancud&units=Imperial
    Processing Record 299 | vaini
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=vaini&units=Imperial
    Processing Record 300 | las cruces
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=las cruces&units=Imperial
    Processing Record 301 | lolua
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=lolua&units=Imperial
    City not found
    Processing Record 302 | ushuaia
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=ushuaia&units=Imperial
    Processing Record 303 | carnarvon
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=carnarvon&units=Imperial
    Processing Record 304 | tarrafal
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=tarrafal&units=Imperial
    Processing Record 305 | attawapiskat
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=attawapiskat&units=Imperial
    City not found
    Processing Record 306 | kodiak
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=kodiak&units=Imperial
    Processing Record 307 | atuona
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=atuona&units=Imperial
    Processing Record 308 | palabuhanratu
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=palabuhanratu&units=Imperial
    City not found
    Processing Record 309 | beringovskiy
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=beringovskiy&units=Imperial
    Processing Record 310 | victoria
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=victoria&units=Imperial
    Processing Record 311 | cape town
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=cape town&units=Imperial
    Processing Record 312 | luganville
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=luganville&units=Imperial
    Processing Record 313 | walvis bay
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=walvis bay&units=Imperial
    Processing Record 314 | lagoa
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=lagoa&units=Imperial
    Processing Record 315 | rikitea
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=rikitea&units=Imperial
    Processing Record 316 | punta arenas
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=punta arenas&units=Imperial
    Processing Record 317 | aksu
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=aksu&units=Imperial
    Processing Record 318 | saldanha
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=saldanha&units=Imperial
    Processing Record 319 | dikson
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=dikson&units=Imperial
    Processing Record 320 | chingirlau
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=chingirlau&units=Imperial
    Processing Record 321 | bredasdorp
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=bredasdorp&units=Imperial
    Processing Record 322 | broken hill
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=broken hill&units=Imperial
    Processing Record 323 | saleaula
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=saleaula&units=Imperial
    City not found
    Processing Record 324 | cayenne
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=cayenne&units=Imperial
    Processing Record 325 | nara
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=nara&units=Imperial
    Processing Record 326 | saint-philippe
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=saint-philippe&units=Imperial
    Processing Record 327 | busselton
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=busselton&units=Imperial
    Processing Record 328 | vaini
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=vaini&units=Imperial
    Processing Record 329 | ushuaia
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=ushuaia&units=Imperial
    Processing Record 330 | lebu
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=lebu&units=Imperial
    Processing Record 331 | khatanga
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=khatanga&units=Imperial
    Processing Record 332 | college
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=college&units=Imperial
    Processing Record 333 | anaconda
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=anaconda&units=Imperial
    Processing Record 334 | new norfolk
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=new norfolk&units=Imperial
    Processing Record 335 | hobart
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=hobart&units=Imperial
    Processing Record 336 | sabang
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=sabang&units=Imperial
    Processing Record 337 | khatanga
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=khatanga&units=Imperial
    Processing Record 338 | kapaa
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=kapaa&units=Imperial
    Processing Record 339 | thompson
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=thompson&units=Imperial
    Processing Record 340 | warrnambool
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=warrnambool&units=Imperial
    Processing Record 341 | chokurdakh
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=chokurdakh&units=Imperial
    Processing Record 342 | torbay
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=torbay&units=Imperial
    Processing Record 343 | sungairaya
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=sungairaya&units=Imperial
    Processing Record 344 | kapaa
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=kapaa&units=Imperial
    Processing Record 345 | rikitea
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=rikitea&units=Imperial
    Processing Record 346 | bredasdorp
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=bredasdorp&units=Imperial
    Processing Record 347 | hermanus
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=hermanus&units=Imperial
    Processing Record 348 | bouna
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=bouna&units=Imperial
    Processing Record 349 | albany
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=albany&units=Imperial
    Processing Record 350 | busselton
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=busselton&units=Imperial
    Processing Record 351 | namibe
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=namibe&units=Imperial
    Processing Record 352 | kaitangata
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=kaitangata&units=Imperial
    Processing Record 353 | vaini
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=vaini&units=Imperial
    Processing Record 354 | albany
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=albany&units=Imperial
    Processing Record 355 | korla
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=korla&units=Imperial
    City not found
    Processing Record 356 | atuona
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=atuona&units=Imperial
    Processing Record 357 | mataura
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=mataura&units=Imperial
    Processing Record 358 | bowen
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=bowen&units=Imperial
    Processing Record 359 | skjervoy
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=skjervoy&units=Imperial
    Processing Record 360 | maceio
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=maceio&units=Imperial
    Processing Record 361 | sterling
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=sterling&units=Imperial
    Processing Record 362 | hobart
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=hobart&units=Imperial
    Processing Record 363 | garowe
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=garowe&units=Imperial
    Processing Record 364 | nurota
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=nurota&units=Imperial
    Processing Record 365 | vaini
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=vaini&units=Imperial
    Processing Record 366 | sulangan
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=sulangan&units=Imperial
    Processing Record 367 | atuona
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=atuona&units=Imperial
    Processing Record 368 | mataura
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=mataura&units=Imperial
    Processing Record 369 | saint-pierre
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=saint-pierre&units=Imperial
    Processing Record 370 | ushuaia
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=ushuaia&units=Imperial
    Processing Record 371 | nikolskoye
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=nikolskoye&units=Imperial
    Processing Record 372 | tsihombe
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=tsihombe&units=Imperial
    City not found
    Processing Record 373 | krasnoznamensk
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=krasnoznamensk&units=Imperial
    Processing Record 374 | dikson
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=dikson&units=Imperial
    Processing Record 375 | cape town
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=cape town&units=Imperial
    Processing Record 376 | port lincoln
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=port lincoln&units=Imperial
    Processing Record 377 | pisco
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=pisco&units=Imperial
    Processing Record 378 | saskylakh
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=saskylakh&units=Imperial
    Processing Record 379 | bluff
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=bluff&units=Imperial
    Processing Record 380 | saint george
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=saint george&units=Imperial
    Processing Record 381 | havoysund
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=havoysund&units=Imperial
    Processing Record 382 | port alfred
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=port alfred&units=Imperial
    Processing Record 383 | illoqqortoormiut
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=illoqqortoormiut&units=Imperial
    City not found
    Processing Record 384 | ponta do sol
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=ponta do sol&units=Imperial
    Processing Record 385 | taolanaro
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=taolanaro&units=Imperial
    City not found
    Processing Record 386 | busselton
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=busselton&units=Imperial
    Processing Record 387 | kyaikto
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=kyaikto&units=Imperial
    Processing Record 388 | sturgeon bay
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=sturgeon bay&units=Imperial
    Processing Record 389 | college
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=college&units=Imperial
    Processing Record 390 | ixtapa
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=ixtapa&units=Imperial
    Processing Record 391 | codrington
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=codrington&units=Imperial
    Processing Record 392 | kamenskoye
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=kamenskoye&units=Imperial
    City not found
    Processing Record 393 | saint-philippe
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=saint-philippe&units=Imperial
    Processing Record 394 | belushya guba
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=belushya guba&units=Imperial
    City not found
    Processing Record 395 | punta arenas
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=punta arenas&units=Imperial
    Processing Record 396 | sioux lookout
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=sioux lookout&units=Imperial
    Processing Record 397 | ushuaia
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=ushuaia&units=Imperial
    Processing Record 398 | isangel
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=isangel&units=Imperial
    Processing Record 399 | arraial do cabo
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=arraial do cabo&units=Imperial
    Processing Record 400 | canutama
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=canutama&units=Imperial
    Processing Record 401 | viligili
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=viligili&units=Imperial
    City not found
    Processing Record 402 | bluff
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=bluff&units=Imperial
    Processing Record 403 | busselton
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=busselton&units=Imperial
    Processing Record 404 | rudnichnyy
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=rudnichnyy&units=Imperial
    Processing Record 405 | beauchamps
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=beauchamps&units=Imperial
    Processing Record 406 | nizwa
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=nizwa&units=Imperial
    Processing Record 407 | cape town
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=cape town&units=Imperial
    Processing Record 408 | rikitea
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=rikitea&units=Imperial
    Processing Record 409 | carnarvon
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=carnarvon&units=Imperial
    Processing Record 410 | kruisfontein
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=kruisfontein&units=Imperial
    Processing Record 411 | busselton
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=busselton&units=Imperial
    Processing Record 412 | manavalakurichi
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=manavalakurichi&units=Imperial
    Processing Record 413 | talara
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=talara&units=Imperial
    Processing Record 414 | vaini
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=vaini&units=Imperial
    Processing Record 415 | ulladulla
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=ulladulla&units=Imperial
    Processing Record 416 | illoqqortoormiut
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=illoqqortoormiut&units=Imperial
    City not found
    Processing Record 417 | devyatka
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=devyatka&units=Imperial
    City not found
    Processing Record 418 | te anau
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=te anau&units=Imperial
    Processing Record 419 | nioro
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=nioro&units=Imperial
    Processing Record 420 | punta arenas
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=punta arenas&units=Imperial
    Processing Record 421 | tonantins
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=tonantins&units=Imperial
    Processing Record 422 | llanes
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=llanes&units=Imperial
    Processing Record 423 | lebu
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=lebu&units=Imperial
    Processing Record 424 | castro
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=castro&units=Imperial
    Processing Record 425 | turukhansk
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=turukhansk&units=Imperial
    Processing Record 426 | lumsden
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=lumsden&units=Imperial
    Processing Record 427 | ribeira grande
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=ribeira grande&units=Imperial
    Processing Record 428 | hithadhoo
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=hithadhoo&units=Imperial
    Processing Record 429 | bilibino
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=bilibino&units=Imperial
    Processing Record 430 | mataura
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=mataura&units=Imperial
    Processing Record 431 | tandalti
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=tandalti&units=Imperial
    Processing Record 432 | mar del plata
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=mar del plata&units=Imperial
    Processing Record 433 | lompoc
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=lompoc&units=Imperial
    Processing Record 434 | tuatapere
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=tuatapere&units=Imperial
    Processing Record 435 | punta arenas
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=punta arenas&units=Imperial
    Processing Record 436 | jiddah
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=jiddah&units=Imperial
    City not found
    Processing Record 437 | busselton
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=busselton&units=Imperial
    Processing Record 438 | new norfolk
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=new norfolk&units=Imperial
    Processing Record 439 | xadani
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=xadani&units=Imperial
    City not found
    Processing Record 440 | chuy
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=chuy&units=Imperial
    Processing Record 441 | mataura
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=mataura&units=Imperial
    Processing Record 442 | mataura
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=mataura&units=Imperial
    Processing Record 443 | jalu
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=jalu&units=Imperial
    Processing Record 444 | kawalu
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=kawalu&units=Imperial
    Processing Record 445 | changli
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=changli&units=Imperial
    Processing Record 446 | waingapu
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=waingapu&units=Imperial
    Processing Record 447 | dolbeau
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=dolbeau&units=Imperial
    City not found
    Processing Record 448 | broome
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=broome&units=Imperial
    Processing Record 449 | qaanaaq
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=qaanaaq&units=Imperial
    Processing Record 450 | mataura
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=mataura&units=Imperial
    Processing Record 451 | torbay
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=torbay&units=Imperial
    Processing Record 452 | bredasdorp
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=bredasdorp&units=Imperial
    Processing Record 453 | planaltina
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=planaltina&units=Imperial
    Processing Record 454 | faanui
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=faanui&units=Imperial
    Processing Record 455 | hermanus
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=hermanus&units=Imperial
    Processing Record 456 | kaitangata
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=kaitangata&units=Imperial
    Processing Record 457 | tuktoyaktuk
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=tuktoyaktuk&units=Imperial
    Processing Record 458 | port alfred
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=port alfred&units=Imperial
    Processing Record 459 | carnarvon
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=carnarvon&units=Imperial
    Processing Record 460 | mirnyy
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=mirnyy&units=Imperial
    Processing Record 461 | los llanos de aridane
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=los llanos de aridane&units=Imperial
    Processing Record 462 | souillac
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=souillac&units=Imperial
    Processing Record 463 | hilo
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=hilo&units=Imperial
    Processing Record 464 | vaini
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=vaini&units=Imperial
    Processing Record 465 | cape town
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=cape town&units=Imperial
    Processing Record 466 | samusu
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=samusu&units=Imperial
    City not found
    Processing Record 467 | general roca
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=general roca&units=Imperial
    Processing Record 468 | albany
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=albany&units=Imperial
    Processing Record 469 | grindavik
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=grindavik&units=Imperial
    Processing Record 470 | sungairaya
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=sungairaya&units=Imperial
    Processing Record 471 | hilo
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=hilo&units=Imperial
    Processing Record 472 | manhattan
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=manhattan&units=Imperial
    Processing Record 473 | nicoya
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=nicoya&units=Imperial
    Processing Record 474 | new norfolk
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=new norfolk&units=Imperial
    Processing Record 475 | azare
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=azare&units=Imperial
    Processing Record 476 | coari
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=coari&units=Imperial
    Processing Record 477 | sentyabrskiy
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=sentyabrskiy&units=Imperial
    City not found
    Processing Record 478 | saint-francois
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=saint-francois&units=Imperial
    Processing Record 479 | cape town
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=cape town&units=Imperial
    Processing Record 480 | albany
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=albany&units=Imperial
    Processing Record 481 | hambantota
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=hambantota&units=Imperial
    Processing Record 482 | hermanus
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=hermanus&units=Imperial
    Processing Record 483 | naze
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=naze&units=Imperial
    Processing Record 484 | umm lajj
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=umm lajj&units=Imperial
    Processing Record 485 | provideniya
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=provideniya&units=Imperial
    Processing Record 486 | riyadh
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=riyadh&units=Imperial
    Processing Record 487 | kirakira
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=kirakira&units=Imperial
    Processing Record 488 | tougue
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=tougue&units=Imperial
    Processing Record 489 | tiksi
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=tiksi&units=Imperial
    Processing Record 490 | hurghada
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=hurghada&units=Imperial
    City not found
    Processing Record 491 | mancheral
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=mancheral&units=Imperial
    Processing Record 492 | hithadhoo
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=hithadhoo&units=Imperial
    Processing Record 493 | abu samrah
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=abu samrah&units=Imperial
    Processing Record 494 | yellowknife
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=yellowknife&units=Imperial
    Processing Record 495 | mataura
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=mataura&units=Imperial
    Processing Record 496 | ushuaia
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=ushuaia&units=Imperial
    Processing Record 497 | batemans bay
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=batemans bay&units=Imperial
    Processing Record 498 | bambous virieux
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=bambous virieux&units=Imperial
    Processing Record 499 | mentok
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=mentok&units=Imperial
    City not found
    Processing Record 500 | yurimaguas
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=yurimaguas&units=Imperial
    Processing Record 501 | hilo
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=hilo&units=Imperial
    Processing Record 502 | ostrovnoy
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=ostrovnoy&units=Imperial
    Processing Record 503 | vaitupu
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=vaitupu&units=Imperial
    City not found
    Processing Record 504 | te anau
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=te anau&units=Imperial
    Processing Record 505 | saint-joseph
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=saint-joseph&units=Imperial
    Processing Record 506 | rikitea
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=rikitea&units=Imperial
    Processing Record 507 | macusani
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=macusani&units=Imperial
    Processing Record 508 | ponta do sol
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=ponta do sol&units=Imperial
    Processing Record 509 | amderma
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=amderma&units=Imperial
    City not found
    Processing Record 510 | kodiak
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=kodiak&units=Imperial
    Processing Record 511 | punta arenas
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=punta arenas&units=Imperial
    Processing Record 512 | hobart
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=hobart&units=Imperial
    Processing Record 513 | zhangjiakou
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=zhangjiakou&units=Imperial
    Processing Record 514 | bredasdorp
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=bredasdorp&units=Imperial
    Processing Record 515 | papetoai
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=papetoai&units=Imperial
    Processing Record 516 | los llanos de aridane
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=los llanos de aridane&units=Imperial
    Processing Record 517 | sentyabrskiy
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=sentyabrskiy&units=Imperial
    City not found
    Processing Record 518 | saldanha
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=saldanha&units=Imperial
    Processing Record 519 | mamallapuram
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=mamallapuram&units=Imperial
    Processing Record 520 | lebu
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=lebu&units=Imperial
    Processing Record 521 | mbala
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=mbala&units=Imperial
    Processing Record 522 | puerto ayora
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=puerto ayora&units=Imperial
    Processing Record 523 | halifax
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=halifax&units=Imperial
    Processing Record 524 | saint george
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=saint george&units=Imperial
    Processing Record 525 | caravelas
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=caravelas&units=Imperial
    Processing Record 526 | kapaa
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=kapaa&units=Imperial
    Processing Record 527 | rikitea
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=rikitea&units=Imperial
    Processing Record 528 | carnarvon
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=carnarvon&units=Imperial
    Processing Record 529 | punta arenas
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=punta arenas&units=Imperial
    Processing Record 530 | port blair
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=port blair&units=Imperial
    Processing Record 531 | longyearbyen
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=longyearbyen&units=Imperial
    Processing Record 532 | auki
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=auki&units=Imperial
    Processing Record 533 | koslan
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=koslan&units=Imperial
    Processing Record 534 | tuktoyaktuk
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=tuktoyaktuk&units=Imperial
    Processing Record 535 | albany
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=albany&units=Imperial
    Processing Record 536 | pavlodar
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=pavlodar&units=Imperial
    Processing Record 537 | ushuaia
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=ushuaia&units=Imperial
    Processing Record 538 | aklavik
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=aklavik&units=Imperial
    Processing Record 539 | nikolskoye
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=nikolskoye&units=Imperial
    Processing Record 540 | rikitea
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=rikitea&units=Imperial
    Processing Record 541 | kysyl-syr
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=kysyl-syr&units=Imperial
    Processing Record 542 | vaitupu
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=vaitupu&units=Imperial
    City not found
    Processing Record 543 | iranshahr
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=iranshahr&units=Imperial
    Processing Record 544 | kaitangata
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=kaitangata&units=Imperial
    Processing Record 545 | attawapiskat
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=attawapiskat&units=Imperial
    City not found
    Processing Record 546 | talnakh
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=talnakh&units=Imperial
    Processing Record 547 | manokwari
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=manokwari&units=Imperial
    Processing Record 548 | povenets
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=povenets&units=Imperial
    Processing Record 549 | barrow
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=barrow&units=Imperial
    Processing Record 550 | hithadhoo
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=hithadhoo&units=Imperial
    Processing Record 551 | torbay
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=torbay&units=Imperial
    Processing Record 552 | bargal
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=bargal&units=Imperial
    City not found
    Processing Record 553 | novikovo
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=novikovo&units=Imperial
    Processing Record 554 | catabola
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=catabola&units=Imperial
    Processing Record 555 | boyolangu
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=boyolangu&units=Imperial
    Processing Record 556 | port-gentil
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=port-gentil&units=Imperial
    Processing Record 557 | sept-iles
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=sept-iles&units=Imperial
    Processing Record 558 | tautira
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=tautira&units=Imperial
    Processing Record 559 | kapaa
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=kapaa&units=Imperial
    Processing Record 560 | avarua
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=avarua&units=Imperial
    Processing Record 561 | bredasdorp
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=bredasdorp&units=Imperial
    Processing Record 562 | isangel
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=isangel&units=Imperial
    Processing Record 563 | coihaique
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=coihaique&units=Imperial
    Processing Record 564 | guanare
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=guanare&units=Imperial
    Processing Record 565 | muisne
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=muisne&units=Imperial
    Processing Record 566 | belebey
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=belebey&units=Imperial
    Processing Record 567 | castro
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=castro&units=Imperial
    Processing Record 568 | albany
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=albany&units=Imperial
    Processing Record 569 | jamestown
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=jamestown&units=Imperial
    Processing Record 570 | balimo
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=balimo&units=Imperial
    City not found
    Processing Record 571 | esperance
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=esperance&units=Imperial
    Processing Record 572 | airai
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=airai&units=Imperial
    Processing Record 573 | yanam
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=yanam&units=Imperial
    Processing Record 574 | blythe
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=blythe&units=Imperial
    Processing Record 575 | inirida
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=inirida&units=Imperial
    Processing Record 576 | komsomolskiy
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=komsomolskiy&units=Imperial
    Processing Record 577 | port alfred
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=port alfred&units=Imperial
    Processing Record 578 | bubaque
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=bubaque&units=Imperial
    Processing Record 579 | kasongo-lunda
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=kasongo-lunda&units=Imperial
    Processing Record 580 | samusu
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=samusu&units=Imperial
    City not found
    Processing Record 581 | victoria
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=victoria&units=Imperial
    Processing Record 582 | rikitea
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=rikitea&units=Imperial
    Processing Record 583 | vila franca do campo
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=vila franca do campo&units=Imperial
    Processing Record 584 | chuy
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=chuy&units=Imperial
    Processing Record 585 | cabo san lucas
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=cabo san lucas&units=Imperial
    Processing Record 586 | hilo
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=hilo&units=Imperial
    Processing Record 587 | jamestown
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=jamestown&units=Imperial
    Processing Record 588 | port alfred
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=port alfred&units=Imperial
    Processing Record 589 | laibin
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=laibin&units=Imperial
    Processing Record 590 | artyk
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=artyk&units=Imperial
    City not found
    Processing Record 591 | san jeronimo
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=san jeronimo&units=Imperial
    Processing Record 592 | rikitea
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=rikitea&units=Imperial
    Processing Record 593 | punta arenas
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=punta arenas&units=Imperial
    Processing Record 594 | tsogni
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=tsogni&units=Imperial
    Processing Record 595 | ushuaia
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=ushuaia&units=Imperial
    Processing Record 596 | tecoanapa
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=tecoanapa&units=Imperial
    Processing Record 597 | puerto ayora
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=puerto ayora&units=Imperial
    Processing Record 598 | pozo colorado
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=pozo colorado&units=Imperial
    Processing Record 599 | cabedelo
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=cabedelo&units=Imperial
    Processing Record 600 | punta arenas
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=punta arenas&units=Imperial
    Processing Record 601 | port alfred
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=port alfred&units=Imperial
    Processing Record 602 | ushuaia
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=ushuaia&units=Imperial
    Processing Record 603 | dikson
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=dikson&units=Imperial
    Processing Record 604 | toliary
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=toliary&units=Imperial
    City not found
    Processing Record 605 | bethel
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=bethel&units=Imperial
    Processing Record 606 | butaritari
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=butaritari&units=Imperial
    Processing Record 607 | busselton
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=busselton&units=Imperial
    Processing Record 608 | aykhal
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=aykhal&units=Imperial
    Processing Record 609 | taolanaro
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=taolanaro&units=Imperial
    City not found
    Processing Record 610 | punta arenas
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=punta arenas&units=Imperial
    Processing Record 611 | santa lucia
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=santa lucia&units=Imperial
    Processing Record 612 | matagami
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=matagami&units=Imperial
    Processing Record 613 | soller
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=soller&units=Imperial
    Processing Record 614 | ushuaia
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=ushuaia&units=Imperial
    Processing Record 615 | cayenne
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=cayenne&units=Imperial
    Processing Record 616 | margate
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=margate&units=Imperial
    Processing Record 617 | mys shmidta
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=mys shmidta&units=Imperial
    City not found
    Processing Record 618 | illoqqortoormiut
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=illoqqortoormiut&units=Imperial
    City not found
    Processing Record 619 | ribeira grande
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=ribeira grande&units=Imperial
    Processing Record 620 | ushuaia
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=ushuaia&units=Imperial
    Processing Record 621 | busselton
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=busselton&units=Imperial
    Processing Record 622 | rikitea
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=rikitea&units=Imperial
    Processing Record 623 | new norfolk
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=new norfolk&units=Imperial
    Processing Record 624 | podgorodnyaya pokrovka
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=podgorodnyaya pokrovka&units=Imperial
    Processing Record 625 | jamestown
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=jamestown&units=Imperial
    Processing Record 626 | saskylakh
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=saskylakh&units=Imperial
    Processing Record 627 | rio grande
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=rio grande&units=Imperial
    Processing Record 628 | east london
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=east london&units=Imperial
    Processing Record 629 | puerto ayora
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=puerto ayora&units=Imperial
    Processing Record 630 | attawapiskat
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=attawapiskat&units=Imperial
    City not found
    Processing Record 631 | victoria
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=victoria&units=Imperial
    Processing Record 632 | punta arenas
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=punta arenas&units=Imperial
    Processing Record 633 | cape town
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=cape town&units=Imperial
    Processing Record 634 | busselton
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=busselton&units=Imperial
    Processing Record 635 | mataura
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=mataura&units=Imperial
    Processing Record 636 | moyale
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=moyale&units=Imperial
    Processing Record 637 | jamestown
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=jamestown&units=Imperial
    Processing Record 638 | norfolk
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=norfolk&units=Imperial
    Processing Record 639 | mar del plata
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=mar del plata&units=Imperial
    Processing Record 640 | okhotsk
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=okhotsk&units=Imperial
    Processing Record 641 | houma
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=houma&units=Imperial
    Processing Record 642 | fortuna
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=fortuna&units=Imperial
    Processing Record 643 | ushuaia
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=ushuaia&units=Imperial
    Processing Record 644 | chokurdakh
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=chokurdakh&units=Imperial
    Processing Record 645 | faya
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=faya&units=Imperial
    Processing Record 646 | castanos
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=castanos&units=Imperial
    Processing Record 647 | kita
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=kita&units=Imperial
    Processing Record 648 | nieuw amsterdam
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=nieuw amsterdam&units=Imperial
    Processing Record 649 | rikitea
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=rikitea&units=Imperial
    Processing Record 650 | hobart
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=hobart&units=Imperial
    Processing Record 651 | sola
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=sola&units=Imperial
    Processing Record 652 | hilo
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=hilo&units=Imperial
    Processing Record 653 | east london
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=east london&units=Imperial
    Processing Record 654 | mataura
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=mataura&units=Imperial
    Processing Record 655 | carnarvon
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=carnarvon&units=Imperial
    Processing Record 656 | mataura
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=mataura&units=Imperial
    Processing Record 657 | rungata
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=rungata&units=Imperial
    City not found
    Processing Record 658 | cape town
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=cape town&units=Imperial
    Processing Record 659 | kloulklubed
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=kloulklubed&units=Imperial
    Processing Record 660 | santo domingo
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=santo domingo&units=Imperial
    Processing Record 661 | rikitea
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=rikitea&units=Imperial
    Processing Record 662 | atuona
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=atuona&units=Imperial
    Processing Record 663 | arraial do cabo
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=arraial do cabo&units=Imperial
    Processing Record 664 | bredasdorp
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=bredasdorp&units=Imperial
    Processing Record 665 | jamestown
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=jamestown&units=Imperial
    Processing Record 666 | lompoc
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=lompoc&units=Imperial
    Processing Record 667 | derbent
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=derbent&units=Imperial
    Processing Record 668 | curuca
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=curuca&units=Imperial
    Processing Record 669 | yellowknife
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=yellowknife&units=Imperial
    Processing Record 670 | atuona
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=atuona&units=Imperial
    Processing Record 671 | albany
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=albany&units=Imperial
    Processing Record 672 | tasiilaq
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=tasiilaq&units=Imperial
    Processing Record 673 | yellowknife
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=yellowknife&units=Imperial
    Processing Record 674 | adrar
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=adrar&units=Imperial
    Processing Record 675 | bambous virieux
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=bambous virieux&units=Imperial
    Processing Record 676 | klaksvik
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=klaksvik&units=Imperial
    Processing Record 677 | punta arenas
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=punta arenas&units=Imperial
    Processing Record 678 | vaini
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=vaini&units=Imperial
    Processing Record 679 | bathsheba
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=bathsheba&units=Imperial
    Processing Record 680 | te anau
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=te anau&units=Imperial
    Processing Record 681 | kapaa
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=kapaa&units=Imperial
    Processing Record 682 | vila velha
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=vila velha&units=Imperial
    Processing Record 683 | vaini
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=vaini&units=Imperial
    Processing Record 684 | hermanus
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=hermanus&units=Imperial
    Processing Record 685 | jamestown
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=jamestown&units=Imperial
    Processing Record 686 | laguna
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=laguna&units=Imperial
    Processing Record 687 | castro
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=castro&units=Imperial
    Processing Record 688 | atuona
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=atuona&units=Imperial
    Processing Record 689 | nikolskoye
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=nikolskoye&units=Imperial
    Processing Record 690 | huarmey
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=huarmey&units=Imperial
    Processing Record 691 | rikitea
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=rikitea&units=Imperial
    Processing Record 692 | kapaa
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=kapaa&units=Imperial
    Processing Record 693 | shihezi
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=shihezi&units=Imperial
    Processing Record 694 | rikitea
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=rikitea&units=Imperial
    Processing Record 695 | hilo
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=hilo&units=Imperial
    Processing Record 696 | palembang
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=palembang&units=Imperial
    Processing Record 697 | puerto ayora
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=puerto ayora&units=Imperial
    Processing Record 698 | ushuaia
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=ushuaia&units=Imperial
    Processing Record 699 | miles city
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=miles city&units=Imperial
    Processing Record 700 | qaanaaq
    http://api.openweathermap.org/data/2.5/weather?appid=a2f6e46a145b1922f9d5001148190c6a&q=qaanaaq&units=Imperial
    -----------------------------
    Data Retrieval Complete





    Cities        632
    Cloudiness    632
    Humidity      632
    Latitude      632
    Longitude     632
    Temp          632
    Wind Speed    632
    dtype: int64



PLOTS


```python
import matplotlib.pyplot as plt

plt.title('Latitude vs. Temperature Plot (3/16/18)')
plt.xlabel('Latitude')
plt.ylabel('Temperature (F)')
plt.scatter(weatherDF['Latitude'].apply(float), weatherDF['Temp'])
plt.show()

plt.title('Latitude vs. Humidity Plot (3/16/18)')
plt.xlabel('Latitude')
plt.ylabel('Humidity (%)')
plt.scatter(weatherDF['Latitude'].apply(float), weatherDF['Humidity'])
plt.show()

plt.title('Latitude vs. Cloudiness Plot (3/16/18)')
plt.xlabel('Latitude')
plt.ylabel('Cloudiness (%)')
plt.scatter(weatherDF['Latitude'].apply(float), weatherDF['Cloudiness'])
plt.show()

plt.title('Latitude vs. Wind Speed Plot (3/16/18)')
plt.xlabel('Latitude')
plt.ylabel('Wind Speed (mph)')
plt.scatter(weatherDF['Latitude'].apply(float), weatherDF['Wind Speed'])
plt.show()
```


![png](output_3_0.png)



![png](output_3_1.png)



![png](output_3_2.png)



![png](output_3_3.png)

