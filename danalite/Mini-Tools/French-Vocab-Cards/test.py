import requests

url = 'http://127.0.0.1:5000/sentence_gen'
data = {'prompt': 'écrire une phrase simple en utilisant les mots suivants :pomme, jus de fruit.'}

response = requests.post(url, json=data)
print(response.text)