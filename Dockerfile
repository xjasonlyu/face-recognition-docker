FROM python:3.8-slim
LABEL org.opencontainers.image.source="https://github.com/xjasonlyu/face-recognition-docker"

ARG DEBIAN_FRONTEND="noninteractive"

ARG DLIB_VERSION="v19.21"

RUN apt-get -y update \
    && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    && apt-get autoclean \
    && rm -rf /tmp/* /var/tmp/*

RUN git clone --single-branch --branch ${DLIB_VERSION} https://github.com/davisking/dlib.git \
    && cd dlib/ \
    && python3 setup.py install --no USE_AVX_INSTRUCTIONS --no DLIB_USE_CUDA \
    && cd ../ && rm -rf dlib/

RUN git clone --depth 1 https://github.com/ageitgey/face_recognition.git \
    && cd face_recognition/ \
    && pip3 install -r requirements.txt \
    && python3 setup.py install \
    && cd ../ && rm -rf face_recognition/
