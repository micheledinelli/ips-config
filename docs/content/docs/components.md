---
weight: 200
title: "Components"
description: ""
icon: "deployed_code"
date: "2024-06-12T21:08:16+02:00"
lastmod: "2024-06-12T21:08:16+02:00"
toc: true
---

{{< tabs tabTotal="4">}}
{{% tab tabName="Front-end" %}}

The front-end manages the rooms.

Administrators can grant users access and add/remove devices for a specific room through the front-end interface.

The front-end also shows a live view of the building where users were last seen.

It is written in React.js (v18.2.0) and built with Vite (v5.2.0), a JavaScript build tool for serving and bundling apps.

![alt](images/screenshot-home.png)

{{% /tab %}}
{{% tab tabName="Mobile application" %}}

The mobile application is developed using Flutter (v3.22.0).

The mobile application employs Bluetooth low energy (BLE) signal analysis to track the distance between personal security devices and the smartphone on which it runs.

It sends periodic location requests to the backend, to determine whether or not the user is allowed to stay in certain areas.

{{% /tab %}}
{{% tab tabName="Back-end" %}}

The back-end is responsible for the estimation of user's position in the building.

It uses a WiFi fingerprinting approach to predict a user's location. It relies on the strength of the WiFi signals from access points (AP) around the mobile app.

Back-end is developed using Python (v3.10.7) and Flask (v3.0.3) as framework.

{{% /tab %}}
{{% tab tabName="Database" %}}
The database stores information about rooms, users and personal security devices. It is a non-relational database (MongoDB v7.0.9).
{{% /tab %}}
{{< /tabs >}}
