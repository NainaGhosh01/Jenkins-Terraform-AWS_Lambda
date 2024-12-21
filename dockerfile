FROM python:3.9-slim
WORKDIR /app
COPY . /app
RUN pip install boto3
EXPOSE 8080
ENV NAME World
CMD ["python", "process_data.py"]
