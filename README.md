# 🌍 Load Balancing and Geo-Redundant Website Hosting on Microsoft Azure

This project simulates a real-world cloud infrastructure deployment for a global company website using Microsoft Azure. The architecture ensures **high availability**, **regional failover**, and **efficient global traffic redirection** across multiple regions.

---

## 🎯 Project Objectives

-  Deploy a globally available and redundant company website
-  Host two IIS-based VMs in each region (Canada Central & North Europe)
-  Implement regional **load balancing (App Gateway)** with Round Robin
-  Use **Azure Traffic Manager** to redirect traffic based on user proximity
-  Deploy a **remote client in South Africa** to test geo-routing
-  Document and demonstrate the architecture with screenshots and CLI output

---

## 🌐 Scenario

As a **Cloud Administrator**, my responsibility was to:

- Provision all infrastructure manually through the Azure Portal
- Build secure and redundant web hosting in:
  - 🇨🇦 **Canada Central** (Primary)
  - 🇮🇪 **North Europe / Ireland** (Secondary)
- Route global users to the nearest region using **Azure Traffic Manager (Geographic Routing)**
- Configure **load balancing in each region** using Azure **Application Gateway**
- Deploy a **South Africa client VM** to test proximity-based routing behavior

