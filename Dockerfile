FROM python:3.9

WORKDIR /code

COPY ./requirements.txt /code/requirements.txt
COPY ./install_talib.sh /code/install_talib.sh

RUN chmod +x /code/install_talib.sh
RUN /code/install_talib.sh

RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# Give user access to write to write in results folder
RUN useradd -m -u 1000 user
USER user
ENV HOME=/home/user PATH=/home/user/.local/bin:$PATH
WORKDIR $HOME/app
COPY --chown=user . $HOME/app

# Run the application:
CMD ["python", "-u", "app.py"]
