# Based on vintagestory docker file from `https://github.com/snook9/vintagestory-docker`

# Dotnet runtime
FROM mcr.microsoft.com/dotnet/runtime:8.0

EXPOSE 42420

ARG USERNAME=vintagestory
ARG VSUID=1001
ARG VSGID=1001
ARG VSPATH=/home/vintagestory/server
ARG DATAPATH=/var/vintagestory/data

# CDN settings for downloading server files
ARG VSCDN=https://cdn.vintagestory.at/gamefiles/stable 
ARG FILENAME=vs_server_linux-x64_1.21.5.tar.gz

# Install dependencies
RUN apt-get update -q -y && \
  apt-get install -yf \
  screen \
  wget \
  curl \
  vim \
  procps \
  screen

# Set up user
RUN groupadd ${USERNAME} -g ${VSGID} && \
  useradd -ms /bin/bash ${USERNAME} -l -u ${VSUID} -g ${VSGID} && \
  mkdir -p ${VSPATH} && \
  chown -R ${USERNAME}:${VSGID} ${VSPATH} && \
  mkdir -p ${DATAPATH} && \
  chown -R ${USERNAME}:${VSGID} ${DATAPATH}

# Vintage story server setup
WORKDIR ${VSPATH}

# Download server binary
RUN wget --progress=dot:giga ${VSCDN}/${FILENAME}
COPY ./launch-server.sh ${VSPATH}

RUN tar xzf ${FILENAME} && \
  chown -R ${USERNAME}:${VSGID} ${VSPATH} && \
  chmod +rx ./server.sh && \
  chmod +rx ./launch-server.sh && \
  rm -f ${FILENAME}

# Change user
USER ${USERNAME}

# Start the server
ENTRYPOINT ["./launch-server.sh"]

