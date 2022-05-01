FROM rust as builder

ADD . /libsignal
WORKDIR /libsignal/rust/protocol/fuzz

RUN rustup toolchain add nightly
RUN rustup default nightly
RUN cargo +nightly install -f cargo-fuzz

RUN cargo +nightly fuzz build

FROM ubuntu:20.04

COPY --from=builder /libsignal/rust/protocol/fuzz/target/x86_64-unknown-linux-gnu/release/interaction /
COPY --from=builder /libsignal/rust/protocol/fuzz/target/x86_64-unknown-linux-gnu/release/interaction.d /
