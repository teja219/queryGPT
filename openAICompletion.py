import openai
import requests
from bootstrapQueries.bootstrap_property import bootstrapQuery
import threading
import time
from tqdm import tqdm
from charts import drawGraphWrapper
# Load your API key from an environment variable or secret management service
openai.api_key = "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"
def getChatCompletion(query):
    chat_completion = openai.ChatCompletion.create(model="gpt-3.5-turbo", messages=[{"role": "user", "content": query}])
    return chat_completion["choices"][0]["message"]["content"]
def getData(payload):
    url = "http://127.0.0.1:8080/query"
    headers = {
        'Content-Type': 'text/plain'
    }
    animation_thread = threading.Thread(target=loading_animation)
    animation_thread.start()
    response = requests.request("POST", url, headers=headers, data=payload)
    animation_thread.join()
    return response.text
def loading_animation():
    for _ in tqdm(range(10), desc="Executing SQL", ascii=True, ncols=100):
        time.sleep(0.1)
def parseQuery(completion):
    start_marker = "Request: getData$"
    end_marker = "PAUSE"

    start_index = completion.find(start_marker) + len(start_marker)
    end_index = completion.find(end_marker)

    if start_index != -1 and end_index != -1:
        extracted_content = completion[start_index:end_index].strip()
        return extracted_content.strip("")[1:-1]
    else:
        print("Markers not found in the input string.")

currentFlow = bootstrapQuery
user_input  = ""
while user_input!="quit":
    user_input = input("Enter Query Below: ")
    if user_input == "quit":
        break
    currentFlow = currentFlow+" \n Question: "+ user_input
    result = getChatCompletion(currentFlow)
    currentFlow += result
    # PAUSE implies it is looking for external help via services, ex: Database calls, HTTP end points..
    if "PAUSE" in result:
        query = parseQuery(result)
        data = getData(query)
        currentFlow = currentFlow+"\nResult: "+ data
        ans = getChatCompletion(currentFlow)
        print(ans)
        drawGraphWrapper(data)
    else:
        print(result)
