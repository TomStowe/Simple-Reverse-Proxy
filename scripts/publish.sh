# Colour for logs
COLOUR='\033[0;32m'
NC='\033[0m' # No Color

version=$1

# Make the publish directory
mkdir pub

# Build the go file
printf "${COLOUR}Building Project${NC}\n"
GOOS=windows GOARCH=amd64 go build -o pub/reverseproxy-windows-amd64.exe reverseproxy
GOOS=windows GOARCH=386 go build -o pub/reverseproxy-windows-386.exe reverseproxy
GOOS=linux GOARCH=386 go build -o pub/reverseproxy-linux-386 reverseproxy
GOOS=linux GOARCH=amd64 go build -o pub/reverseproxy-linux-amd64 reverseproxy
GOOS=linux GOARCH=arm go build -o pub/reverseproxy-linux-arm reverseproxy
GOOS=linux GOARCH=arm64 go build -o pub/reverseproxy-linux-arm64 reverseproxy
GOOS=linux GOARCH=ppc64 go build -o pub/reverseproxy-linux-ppc64 reverseproxy
GOOS=linux GOARCH=ppc64le go build -o pub/reverseproxy-linux-ppc64le reverseproxy
GOOS=linux GOARCH=mips go build -o pub/reverseproxy-linux-mips reverseproxy
GOOS=linux GOARCH=mipsle go build -o pub/reverseproxy-linux-mipsle reverseproxy
GOOS=linux GOARCH=mips64 go build -o pub/reverseproxy-linux-mips64 reverseproxy
GOOS=linux GOARCH=mips64le go build -o pub/reverseproxy-linux-mips64le reverseproxy

# Copy the Correct Files
printf "${COLOUR}Copying to Files${NC}\n"
cp README.md pub/README.md
cp config.ini pub/config.ini
cp -r templateErrorPages pub/templateErrorPages

printf "${COLOUR}Backend Published${NC}\n"