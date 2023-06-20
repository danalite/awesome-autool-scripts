from transformers import GPT2Tokenizer, GPT2LMHeadModel
from flask import Flask, request

# Load pretrained model and tokenizer
model = GPT2LMHeadModel.from_pretrained("asi/gpt-fr-cased-base")
tokenizer = GPT2Tokenizer.from_pretrained("asi/gpt-fr-cased-base")

# Generate a sample of text
model.eval()

app = Flask(__name__)


@app.route("/sentence_gen", methods=["POST"])
def print_words():
    words = request.json.get("words")
    if not words:
        return "No words provided.", 400

    input_sentence = "écrire une phrase simple en utilisant les mots suivants : pomme, jus de fruit. "
    # for word in words:
    #     input_sentence += word + ", "
    # input_sentence = input_sentence[:-2] + "."

    input_ids = tokenizer.encode(input_sentence, return_tensors="pt")

    beam_outputs = model.generate(
        input_ids,
        max_length=100,
        do_sample=True,
        top_k=50,
        top_p=0.95,
        num_return_sequences=1,
    )
    print("Output:\n" + 100 * "-")
    print(tokenizer.decode(beam_outputs[0], skip_special_tokens=True))


    return "Words printed successfully."


if __name__ == "__main__":
    app.run()



