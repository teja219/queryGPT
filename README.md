

### Update SQL file and start HTTP server on docker


Modify the ```db/mssql/db-init.sql``` file with the tables and data you need

```
docker pull --platform linux/amd64 ubuntu:18.04

docker pull --platform linux/amd64 mcr.microsoft.com/mssql/server

sudo docker-compose build

sudo docker-compose up

```

### Start the chat bot
Update the openAi key in openAiCompletion.py

```openai.api_key = "<insert_token_here>"```

Install virtualenv
```
pip install virtualenv
```

Create virtual env in your project folder

```
python3 -m venv myenv

virtualenv myenv

```

Activate virtual env

```
source myenv/bin/activate
```

Install dependencies

```
pip3 install openai
pip3 install matplotlib
```

Run the bot

```
python3 openAICompletion.py

```

### Next Steps/Ideas

1. Build a better UI - Angular, D3 charts, Ag Grid 
2. Make the bot dynamic - Automatically fetch schemas
3. Address Privacy Issues - Ask user for approval before sending data, example: Analyze button, do not send large data
4. Explore Langchain and see how it can be used to scale
5. Make it a plugin based model, currently it support Databases, we can create an interface so that it is easy to add other services: Emails,Web Search, Document Search etc
