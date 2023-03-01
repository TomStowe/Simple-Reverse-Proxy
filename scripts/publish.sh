# Colour for logs
COLOUR='\033[0;32m'
NC='\033[0m' # No Color

version=$1

# Make the publish directory
mkdir pub

# Build the go file
printf "${COLOUR}Building Project${NC}\n"
go build reverseproxy

# Copy the Correct Files
printf "${COLOUR}Copying t Files${NC}\n"
cp README.md pub/README.md
cp config.ini pub/config.ini
cp reverseproxy.exe pub/reverseproxy.exe
cp -r templateErrorPages pub/templateErrorPages

printf "${COLOUR}Backend Published${NC}\n"