FROM      mhart/alpine-node:6.10

# Options:
ARG       NODE_ENV=production
ENV       NODE_ENV $NODE_ENV
ENV       APP_HOME /app

# Install Modules:
WORKDIR   $APP_HOME

# Copy in files:
COPY      . $APP_HOME

EXPOSE    3000
# CMD       ["node", "index.js"]
