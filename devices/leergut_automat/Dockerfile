
#version of python 
FROM python:3

#duplicate files/directories in a speficied location in their existing format
COPY . /device

#defining working directory of a docker container at any time
WORKDIR /device

#installing the needed dependencies to run AWS IoT Python
RUN pip install AWSIoTPythonSDK

#starting the main.py using the terminal (indiviually defined for each device)
CMD [ "python", "./main.py" ]
