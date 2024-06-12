---
weight: 300
title: "How to Run"
description: ""
icon: "rocket_launch"
date: "2024-06-12T22:25:03+02:00"
lastmod: "2024-06-12T22:25:03+02:00"
toc: true
draft: true
---

This is a short guide to launch the project.

To run the production environment you'll need Docker and Kubernetes, this guide uses Minikube.

To run the mobile application you'll need also an Android Emulator or a physical Android device as well as Flutter sdk.

To run the back-end you'll need Python.

To run the front-end you'll need node and npm.

{{< tabs tabTotal="2">}}
{{% tab tabName="Local" %}}

## Front-end

Clone [front-end repository](https://github.com/micheledinelli/ips-fe).

Install dependencies and simply run it.

## Back-end

## Database

## Mobile application

{{% /tab %}}
{{% tab tabName="Cluster" %}}

The mobile application is developed using Flutter (v3.22.0).

The mobile application employs Bluetooth low energy (BLE) signal analysis to track the distance between personal security devices and the smartphone on which it runs.

It sends periodic location requests to the backend, to determine whether or not the user is allowed to stay in certain areas.

{{% /tab %}}
{{< /tabs >}}
