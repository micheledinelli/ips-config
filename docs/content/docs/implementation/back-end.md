---
weight: 202
title: "Back-end"
description: ""
icon: "deployed_code"
date: "2024-06-12T21:53:20+02:00"
lastmod: "2024-06-12T21:53:20+02:00"
toc: true
---

The back-end is built with Flask and Python, containerized using Docker. It relies on Gunicorn as a Web Server Gateway Interface (WSGI). WSGI is a standard that specifies a universal interface between web servers and web applications or frameworks. Gunicorn is a popular WSGI HTTP server that can run any WSGI-compliant Python web application. It is lightweight and efficient, with capabilities such as autonomous worker process management, load balancing, and reporting. Back-end offers APIs for room access management and indoor positioning estimation. Back-end communicates with a MongoDB instance to store and load data. Back-end has also two environments: development (or local) and production.

The development environment consists of two entities: the back-end Flask application and a MongoDB database running in a Docker container. The MongoDB Docker container can be bound to any port; however, the chosen port must be specified in the Flask application's configuration file in order to connect them.

## Development

```mermaid
graph LR

    client1(client \n fa:fa-desktop)
    client2(client \n fa:fa-mobile)

    subgraph Development
        backend(Back-end \n fa:fa-server)
        database(MongoDB \n fa:fa-database)
    end

    client1 -- 127.0.0.1:8888/rooms --> backend
    client2 -- 127.0.0.1:8888/position --> backend
    backend -- mongodb://127.0.0.1:27017 --> database

   classDef plain fill:#ddd,stroke:#fff,stroke-width:4px,color:#000;
   classDef k8s fill:#326ce5,stroke:#fff,stroke-width:4px,color:#fff;
   classDef cluster fill:#fff,stroke:#bbb,stroke-width:2px,color:#326ce5;
   class database k8s;
   class Cluster cluster;
   class client1,client2 plain

```

## Production

```mermaid
graph LR
    subgraph K8s
        class Cluster cluster;

        frontend(Front-end \n fa:fa-desktop)
        backend-service(Back-end service)
        database-service(Database service)
        dns(DNS server \n fa:fa-server)

        backend(Back-end pod \n fa:fa-server)
        database(Database \n fa:fa-database)
    end

    frontend -- 10.98.71.135:8888/api/devices --> backend-service
    backend-service -- Who is database? --> dns -- database.default.svc.cluster.local \n at 10.99.70.111 --> backend-service
    backend-service -- /api/devices --> backend -- query --> database-service --> database

    classDef plain fill:#ddd,stroke:#fff,stroke-width:4px,color:#000;
    classDef k8s fill:#326ce5,stroke:#fff,stroke-width:4px,color:#fff;
    classDef cluster fill:#fff,stroke:#bbb,stroke-width:2px,color:#326ce5;
    class frontend,backend-service,dns,backend,database-service,database k8s;
    class Cluster cluster;
    class user plain;
```

The production environment refers to a K8s cluster. Like the front-end, the back-end has its own GitHub repository with a configured Continuous Integration method that generates a Docker image each time the main branch is updated.
