# Stage 1: Build stage with Ubuntu
FROM ubuntu AS builder

# Install Git and any other necessary dependencies
RUN apt-get update && \
    apt-get install -y git

# Clone the OCA repository to the mnt/extra-addons folder
RUN git clone https://github.com/OCA/dms.git /mnt/extra-addons -b 16.0

# Stage 2: Production stage with Odoo base image
FROM odoo:16.0

# Copy the module from the builder stage
COPY --from=builder /mnt/extra-addons /mnt/extra-addons
