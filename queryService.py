import pyodbc






def connect_to_mssql(query):
    server = 'mssql'
    port = 1433
    database = 'master'
    username = 'sa'
    password = 'Query063@'

    connection_string = f"Driver=FreeTDS;SERVER={server};PORT={port};DATABASE={database};UID={username};PWD={password}"
    
    connection = pyodbc.connect(connection_string, autocommit=True)
    return executeConnection(connection,query)
        

def executeConnection(connection,query):
    try:
        print("Connected to SQL database")

        cursor = connection.cursor()
        cursor.execute(query)
        columns = [column[0] for column in cursor.description]
        results = cursor.fetchall()

        cursor.close()
        connection.close()

        return columns,results

    except:
        return None

