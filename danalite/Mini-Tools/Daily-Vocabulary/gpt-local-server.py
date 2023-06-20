
import openai
from flask import Flask, request, jsonify
openai.api_key = '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'


app = Flask(__name__)
@app.route("/sentence_gen", methods=["POST"])
def print_words():
    prompt = request.json.get("prompt")
    if not prompt:
        return "No words provided.", 400

    messages = [ {"role": "system", "content": 
              "You are a french teacher."} ]

    message = prompt
    if message:
        messages.append(
            {"role": "user", "content": message},
        )
        chat = openai.ChatCompletion.create(
            model="gpt-3.5-turbo", messages=messages
        )
    reply = chat.choices[0].message.content
    print(f"ChatGPT: {reply}")
    # messages.append({"role": "assistant", "content": reply})

    # return JSON
    return jsonify({"reply": reply})


if __name__ == "__main__":
    app.run()



