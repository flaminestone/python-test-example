FROM python
RUN mkdir /python-test-example
WORKDIR /python-test-example
ADD . /python-test-example