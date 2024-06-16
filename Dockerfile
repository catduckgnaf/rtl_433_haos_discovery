ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base-python:3.12-alpine3.18
FROM ${BUILD_FROM} as builder

ARG rtl433GitRevision=23.11

RUN wget https://raw.githubusercontent.com/tds04/Rtl_433-Discovery/main/rtl_433_mqtt_hass.py -O rtl_433_mqtt_hass.py

FROM ${BUILD_FROM}

COPY --from=builder rtl_433_mqtt_hass.py .
COPY run.sh .

RUN \
    pip install \
        --no-cache-dir \
        --prefer-binary \
        paho-mqtt==2.1.0 \
    \
    && chmod a+x /run.sh

CMD [ "/run.sh" ]
