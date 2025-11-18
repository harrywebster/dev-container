FROM debian:stable-slim

# Install all necessary packages in one layer
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        docker.io \
        docker-cli \
        docker-compose \
        curl \
        wget \
        git \
        ripgrep \
        openssh-server \
        bash \
        sudo \
        vim \
        tmux \
        jq \
        # Build tools
        gcc \
        g++ \
        make \
        pkg-config \
        # Python stack
        python3 \
        python3-pip \
        python3-venv \
        # PHP
        php \
        php-cli \
        php-curl \
        php-mbstring \
        php-mysql \
        php-pgsql \
        php-sqlite3 \
        php-xml \
        php-zip \
        composer && \
    rm -rf /var/lib/apt/lists/*

# Create sshd runtime dir
RUN mkdir -p /var/run/sshd

# Create developer user with sudo access
RUN useradd -m -s /bin/bash developer && \
    echo "developer ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

COPY motd /etc/motd
COPY .ssh /home/developer/.ssh    

RUN chown -R developer:developer /home/developer/.ssh && \
    chmod 600 /home/developer/.ssh/authorized_keys && \
    chmod 700 /home/developer/.ssh

# Configure SSH: key-only authentication, no passwords
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config && \
    sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config && \
    echo "AllowUsers developer" >> /etc/ssh/sshd_config

# Generate SSH host keys
RUN ssh-keygen -A

# Install Claude Code CLI
RUN \
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - && \
    apt install -y nodejs

RUN sudo su - developer -c "echo 'export PATH=~/project/.npm-global/bin:$PATH' >> ~/.bashrc"

# Expose SSH port
EXPOSE 22

COPY install.sh /usr/local/bin/setup-ai

# Start sshd
CMD ["/usr/sbin/sshd", "-D"]
