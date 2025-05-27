# 📘 Project Summary: Azure Load Balancing and Global Traffic Routing

This project demonstrates the deployment of a highly available, globally accessible web application architecture using Microsoft Azure. The setup spans two main regions (Canada Central and North Europe/Ireland), with a third region (South Africa) used for remote testing. The goal was to ensure resilience, efficient traffic distribution, and global geo-based redirection.

---

##  Regions & Resource Names Used

### 🇨🇦 Canada Central (Region 1)
- **Resource Group:** vbisla-w25-RG
- **Virtual Network:** vbisla-VNet-R1
- **Subnet:** webSubnet-R1
- **Web Servers:**
  - vbisla-canada-webServer1
  - vbisla-canada-webServer2
- **App Gateway:** vbisla-appgw-R1
- **Load Balancer (initial):** vbisla-lb-R1

### 🇮🇪 North Europe (Ireland) - Region 2
- **Virtual Network:** vbisla-VNet-R2
- **Subnet:** webSubnet-R2
- **Web Servers:**
  - vbisla-ireland-webServer1
  - vbisla-ireland-webServer2
- **App Gateway:** vbisla-appgw-R2
- **Load Balancer (initial):** vbisla-lb-R2

### 🇿🇦 South Africa - Region 3
- **VM (for testing only):** vbisla-southafrica-client
- Used to test geo-based routing via Traffic Manager

---

## Network Security Group (NSG) Rules Applied

Each subnet had an NSG attached with the following **inbound rules**:
- **Port 80 (HTTP):** Allowed from Internet (for App Gateway + Load Balancer)
- **Port 3389 (RDP):** Allowed from my IP only (for VM access)
- All other inbound ports were blocked by default.
- Outbound traffic was unrestricted for updates and access.

---

## Load Balancing Configuration (Per Region)

### 🔹 Application Gateway (preferred method)
- Created in both regions
- Configured backend pool with both web servers
- Listener on **Port 80**
- Health probes verified each server’s `/` path
- **Round Robin load balancing** confirmed via App Gateway logs and page refreshes

###  Public IP (Static) associated with App Gateway
- Assigned DNS label for accessibility
- Used in Traffic Manager endpoint configuration

---

##  Azure Traffic Manager (Geo-Routing)

- **Name:** tm-geo-routing.trafficmanager.net
- **Routing Method:** Geographic
- **Endpoint 1:** Canada App Gateway Public IP (mapped to North America)
- **Endpoint 2:** Switzerland App Gateway Public IP (mapped to Europe + other)

Each endpoint was monitored using:
- Protocol: HTTP
- Port: 80
- Path: `/` (root URL)

Traffic Manager automatically routed users based on geographic location:
- Users from Canada → routed to Canada App Gateway
- Users from Europe or elsewhere → routed to Ireland App Gateway

---

## How I Verified Routing & Load Balancing

###  Round Robin Test
- Opened regional App Gateway DNS in browser
- Refreshed multiple times → saw alternating content from each web server (unique HTML pages)
- Stopped one VM → tested that traffic still routed to the healthy server

### Geo-Routing Test
- Connected South Africa client VM via Bastion
- Used `nslookup` and `curl` to access `tm-geo-routing.trafficmanager.net`
- Verified traffic was redirected to the nearest region
- Also used external tools like [GeoPeeker](https://www.geopeeker.com)

---

##  Conclusion

This project offered hands-on experience in setting up resilient, globally distributed infrastructure in Azure, including:

- Multi-region deployments
- Load balancing at Layer 7 with App Gateway
- Geographic DNS-based redirection using Traffic Manager
- Secure access via Bastion
- Custom IIS setup for visible testing

The solution ensures **redundancy, regional failover, and optimized latency** for users across the globe.
