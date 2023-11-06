FROM ubuntu:latest
RUN apt-get update -y
RUN apt-get install -y python3-pip python-dev-is-python3
WORKDIR /miapp
ENV TEST=True
EXPOSE 5000
VOLUME /datos_miapp
COPY . /miapp
RUN pip install -r requisitos.txt
ENTRYPOINT ["python"]
CMD ["miapp.py"]
