.PHONY: all clean windows linux darwin

# Variables
CGO_ENABLED := 0
SRC := .
RELEASE := release_mk
FRPC := frpc.go
FRPS := frps.go
LDFLAGS := "-w -s"

# Default target
all: windows linux darwin

# Windows AMD64
windows:
	export CGO_ENABLED=$(CGO_ENABLED); \
	export GOOS=windows; \
	export GOARCH=amd64; \
	mkdir -p  $(RELEASE); \
	go build -ldflags $(LDFLAGS) -o $(RELEASE)/frpc.exe $(SRC)/$(FRPC); \
	go build -ldflags $(LDFLAGS) -o $(RELEASE)/frps.exe $(SRC)/$(FRPS); \
	export GOARCH=386; \
	go build -ldflags $(LDFLAGS) -o $(RELEASE)/frpc32.exe $(SRC)/$(FRPC); \
	go build -ldflags $(LDFLAGS) -o $(RELEASE)/frps32.exe $(SRC)/$(FRPS);

# Linux AMD64
linux:
	export CGO_ENABLED=$(CGO_ENABLED); \
	export GOOS=linux; \
	export GOARCH=amd64; \
	mkdir -p  $(RELEASE); \
	go build -ldflags $(LDFLAGS) -o $(RELEASE)/frpc $(SRC)/$(FRPC); \
	go build -ldflags $(LDFLAGS) -o $(RELEASE)/frps $(SRC)/$(FRPS);
	echo "Building  ARM"
	export GOOS=linux; \
	export GOARCH=arm64; \
	mkdir -p  $(RELEASE); \
	go build -ldflags $(LDFLAGS) -o $(RELEASE)/frpc_arm $(SRC)/$(FRPC); \
	go build -ldflags $(LDFLAGS) -o $(RELEASE)/frps_arm $(SRC)/$(FRPS);

# Darwin (macOS) AMD64
darwin:
	export CGO_ENABLED=$(CGO_ENABLED); \
	export GOOS=darwin; \
	export GOARCH=amd64; \
	mkdir -p  $(RELEASE); \
	go build -ldlags $(LDFLAGS) -o $(RELEASE)/frpc_darwin $(SRC)/$(FRPC); \
	go build -ldflags $(LDFLAGS) -o $(RELEASE)/frps_darwin $(SRC)/$(FRPS);

# Clean up the release directory
clean:
	rm -rf  $(RELEASE)
