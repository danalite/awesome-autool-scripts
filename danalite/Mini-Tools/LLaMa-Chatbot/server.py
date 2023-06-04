import asyncio
import websockets

async def sendData(websocket, path):
    # Send data to client
    data = "Hello, client!"
    await websocket.send(data)
    await websocket.send("__DONE__")

# Start the server
start_server = websockets.serve(sendData, "localhost", 8765)

# Run the server indefinitely
asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()

def send_message(websocket, text):
    from llama_cpp import Llama
    llm = Llama(model_path="~/llama.cpp/models/7B/ggml-model-q4_0.bin")
    stream = llm(
        "Question: " + text + " and explain why. Answer: ",
        max_tokens=512,
        stop=["Q:", "\n"],
        stream=True,
    )

    for line in stream:
        if line:
            websocket.send(line)