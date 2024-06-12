---
weight: 201
title: "Front-end"
description: ""
icon: "deployed_code"
date: "2024-06-12T21:42:33+02:00"
lastmod: "2024-06-12T21:42:33+02:00"
toc: true
---

The front-end is built with Vite and React.js, containerized using Docker. Vite is a JavaScript build tool that provides a fast development experience by using a development server with hot module replacement (HMR) enabling instant reloading while developing. The front-end communicates with the back-end using application programming interfaces (APIs). Front-end provides a simple user interface for managing room access, it also offers live map of the user's approximate position inside the building and supports customized notifications settings. The front-end has two separate environments: development (or local) and production. The development environment is based on Vite's built-in proxy server, which routes requests beginning with /api to a static address defined in the environment configuration. The development environment has no distribution folder (there is no build-time), and the front-end is served by the Vite server.

## Development environment

```mermaid
graph LR

    user1(user)
    user2(user)
    user3(user)

   subgraph Development
       class Cluster cluster;

        subgraph Frontend
            frontend(Vite server \n fa:fa-server)
            react(React.js)
        end
       backend(Backend \n fa:fa-server)
    end

    user1 -- 127.0.0.1:8080/api/rooms --> frontend -- 127.0.0.1:8888/api/rooms --> backend
    user2 -- 127.0.0.1:8080/live --> frontend -- look for route /live --> react
    user3 -- 127.0.0.1:8080/rooms/3 --> frontend -- look for route /rooms/:id  --> react

   classDef plain fill:#ddd,stroke:#fff,stroke-width:4px,color:#000;
   classDef k8s fill:#326ce5,stroke:#fff,stroke-width:4px,color:#fff;
   classDef cluster fill:#fff,stroke:#bbb,stroke-width:2px,color:#326ce5;
   class service-backend,service-frontend,service-database,pod-backend1,pod-backend2,pod-frontend1,pod-frontend2,pod-database,dns k8s;
   class Cluster cluster;
   class user1,user2,user3 plain

```

## Production environment

```mermaid
graph TD

    user1(client)
    %% user2(user)
    %% user3(user)

    subgraph K8s
        class Cluster cluster;

        subgraph FrontendPod[Front-end pod]
            ngnix(Ngnix \n fa:fa-server)
            react(React.js)
        end

        dns(DNS server \n fa:fa-server)
        frontend-ingress(Front-end ingress)
        frontend(Front-end service)
        backend(Back-end service \n fa:fa-server)
    end

    user1 -- /api/rooms --> frontend-ingress -- /api/rooms ---> frontend -- api/rooms --> ngnix
    user1 -- /live ---> frontend-ingress -- /live --> frontend -- /live --> ngnix
    ngnix -->|who is backend?| dns
    dns -->|backend.default.svc.cluster.local \n at 10.98.71.135| ngnix
    ngnix -->|10.98.71.135:8888/api/rooms| backend
    ngnix -->|look for route /live| react

    classDef plain fill:#ddd,stroke:#fff,stroke-width:4px,color:#000;
    classDef k8s fill:#326ce5,stroke:#fff,stroke-width:4px,color:#fff;
    classDef cluster fill:#fff,stroke:#bbb,stroke-width:2px,color:#326ce5;
    class backend,frontend,ngnix,react,dns k8s;
    class Cluster cluster;
    class user1,user2,user3 plain;

```

The production environment refers to a K8s cluster. When the front-end is deployed in production, it is containerized, and Ngnix serves as both an HTTP server and a reverse proxy. The Docker image contains a build of the front-end that is loaded into Ngnix and begins serving. Ngnix routes all requests beginning with /api to the backend service in the K8s cluster. When a request starting with /api is intercepted the Ngnix server has to route the request to the backend discovering its address inside the cluster. In order to do that it asks to the Domain Name System (DNS) where is the backend service

The front-end project has its own repository on GitHub. To smoothly update the production environment, the front-end uses GitHub actions to generate a new docker image each time the repository's main branch is changed. The docker image may be pulled directly into K8s, delivering the most recent version of the software within the cluster (the pull policy defined for the front-end deployment is set to always pull the latest image from the container registry).
