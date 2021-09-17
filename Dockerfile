FROM ubuntu:20.04

# Fix tzdata issue on 20.04
ENV TZ=Etc/GMT
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && apt-get install -y sudo wget cmake build-essential git autoconf libtool pkg-config

WORKDIR /build

RUN GRPC_HEALTH_PROBE_VERSION=v0.3.2 && \
  wget -qO/bin/grpc_health_probe https://github.com/grpc-ecosystem/grpc-health-probe/releases/download/${GRPC_HEALTH_PROBE_VERSION}/grpc_health_probe-linux-amd64 && \
  chmod +x /bin/grpc_health_probe

COPY . .

RUN git clone https://github.com/abseil/abseil-cpp.git
WORKDIR /build/abseil-cpp/build
RUN cmake .. -DCMAKE_INSTALL_PREFIX=/build/absl -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE
RUN cmake --build . --target install

WORKDIR /build/bin
RUN cmake ../ -DgRPC_INSTALL=ON \
  -DCMAKE_PREFIX_PATH=/build/absl \
  -DCMAKE_BUILD_TYPE=Release \
  -DgRPC_ABSL_PROVIDER=package \
  -DgRPC_CARES_PROVIDER=module \
  -DgRPC_PROTOBUF_PROVIDER=module \
  -DgRPC_RE2_PROVIDER=module \
  -DgRPC_SSL_PROVIDER=module \
  -DgRPC_ZLIB_PROVIDER=module
RUN make -j4
RUN make install