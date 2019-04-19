FROM debian

ENV HASHCAT_VERSION hashcat-5.1.0
ENV HASHCAT_UTILS_VERSION  1.9

# Update requirements
RUN apt-get update && apt-get upgrade -y
RUN apt-get install python python3-pip python3 python-dev ca-certificates gcc openssl make kmod nano wget p7zip build-essential libsqlite3-dev libpcap0.8-dev libpcap-dev sqlite3 pkg-config libnl-genl-3-dev libssl-dev net-tools iw ethtool usbutils pciutils wireless-tools git curl wget unzip macchanger tshark wireshark -y
RUN apt-get build-dep aircrack-ng -y

# Install pyrit
RUN RUN git clone https://github.com/JPaulMora/Pyrit.git
WORKDIR /Pyrit/
RUN pip install psycopg2
RUN apt-get install python-scapy
RUN python setup.py clean
RUN python setup.py build
RUN python setup.py install

# Workdir /
WORKDIR /

# Install Aircrack from Source
RUN wget https://download.aircrack-ng.org/aircrack-ng-1.5.2.tar.gz
RUN tar xzvf aircrack-ng-1.5.2.tar.gz
WORKDIR /aircrack-ng-1.5.2/
RUN autoreconf -i
RUN ./configure --with-experimental
RUN make
RUN make install
RUN airodump-ng-oui-update

# Workdir /
WORKDIR /

# Install wps-pixie
RUN git clone https://github.com/wiire/pixiewps
WORKDIR /pixiewps/
RUN make
RUN make install

# Workdir /
WORKDIR /

# Install hcxdump
RUN git clone https://github.com/ZerBea/hcxdumptool.git
WORKDIR /hcxdumptool/
RUN make
RUN make install

# Workdir /
WORKDIR /

# Install hcxtools
RUN git clone https://github.com/ZerBea/hcxtools.git
WORKDIR /hcxtools/
RUN make
RUN make install

# Workdir /
WORKDIR /

# Install bully
RUN git clone https://github.com/aanarchyy/bully
WORKDIR /bully/src/
RUN make
RUN make install

# Workdir /
WORKDIR /

#Install and configure hashcat
RUN mkdir /hashcat

#Install and configure hashcat: it's either the latest release or in legacy files
RUN cd /hashcat && \
  wget --no-check-certificate https://hashcat.net/files/${HASHCAT_VERSION}.7z && \
  7zr x ${HASHCAT_VERSION}.7z && \
  rm ${HASHCAT_VERSION}.7z

RUN cd /hashcat && \
  wget https://github.com/hashcat/hashcat-utils/releases/download/v${HASHCAT_UTILS_VERSION}/hashcat-utils-${HASHCAT_UTILS_VERSION}.7z && \
  7zr x hashcat-utils-${HASHCAT_UTILS_VERSION}.7z && \
  rm hashcat-utils-${HASHCAT_UTILS_VERSION}.7z

#Add link for binary
RUN ln -s /hashcat/${HASHCAT_VERSION}/hashcat64.bin /usr/bin/hashcat
RUN ln -s /hashcat/hashcat-utils-${HASHCAT_UTILS_VERSION}/bin/cap2hccapx.bin /usr/bin/cap2hccapx

# Workdir /
WORKDIR /

# Install reaver
RUN git clone https://github.com/gabrielrcouto/reaver-wps.git
WORKDIR /reaver-wps/src/
RUN ./configure
RUN make
RUN make install

# Workdir /
WORKDIR /

# Install cowpatty
RUN git clone https://github.com/roobixx/cowpatty.git
WORKDIR /cowpatty/
RUN make

# Workdir /
WORKDIR /

# Install wifite
RUN git clone https://github.com/derv82/wifite2.git
RUN chmod -R 777 /wifite2/
WORKDIR /wifite2/
RUN apt-get install rfkill -y

# Workdir /
WORKDIR /

# Install fluxion
WORKDIR /fluxion/
RUN wget https://raw.githubusercontent.com/FluxionNetwork/fluxion/master/install/install.sh && bash install.sh

# Workdir /
WORKDIR /

# Install wps-scripts
RUN git clone https://github.com/0x90/wps-scripts.git
RUN chmod -R 777 /wps-scripts/
WORKDIR /wps-scripts/

# Workdir /
WORKDIR /

# Install Beef
RUN git clone https://github.com/beefproject/beef.git
RUN chmod -R 777 /beef/
WORKDIR /beef/
RUN ./install

# Workdir /
WORKDIR /
