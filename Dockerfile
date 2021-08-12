FROM islasgeci/base:0.7.0
COPY . .
RUN apt update && apt install --yes \
    gnuplot
