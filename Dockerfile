FROM python:3.9-slim

# Set the working directory
WORKDIR /code

# Copy the current directory contents into the container at /code
COPY ./requirements.txt /code/requirements.txt

RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# Copy the current directory contents into the container at /code
COPY ./app /code/app

RUN uname -m

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "80"]