import requests
import tempfile
import os

# Define input text to synthesize
text = "Hello, world!"

# Define URL of TTS server
url = "http://localhost:5000/tts"

# Define headers for HTTP request
headers = {'Content-Type': 'application/json'}

# Define JSON payload for HTTP request
payload = {'text': text}

# Send HTTP request and save response to temporary file
response = requests.post(url, headers=headers, json=payload)
with tempfile.NamedTemporaryFile(delete=False, suffix='.wav') as f:
    f.write(response.content)
    temp_file_path = f.name

# Do something with the saved WAV file, e.g. play it using a media player
# os.system(f"start {temp_file_path}") # for Windows
print(temp_file_path)
os.system(f"open {temp_file_path}") # for macOS
