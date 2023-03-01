# Colour for logs
COLOUR='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

version=$1

# Make the publish directory
mkdir pub

# Build the go file
printf "${COLOUR}Building Project${NC}\n"
printf "${YELLOW}\tBuilding Windows amd64${NC}\n"
GOOS=windows GOARCH=amd64 go build -o pub/reverseproxy-windows-amd64.exe reverseproxy
printf "${YELLOW}\tBuilding Windows 386${NC}\n"
GOOS=windows GOARCH=386 go build -o pub/reverseproxy-windows-386.exe reverseproxy
printf "${YELLOW}\tBuilding Linux 386${NC}\n"
GOOS=linux GOARCH=386 go build -o pub/reverseproxy-linux-386 reverseproxy
printf "${YELLOW}\tBuilding Linux amd64${NC}\n"
GOOS=linux GOARCH=amd64 go build -o pub/reverseproxy-linux-amd64 reverseproxy
printf "${YELLOW}\tBuilding Linux arm${NC}\n"
GOOS=linux GOARCH=arm go build -o pub/reverseproxy-linux-arm reverseproxy
printf "${YELLOW}\tBuilding Linux arm64${NC}\n"
GOOS=linux GOARCH=arm64 go build -o pub/reverseproxy-linux-arm64 reverseproxy
printf "${YELLOW}\tBuilding Linux ppc64${NC}\n"
GOOS=linux GOARCH=ppc64 go build -o pub/reverseproxy-linux-ppc64 reverseproxy
printf "${YELLOW}\tBuilding Linux ppc64le${NC}\n"
GOOS=linux GOARCH=ppc64le go build -o pub/reverseproxy-linux-ppc64le reverseproxy
printf "${YELLOW}\tBuilding Linux mips${NC}\n"
GOOS=linux GOARCH=mips go build -o pub/reverseproxy-linux-mips reverseproxy
printf "${YELLOW}\tBuilding Linux mipsle${NC}\n"
GOOS=linux GOARCH=mipsle go build -o pub/reverseproxy-linux-mipsle reverseproxy
printf "${YELLOW}\tBuilding Linux mips64${NC}\n"
GOOS=linux GOARCH=mips64 go build -o pub/reverseproxy-linux-mips64 reverseproxy
printf "${YELLOW}\tBuilding Linux mips64le${NC}\n"
GOOS=linux GOARCH=mips64le go build -o pub/reverseproxy-linux-mips64le reverseproxy

# Copy the Correct Files
printf "${COLOUR}Copying to Files${NC}\n"
cp README.md pub/README.md
cp config.ini pub/config.ini
cp -r templateErrorPages pub/templateErrorPages

printf "${COLOUR}Backend Published${NC}\n"