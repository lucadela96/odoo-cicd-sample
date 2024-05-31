# Stage 1: Build stage with Ubuntu
FROM ubuntu AS builder

# Install Git and any other necessary dependencies
RUN apt-get update && \
    apt-get install -y git

# Clone the OCA repository to the mnt/extra-addons folder
RUN git clone https://github.com/OCA/dms.git /mnt/extra-addons/dms -b 14.0
RUN git clone https://github.com/OCA/server-backend.git /mnt/extra-addons/server-backend -b 14.0
RUN git clone https://github.com/OCA/payroll.git /mnt/extra-addons/payroll -b 14.0
RUN git clone https://github.com/OCA/purchase-workflow.git /mnt/extra-addons/purchase-workflow -b 14.0
RUN git clone https://github.com/OCA/reporting-engine.git /mnt/extra-addons/reporting-engine -b 14.0
RUN git clone https://github.com/OCA/field-service.git /mnt/extra-addons/field-service -b 14.0

# Stage 2: Production stage with Odoo base image
FROM odoo:14.0

# Copy Odoo configuration file
COPY ./odoo.conf /etc/odoo/

# Copy the module from the builder stage
COPY --from=builder /mnt/extra-addons /mnt/extra-addons
