FROM python:2.7.16-jessie

ENV DEBIAN_FRONTEND noninteractive
ENV HASHCAT_VERSION hashcat-5.1.0
ENV HASHCAT_UTILS_VERSION 1.9
ENV TERM xterm

# Update requirements
RUN echo "deb-src http://deb.debian.org/debian jessie main" >> /etc/apt/sources.list
RUN apt-get update && apt-get upgrade -y
RUN apt-get install python3 xterm software-properties-common gawk psmisc isc-dhcp-server zenity binutils hostapd lighttpd ca-certificates gcc php5-cgi php5-common  openssl make kmod nano wget p7zip build-essential libsqlite3-dev libpcap0.8-dev libpcap-dev sqlite3 pkg-config libnl-genl-3-dev libssl-dev net-tools iw ethtool usbutils pciutils wireless-tools git curl wget unzip macchanger tshark pyrit wireshark nmap -y
RUN apt-get build-dep aircrack-ng -y

# Workdir /app/
WORKDIR /app/

# Install mkd3
RUN git clone https://github.com/wi-fi-analyzer/mdk3-master.git
WORKDIR /app/mdk3-master/
RUN make
RUN make install

# Workdir /app/
WORKDIR /app/

# Install Aircrack from Source
RUN wget https://download.aircrack-ng.org/aircrack-ng-1.5.2.tar.gz
RUN tar xzvf aircrack-ng-1.5.2.tar.gz
WORKDIR /app/aircrack-ng-1.5.2/
RUN autoreconf -i
RUN ./configure --with-experimental
RUN make
RUN make install
RUN airodump-ng-oui-update

# Workdir /app/
WORKDIR /app/

# Install wps-pixie
RUN git clone https://github.com/wiire/pixiewps
WORKDIR /app/pixiewps/
RUN make
RUN make install

# Workdir /app/
WORKDIR /app/

# Install hcxdump
RUN git clone https://github.com/ZerBea/hcxdumptool.git
WORKDIR /app/hcxdumptool/
RUN make
RUN make install

# Workdir /app/
WORKDIR /app/

# Install hcxtools
RUN git clone https://github.com/ZerBea/hcxtools.git
WORKDIR /app/hcxtools/
RUN make
RUN make install

# Workdir /app/
WORKDIR /app/

# Install bully
RUN git clone https://github.com/aanarchyy/bully
WORKDIR /app/bully/src/
RUN make
RUN make install

# Workdir /app/
WORKDIR /app/

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

# Workdir /app/
WORKDIR /app/

# Install reaver
RUN git clone https://github.com/gabrielrcouto/reaver-wps.git
WORKDIR /app/reaver-wps/src/
RUN ./configure
RUN make
RUN make install

# Workdir /app/
WORKDIR /app/

# Install cowpatty
RUN git clone https://github.com/roobixx/cowpatty.git
WORKDIR /app/cowpatty/
RUN make

# Workdir /app/
WORKDIR /app/

# Install wifite
RUN git clone https://github.com/derv82/wifite2.git
RUN chmod -R 777 /app/wifite2/
WORKDIR /app/wifite2/
RUN apt-get install rfkill -y

# Workdir /app/
WORKDIR /app/

# Cloning fluxion
RUN git clone https://github.com/wi-fi-analyzer/fluxion.git
RUN chmod -R 777 /app/fluxion/

# Workdir /app/
WORKDIR /app/

# Install wps-scripts
RUN git clone https://github.com/0x90/wps-scripts.git
RUN chmod -R 777 /app/wps-scripts/
WORKDIR /app/wps-scripts/

# clean / optimise docker size
RUN apt-get autoremove -y
RUN apt-get clean
RUN apt-get autoclean
RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /tmp/* /var/tmp/*

# Workdir /app/
WORKDIR /app/
