# pip install PyDeepLX
# https://github.com/OwO-Network/PyDeepLX

from flask import Flask, request, jsonify
from PyDeepLX import PyDeepLX

app = Flask(__name__)

# curl -X POST -H "Content-Type: application/json" -d '{
#     "text": "Hello, how are you?",
#     "source_lang": "en", 
#     "target_lang": "fr"
# }' http://localhost:5000/translate

@app.route('/translate', methods=['POST'])
def translate():
    data = request.get_json()

    # Extract the required fields from the JSON data
    text = data.get('text')
    source_lang = data.get('source_lang')
    target_lang = data.get('target_lang')

    # Translate the text using the translation service
    # translated_text = PyDeepLX.translate(text, source_lang, target_lang)
    translated_text = "THIS is a test"

    # Create a response JSON
    response = {'translated_text': translated_text}

    return jsonify(response)

if __name__ == '__main__':
    app.run(debug=True)
