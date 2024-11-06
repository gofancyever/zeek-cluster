# Zeek Docker Client

This repository contains a Docker setup for running Zeek with Kafka integration. The setup includes a `Dockerfile` for building the Docker image and a `deploy.sh` script for deploying the Zeek configuration.

## Dockerfile

The `Dockerfile` is used to create a Docker image with the following features:

- **Base Image**: Uses the latest Zeek image as the base.
- **APT Configuration**: Configures APT to use Tsinghua University's Debian mirrors for faster package updates.
- **Package Installation**: Installs necessary packages such as `curl`, `bind9`, `bison`, `ccache`, `cmake`, `flex`, `g++`, `gcc`, `make`, `python3`, and others.
- **librdkafka**: Downloads and installs `librdkafka` version 1.4.4.
- **Zeek-Kafka Plugin**: Clones and installs the Zeek-Kafka plugin.
- **SSH Configuration**: Generates SSH keys for secure access.
- **Entrypoint**: Sets `/deploy.sh` as the entrypoint script.

## deploy.sh

The `deploy.sh` script is responsible for:

- **Starting Zeek**: Launches Zeek with specific policies in the background.
- **Deploying Configuration**: Uses `zeek-client` to deploy the configuration specified in `/usr/local/zeek/etc/zeek-client.cfg`.
- **Process Management**: Waits for all background processes to complete.

## Usage

1. **Build the Docker Image**:
   ```shell
   docker build -t zeek-client .
   ```

2. **Run the Docker Container**:
   ```shell
   docker run -d zeek-client
   ```

3. **Access the Container**:
   You can access the running container using SSH or Docker exec commands.

## Notes

- Ensure that the `deploy.sh` script is executable before building the Docker image.
- The SSH keys generated are stored in `/root/.ssh` within the container. Handle them securely.
- The Zeek-Kafka plugin requires `librdkafka` to be installed and configured correctly.

## License

This project is licensed under the MIT License. See the LICENSE file for details.
