#docker build --platform linux/amd64 -t my-app .
#docker run my-app
FROM ubuntu:22.04

# Set environment variables
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# Install required packages
RUN apt-get update && \
    apt-get install -y python3.9 python3-pip
WORKDIR /app
# install FreeTDS and dependencies
RUN apt-get update \
 && apt-get install unixodbc -y \
 && apt-get install unixodbc-dev -y \
 && apt-get install freetds-dev -y \
 && apt-get install freetds-bin -y \
 && apt-get install tdsodbc -y \
 && apt-get install --reinstall build-essential -y
# populate "ocbcinst.ini" as this is where ODBC driver config sits
RUN echo "[FreeTDS]\n\
Description = FreeTDS Driver\n\
Driver = /usr/lib/x86_64-linux-gnu/odbc/libtdsodbc.so\n\
Setup = /usr/lib/x86_64-linux-gnu/odbc/libtdsS.so" >> /etc/odbcinst.ini

#Pip command without proxy setting
ADD requirements.txt .
RUN pip3 install -r requirements.txt
ADD . .
#ADD logs.txt .
CMD ["python3","-u","queryServer.py"]
EXPOSE 8000/tcp
EXPOSE 8000/udp
