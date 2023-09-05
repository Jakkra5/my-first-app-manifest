apiVersion: v1
kind: Service
metadata:
  labels:
    app: my-first-app
  name: my-first-app
spec:
  type: ClusterIP
  ports:
    - port: 80
      targetPort: 80
  selector:
    app: my-first-app
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: my-first-app
  name: my-first-app
spec:
  selector:
    matchLabels:
      app: my-first-app
  replicas: 1
  template:
    metadata:
      labels:
        app: my-first-app
    spec:
      containers:
      - image: <image>
        name: my-first-app
        ports:
        - containerPort: 80
          name: http
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-first-app
spec:
  ingressClassName: nginx
  rules:
  - host: <JK>.training.dnsfor.me
    http:
      paths:
      - backend:
          service:
            name: my-first-app
            port:
              number: 80
        path: /
        pathType: Prefix
