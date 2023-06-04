import requests
import json

url = 'http://192.168.0.30:8100/'

text = "Predict the stock price of Tesla tomorrow. "
response = requests.post(url, data={'text': text}, stream=True)

for line in response.iter_content():
    if line:
        # output = json.loads(line)
        v = line.decode('utf-8')
        print(v, "=====\n")
        # print(json.dumps(output, indent=2))
