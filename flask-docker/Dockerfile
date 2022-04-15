FROM python:alpine

# SET WORKDIR FOR CONTAINER
WORKDIR /flask-docker

# COPY req INTO /flask-docker (container-bound)
COPY requirements.txt ./

# INSTALL DEPS 
RUN pip install -r requirements.txt

COPY . .

# RUN FLASK SERVER
CMD ["python3", "app.py"]
