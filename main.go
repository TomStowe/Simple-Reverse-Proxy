package main

import (
	"github.com/labstack/echo"
	"gopkg.in/ini.v1"
	"net/http"
	"net/http/httputil"
	"net/url"
	"strings"
	"fmt"
	"os"
)

type Config struct {
	port string
	noProxyPagePath string
	proxies map[string]*Proxy
}

type Proxy struct {
	host string
	url *url.URL
	proxy *httputil.ReverseProxy
	errorPagePath string
}

func LoadConfig() Config {
	var proxies = map[string]*Proxy{}

	// Read the config
	fmt.Println("Loading Config File")
	cfg, err := ini.Load("config.ini")
	if err != nil {
		fmt.Printf("Fail to read the config file: %v", err)
		os.Exit(1)
	}

	// Load the generic config
	port := cfg.Section("").Key("port").String()
	noProxyPagePath := cfg.Section("").Key("noProxyPagePath").String()

	sections := cfg.Sections()
	for _, section := range sections{
		if section.HasKey("domain") && section.HasKey("proxy"){			
			domain := section.Key("domain").String()
			proxyString := section.Key("proxy").String()
			url, _ := url.Parse(proxyString)
			proxy := httputil.NewSingleHostReverseProxy(url)

			// If an error handling page has been provided, setup the error handler
			errorPagePath := section.Key("errorPagePath").String()
			if errorPagePath != ""{
				proxy.ErrorHandler = func(res http.ResponseWriter, req *http.Request, err error) {
					fmt.Println("The following error occurred when serving a page for domain " + domain + "\n\t" + err.Error())
					http.ServeFile(res, req, errorPagePath)
				}  
			}

			proxies[domain] = &Proxy {
				host: proxyString,
				url: url,
				proxy: proxy,
			}
		}
	}

	fmt.Println("Config Loaded")

	return Config {
		port: port,
		noProxyPagePath: noProxyPagePath,
		proxies: proxies,
	}
}


func main() {
	config := LoadConfig()

	e := echo.New()

	reverseProxyRoutePrefix := "/"
	routerGroup := e.Group(reverseProxyRoutePrefix)
	routerGroup.Use(func(handlerFunc echo.HandlerFunc) echo.HandlerFunc {
	    return func(context echo.Context) error {

			req := context.Request()
			res := context.Response().Writer

			proxy, ok := config.proxies[context.Request().Host]

			if !ok {
				fmt.Println("Received connection at " + context.Request().Host + " but no proxy config was found for this domain")
				
				if (config.noProxyPagePath != "") {
					http.ServeFile(res, req, config.noProxyPagePath)
				}else {
					res.WriteHeader(http.StatusServiceUnavailable)
				}
				return nil;
			}

			// Update the headers to allow for SSL redirection
			req.Host = proxy.url.Host
			req.URL.Host = proxy.url.Host
			req.URL.Scheme = proxy.url.Scheme

			//trim reverseProxyRoutePrefix
			path := req.URL.Path
			req.URL.Path = strings.TrimLeft(path, reverseProxyRoutePrefix)

			// ServeHttp is non blocking and uses a go routine under the hood
			proxy.proxy.ServeHTTP(res, req)
			return nil
	    }
	})

	fmt.Println("Server Listening")
	e.Start(":" + config.port)
}