FROM golang:1.15.7

# Set working directory where we build tha app
WORKDIR /build

# Copy and download dependency using go mod
COPY go.mod .
COPY go.sum .
RUN go mod download

# App the code into the working dir
COPY . .

# Build the application
RUN go build -o main .

# Move to /app directory as the place for resulting binary folder
WORKDIR /app

# Copy binary from build to main folder
RUN cp /build/main .
RUN cp -R /build/templates .

# Set exposed port
EXPOSE 3000

# Command to run app when start the container
CMD ["/app/main"]