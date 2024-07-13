FROM archlinux:latest

# Create a new user 'parzival' with a home directory and sudo privileges
RUN pacman -Syu --noconfirm
RUN pacman -S ansible sudo --noconfirm

RUN useradd -m -G wheel -s /bin/bash parzival && \
    echo 'parzival:arch' | chpasswd && \
    echo 'parzival ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers;

# Switch to user 'parzival'
USER parzival
WORKDIR /home/parzival

# Copy setup file
COPY /ansible /home/parzival

# Set environment variable
ENV LANG=C.UTF-8

# Default command to run an interactive shell
CMD ["/bin/bash"]
