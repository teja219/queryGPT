import http.server
import socketserver
import urllib.parse
from queryService import connect_to_mssql
# Define the port you want the server to run on
port = 8080

# Create a request handler class by inheriting from http.server.BaseHTTPRequestHandler
class MyRequestHandler(http.server.BaseHTTPRequestHandler):
    def do_POST(self):
        content_length = int(self.headers['Content-Length'])
        post_data = self.rfile.read(content_length)

        parsed_data = post_data.decode('utf-8')
        print("QUERY..")
        print(parsed_data)
        print("QUERY..END")
        self.send_response(200)
        self.send_header('Content-type', 'text/plain')
        self.end_headers()

        if self.path == "/query":
            response_message = connect_to_mssql(parsed_data)
        else:
            response_message = "Unknown POST request"


        self.wfile.write(str(response_message).encode('utf-8'))

# Configure the server with the chosen port and request handler
with socketserver.TCPServer(("", port), MyRequestHandler) as server:
    print(f"Serving at http://localhost:{port}")
    server.serve_forever()
