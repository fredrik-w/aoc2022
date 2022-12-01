FROM dart:2.18-sdk AS build

WORKDIR /
RUN dart create app
COPY ./ /app
WORKDIR /app
RUN dart compile exe solution.dart -o solution.bin

FROM alpine
COPY --from=build /app/solution.bin .
COPY input.txt .
CMD solution.bin
