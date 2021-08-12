FROM islasgeci/base:0.7.0
COPY . .

RUN pip install \
    tensorflow
