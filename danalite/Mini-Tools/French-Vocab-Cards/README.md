## Pre-requisites
- **GPT model for sentence generation**: we use a fine-tuned french GPT model to generate french sentences. [The model is hosted by HF](https://huggingface.co/asi/gpt-fr-cased-base)

```python
from transformers import GPT2Tokenizer, GPT2LMHeadModel

# Load pretrained model and tokenizer
model = GPT2LMHeadModel.from_pretrained("asi/gpt-fr-cased-base")
tokenizer = GPT2Tokenizer.from_pretrained("asi/gpt-fr-cased-base")

model.eval()
input_sentence = "Longtemps je me suis couché de bonne heure."
input_ids = tokenizer.encode(input_sentence, return_tensors='pt')

beam_outputs = model.generate(
    input_ids, 
    max_length=100, 
    do_sample=True,   
    top_k=50, 
    top_p=0.95, 
    num_return_sequences=1
)

print("Output:\n" + 100 * '-')
print(tokenizer.decode(beam_outputs[0], skip_special_tokens=True))
```

- DeepL for 

```shell
# https://github.com/OwO-Network/DeepLX

# Set up the docker API service
docker run -itd -p 1188:1188 ghcr.io/owo-network/deeplx:latest
```

### Connect with Anki (optional)
- AnKi docker image if you want to use your existing decks in Anki:　install the anki-desktop docker image. Run `docker compose up`: https://hub.docker.com/r/pnorcross/anki-desktop

```yaml
services:
  anki-desktop: 
    image: "pnorcross/anki-desktop:latest"
    volumes:
      - ./config:/config/app
    ports: 
      - 3000:3000
      - 8765:8765
```

- Option 2: install anki-desktop from https://apps.ankiweb.net/, import decks locally and API call through anki-connect

- Option 3: do NOT use anki. Spaced repetition using csv local database. To make it simple, we use one CSV from [French-Dictionary](https://github.com/hbenbel/French-Dictionary/tree/master/dictionary) as example. The script will maintain another light SQLite database to track the progress.


