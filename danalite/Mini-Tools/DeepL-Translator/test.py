import requests

deeplx_api = "http://127.0.0.1:1188/translate"
data = {
    "text": "To send a POST request to the specified URL with the given data, you can use the requests library in Python. Here's an example of how to do it:",
    "source_lang": "EN",
    "target_lang": "ZH"
}

response = requests.post(deeplx_api, json=data)

# Check the response status code
if response.status_code == 200:
    # Request was successful
    translated_text = response.json()
    print("Translated Text:", translated_text)
else:
    # Request failed
    print("Error:", response.text)