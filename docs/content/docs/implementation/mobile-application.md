---
weight: 204
title: "Mobile Application"
description: ""
icon: "deployed_code"
date: "2024-06-12T22:14:22+02:00"
lastmod: "2024-06-12T22:14:22+02:00"
toc: true
---

The mobile application represents is developed using Flutter and targets only Android devices, which is a result of Apple's strict guidelines on WiFi scanning from within an application sandbox.

[See also](positioning-api.md)

The mobile application periodically scan the surrounding environment looking for Bluetooth Low Energy (BLE) devices and WiFi access points. Then it sends localization request to the back-end providing WiFi APs information such as Service Set Identifier (SSID) and RSS for each AP, BLE devices information and the user identifier. The back-end predicts device's current position and updates user's last seen position in the database. If the user, carrying the smartphone, enters a place where they are not allowed, leaves a place where they are allowed but have forgotten to bring their protective device, or leaves a location where they are authorized but have forgotten to bring their protective device, the mobile application will eventually display notifications. Notification types can be customized from the front-end.

```mermaid
block-beta
  columns 3
  a("ROOM A \n fa:fa-user"):2 ap1("fa:fa-wifi")
  block:group1:2
    columns 1
    b("ROOM B") ap2("fa:fa-wifi")
  end
  c("ROOM C fa:fa-lock \n fa:fa-helmet-safety")
  block:group2:3
    columns 5
    d("ROOM D") ap3("fa:fa-wifi") e("ROOM E fa:fa-lock \n fa:fa-mask-face")
  end

classDef plain fill:#ddd,stroke:#326ce5,stroke-width:4px,color:#000;
classDef k8s fill:#326ce5,stroke:#fff,stroke-width:4px,color:#fff;
class ap1,ap2,ap3 plain
```
