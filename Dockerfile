FROM node:21-bookworm AS ios-debug


# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update the package list and install necessary dependencies
RUN apt-get update && \
    apt-get install -y \
    autoconf \
    automake \
    build-essential \
    libusb-1.0-0-dev \
    libplist-dev \
    libtool \
    libssl-dev \
    git \
    pkg-config \
    udev 

# Clone and build libplist
RUN git clone https://github.com/libimobiledevice/libplist.git && \
    cd libplist && \
    ./autogen.sh && \
    make && \
    make install


# https://github.com/libimobiledevice/libtatsu
RUN apt-get install -y \
    libcurl4 \
    libcurl4-openssl-dev

RUN git clone https://github.com/libimobiledevice/libtatsu && \
    cd libtatsu && \
    ./autogen.sh && \
    make && \
    make install

# Clone and build libimobiledevice-glue
RUN apt-get install -y \
    build-essential \
    pkg-config \
    checkinstall \
    git \
    autoconf \
    automake \
    libtool-bin \
    libplist-dev

RUN git clone https://github.com/libimobiledevice/libimobiledevice-glue.git && \
    cd libimobiledevice-glue && \
    ./autogen.sh && \
    make && \
    make install

# Clone and build libusbmuxd
RUN git clone https://github.com/libimobiledevice/libusbmuxd.git && \
    cd libusbmuxd && \
    ./autogen.sh && \
    make && \
    make install

# Clone and build libimobiledevice
RUN git clone https://github.com/libimobiledevice/libimobiledevice.git && \
    cd libimobiledevice && \
    ./autogen.sh && \
    make && \
    make install

# Clone and build usbmuxd
RUN git clone https://github.com/libimobiledevice/usbmuxd.git && \
    cd usbmuxd && \
    ./autogen.sh && \
    make && \
    make install

# Clone and build ios-webkit-debug-proxy
RUN git clone https://github.com/google/ios-webkit-debug-proxy.git && \
    cd ios-webkit-debug-proxy && \
    ./autogen.sh && \
    make && \
    make install


RUN ldconfig

# Install himbeer's fork of ios-webkit-debug-proxy
RUN git clone https://github.com/HimbeersaftLP/ios-safari-remote-debug-kit.git && \
    cd ios-safari-remote-debug-kit/src && \
    ./generate.sh -p -i 17.4


RUN npm install -g http-server

COPY ./start.sh /ios-safari-remote-debug-kit/src/start.sh
COPY ./index.html /ios-safari-remote-debug-kit/src/WebKit/Source/WebInspectorUI/UserInterface/index.html
RUN chmod +x /ios-safari-remote-debug-kit/src/start.sh
EXPOSE 8080
WORKDIR /ios-safari-remote-debug-kit/src
ENV PORT=9332
ENV HOST=localhost
ENTRYPOINT [ "./start.sh" ]

