FROM alpine:latest
# intial setup
WORKDIR /root
# Installing packages and python liberaries
RUN apk add --no-cache bash python3 py3-pip git nmap
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt
# Installing searchexploit
RUN git clone https://github.com/offensive-security/exploitdb.git /opt/exploitdb
RUN sed 's|path_array+=(.*)|path_array+=(“/opt/exploitdb”)|g' /opt/exploitdb/.searchsploit_rc >> ~/.searchsploit_rc
RUN ln -sf /opt/exploitdb/searchsploit /usr/local/bin/searchsploit
# Pull my tools website and change into it
COPY pythontools pythontools
WORKDIR /root/pythontools
# Run the web app
EXPOSE 5000
CMD python3 app.py