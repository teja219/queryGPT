import matplotlib.pyplot as plt
import ast

def drawGraphWrapper(data):
    yes = input("Do you want to draw a Bar graph ? Y/N: \n")
    if yes=="Y":
        resulting_rows = process_input_string(data)
        create_bar_graph(resulting_rows)
    else:
        return
def create_bar_graph(data):
    # Convert the input data string to a list of dictionaries
    data = eval(str(data).strip(" "))

    # Get the available column names from the first dictionary
    available_columns = list(data[0].keys())

    print("Available columns:", available_columns)

    # Prompt the user to choose columns for the x-axis and y-axis
    x_column = input("Choose a column for the x-axis: ")
    y_column = input("Choose a column for the y-axis: ")

    # Extract x-axis and y-axis data
    x_data = [entry[x_column] for entry in data]
    y_data = [entry[y_column] for entry in data]

    # Create a bar graph
    plt.bar(x_data, y_data)
    plt.xlabel(x_column)
    plt.ylabel(y_column)
    plt.title(f"Bar Graph: {y_column} vs {x_column}")
    plt.show()




def process_input_string(input_string):
    # Parse the string into a Python object
    parsed_tuple = ast.literal_eval(input_string)

    # Extract the column names and the empty list
    column_names, data = parsed_tuple

    # Convert the list of columns into a list of rows (each row being a dictionary)
    rows = [dict(zip(column_names, row_values)) for row_values in data]

    # Return the resulting list of rows
    return rows

