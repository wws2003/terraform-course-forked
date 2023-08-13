[
  {
    "essential": true,
    "memory": 256,
    "name": "myapp",
    "cpu": 256,
    "image": "${REPOSITORY_URL}:v1",
    "workingDirectory": "/app",
    "command": ["node", "index.js"],
    "portMappings": [
        {
            "containerPort": 3000,
            "hostPort": 3000
        }
    ]
  }
]

