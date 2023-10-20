FROM rust:latest as builder
ENV APP helloactixweb
WORKDIR /usr/src/$APP
COPY . .
RUN cargo build --release

FROM gcr.io/distroless/cc-debian12
#RUN apt-get update && rm -rf /var/lib/apt/lists/*
ENV APP helloactixweb
COPY --from=builder /usr/src/$APP/target/release/helloactixweb /usr/$APP/helloactixweb
#COPY --from=builder /usr/src/$APP/target/release/build /usr/$APP/build
#COPY --from=builder /usr/src/$APP/target/release/deps /usr/$APP/deps
#export this actix web service to port 8080 and 0.0.0.0
EXPOSE 8080
WORKDIR /usr/$APP
CMD ["./helloactixweb"]
