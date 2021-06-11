#   ########################################################################
#   Copyright 2021 Splunk Inc.
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
#   ######################################################################## 
ARG BASEIMAGE=ort
FROM $BASEIMAGE

RUN apt install software-properties-common ;\
    add-apt-repository ppa:deadsnakes/ppa ;\
    apt-get update ;\
    apt install python3.7-full python3.8-full python3.9-full python3.9-dev -y

RUN pip3 install --upgrade setuptools ;\
    pip3 install --upgrade pip ;\
    pip3 install --upgrade distlib 
RUN curl https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py 

RUN python3.7 /tmp/get-pip.py --upgrade setuptools
RUN python3.8 /tmp/get-pip.py --upgrade setuptools
RUN python3.9 /tmp/get-pip.py --upgrade setuptools
RUN pip3 install virtualenv==20.2.2 pipenv
RUN pip3.7 install virtualenv==20.2.2 pipenv
RUN pip3.8 install virtualenv==20.2.2 pipenv

RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 -
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3.7 -
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3.8 -

COPY entrypoint.sh /entrypoint.sh

COPY custom root/.ort
WORKDIR /github/workspace
ENTRYPOINT ["/entrypoint.sh"]
