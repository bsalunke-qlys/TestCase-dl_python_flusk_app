FROM python:3.5 AS build-env

#RUN apt-get update && apt-get install -y python3.5 python3-dev python3-pip nginx
# We copy just the requirements.txt first to leverage Docker cache
#WORKDIR /app
COPY ./requirements.txt .
RUN pip install -r ./requirements.txt


FROM gcr.io/distroless/python3
ADD ./app.tar ./ 
COPY --from=build-env  /usr/local/lib/python3.5/site-packages/ /usr/lib/python3.5/
WORKDIR /app
ENTRYPOINT [ "python3.5" ]
CMD [ "/app/main.py" ]
