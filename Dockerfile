FROM zeek/zeek:latest

USER root
RUN apt install apt-transport-https ca-certificates

RUN cat > /etc/apt/sources.list <<EOF
# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm main contrib
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm main contrib

deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-updates main contrib
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-updates main contrib

deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-backports main contrib
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-backports main contrib

# 以下安全更新软件源包含了官方源与镜像站配置，如有需要可自行修改注释切换
deb https://security.debian.org/debian-security bookworm-security main contrib
# deb-src https://security.debian.org/debian-security bookworm-security main contrib
EOF


RUN apt-get -q update \
 && apt-get install -q -y --no-install-recommends \
     curl \
     bind9 \
     bison \
     ccache \
     cmake \
     flex \
     g++ \
     gcc \
     make \
     python3 \
    python3-dev \
    python3-pip \
    libssl-dev \
    libpcap-dev \
    openssh-client \
    openssh-server 
RUN curl -L https://github.com/edenhill/librdkafka/archive/v1.4.4.tar.gz | tar xvz
WORKDIR /librdkafka-1.4.4/

RUN pwd

RUN ./configure --enable-sasl
RUN make
RUN make install

WORKDIR /

RUN git clone https://github.com/SeisoLLC/zeek-kafka.git
WORKDIR /zeek-kafka/
RUN ./configure --with-librdkafka=$librdkafka_root
RUN make
RUN make install
RUN ldconfig

RUN zkg autoconfig --force
RUN zeek -N Seiso::Kafka

CMD ["/usr/sbin/sshd", "-D"]






