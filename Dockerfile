FROM llllollooll/zig:master AS builder

WORKDIR /app

COPY . .

RUN apt-get update && apt-get install -y --no-install-recommends libpq-dev
RUN zig build -Doptimize=ReleaseSmall

FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends libpq5 curl
WORKDIR /app
COPY --from=builder /app/zig-out/bin/spiderme /app/spiderme
EXPOSE 3000
CMD ["./spiderme"]
