# Stage 1: Build Stage
FROM nginx:alpine AS builder
COPY ./app /usr/share/nginx/html

# Stage 2: Final Production Stage
FROM nginx:alpine
# Copy only the files from the builder
COPY --from=builder /usr/share/nginx/html /usr/share/nginx/html

# Add a Healthcheck to tell Docker if the site is actually working
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost/ || exit 1

EXPOSE 80
