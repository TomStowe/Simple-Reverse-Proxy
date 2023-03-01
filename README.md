# 🔄 Simple Reverse Proxy 🔄
A simple reverse proxy solution built on the Golang httputil module 

## ⚙️ Setup
1. Download the latest build from the releases section on the GitHub page
2. Unzip the files
3. Update the config specified below
4. Run the relevant file for your OS

## ✅ Config
When using the simple reverse proxy, the following options can be set in the `config.ini` file. A default config has been included to provide extra clarity
|         Config Option        	|                   Description                             	                                                                                  |   Type  	| Required 	|
|:---------------------------:	|:----------------------------------------------------------------------------------------------------------------------------------------------: |:-------:	|:--------:	|
| `port`                      	|      The port that the proxy server is run on               	                                                                                  |  String 	|     Y    	|
| `noProxyPagePath`          	|      The html file to display if no proxy has been specified for the requested domain                                                           |  String 	|     N    	|
| `[PROXY_NAME]`            	| A section of the ini config file that represents a given proxy                                                                                  |  String   	|     Y    	|
|  `domain`               	    |The domain to detect to trigger the proxy                                                                                                        |  String    	|     Y    	|
|  `proxy`                 	    |The host to proxy to                                                                                                                             |  String  	|     Y    	|
|  `errorPagePath`  	        |If a 500 error occurs on a specific server being proxied to, this page will be shown if it is present                                            |  String    	|     N    	|

## 👨‍💻 Local Dev
1. Run `go run main.go` to run the reverse proxy in development mode

## 👷 Building
Building is automated using GitHub Actions
   
## 🎓 Licence
This software is released under the [GNU AGPLv3](LICENSE) licence

## 👨 The Author
[Please click here to see more of my work!](https://tomstowe.co.uk)