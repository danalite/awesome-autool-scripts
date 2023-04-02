from flask import Flask, request, send_file
import azure.cognitiveservices.speech as speechsdk
import io

# Set up Azure TTS client
speech_key = 'YOUR_SUBSCRIPTION_KEY'
service_region = 'YOUR_SERVICE_REGION'
speech_config = speechsdk.SpeechConfig(subscription=speech_key, region=service_region)
speech_synthesizer = speechsdk.SpeechSynthesizer(speech_config=speech_config)

# Set up Flask app
app = Flask(__name__)

# Define HTTP route for TTS endpoint
@app.route('/tts', methods=['POST'])
def tts():
    # Get input text from request
    text = request.json['text']

    # Synthesize speech from input text
    result = speech_synthesizer.speak_text_async(text).get()

    # Convert audio data to WAV format
    stream = io.BytesIO(result.audio_data)
    return send_file(stream, mimetype='audio/wav')
