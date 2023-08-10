import pyodbc


def connect_to_mssql(query):
    server = 'sql-server-container'
    port = 1433
    database = 'property_info'
    username = 'sa'
    password = '<password>'

    connection_string = f"Driver=FreeTDS;SERVER={server};PORT={port};DATABASE={database};UID={username};PWD={password}"

    try:
        connection = pyodbc.connect(connection_string, autocommit=True)
        print("Connected to MSSQL database")

        cursor = connection.cursor()
        cursor.execute(query)
        columns = [column[0] for column in cursor.description]
        results = cursor.fetchall()

        cursor.close()
        connection.close()

        return columns,results

    except pyodbc.Error as err:
        print(f"Error: {err}")
        return None
