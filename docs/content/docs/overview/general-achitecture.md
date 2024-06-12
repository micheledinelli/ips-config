---
weight: 101
title: "General architecture"
description: ""
icon: "article"
date: "2024-06-04T15:57:03+02:00"
lastmod: "2024-06-04T15:57:03+02:00"
toc: true
---

The system consists four components:

- Web application (front-end)
- Mobile application
- Server-side application (back-end)
- Database.

Except for the mobile application, all components are containerized with Docker and orchestrated by Kubernetes.

```mermaid
graph TB

    user1(User \n fa:fa-mobile)
    user2(User \n fa:fa-mobile)
    user3(User \n fa:fa-mobile)

subgraph Cluster
class Cluster cluster;
ingress-backend(Ingress back-end)
subgraph "Service back-end"
service-backend(Back-end \n fa:fa-server)
end
subgraph "Pod back-end 1"
pod-backend1(Flask-Gunicorn \n fa:fa-server)
end
subgraph "Pod back-.end 2"
pod-backend2(Flask-Gunicorn \n fa:fa-server)
end

        dns(DNS server \n fa:fa-server)

        ingress-frontend(Ingress front-end)
        subgraph "Service front-end"
            service-frontend(Front-end \n fa:fa-desktop)
        end
        subgraph "Pod front-end 1"
            pod-frontend1(Vite+React-Nginx \n fa:fa-desktop)
        end
        subgraph "Pod front-end 2"
            pod-frontend2(Vite+React-Nginx \n fa:fa-desktop)
        end

        subgraph "Service database"
            service-database(MongoDB \n fa:fa-database)
        end
        subgraph "Pod database"
            pod-database[(MongoDB \n fa:fa-database)]
        end

        %% subgraph Volumes
        %%     fingerprint-data(fingerprint Data)
        %%     mongo(mongoDB)
        %% end
    end

    user1 -.-> ingress-backend
    user2 -.-> ingress-backend
    user3 -.-> ingress-backend

    user1 -.-> ingress-frontend
    user2 -.-> ingress-frontend
    user3 -.-> ingress-frontend

    ingress-backend --> service-backend;
    service-backend -- 8888/TCP --> pod-backend1
    service-backend -- 8888/TCP --> pod-backend2

    ingress-frontend --> service-frontend;
    service-frontend -- 80/TCP --> pod-frontend1
    service-frontend -- 80/TCP --> pod-frontend2

    pod-frontend1 -. nslookup .-> service-backend
    pod-frontend2 -. nslookup .-> service-backend

    pod-backend1 -. nslookup .-> service-database
    pod-backend2 -. nslookup .-> service-database

    service-database -- 27017/TCP --> pod-database

    pod-frontend1 -- 53/TCP --> dns
    pod-frontend2-- 53/TCP --> dns
    pod-backend1 -- 53/TCP --> dns
    pod-backend2 -- 53/TCP --> dns

classDef plain fill:#ddd,stroke:#fff,stroke-width:4px,color:#000;
classDef k8s fill:#326ce5,stroke:#fff,stroke-width:4px,color:#fff;
classDef cluster fill:#fff,stroke:#bbb,stroke-width:2px,color:#326ce5;
class service-backend,service-frontend,service-database,pod-backend1,pod-backend2,pod-frontend1,pod-frontend2,pod-database,dns k8s;
class Cluster cluster;
class user1,user2,user3 plain

```
