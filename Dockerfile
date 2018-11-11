FROM ubuntu:16.04

RUN apt-get update \
    && apt-get install -y build-essential git software-properties-common python-software-properties

RUN add-apt-repository -y ppa:bitcoin/bitcoin \
    && apt-get update \
    && apt-get install -y \
	libdb4.8-dev libdb4.8++-dev libtool autotools-dev automake pkg-config libssl-dev libevent-dev \
    bsdmainutils git libboost-all-dev libminiupnpc-dev libqt5gui5 libqt5core5a libqt5webkit5-dev \
	libqt5dbus5 qttools5-dev qttools5-dev-tools \
	libprotobuf-dev protobuf-compiler libqrencode-dev libseccomp-dev libcap-dev

WORKDIR /verge

RUN git clone https://github.com/vergecurrency/VERGE /verge \
    && git checkout 4.0.2a \
    && ./autogen.sh \
    && ./configure \
    && make

RUN ln /verge/src/VERGEd /usr/local/bin/VERGEd

EXPOSE 21102 20102

CMD ["VERGEd"]
