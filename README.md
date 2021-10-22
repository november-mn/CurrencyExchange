# CurrencyExchange
To run the Currency Exchange app

1. Clone the project using the url
2. Add Config.xcconfig file to the root folder of the project
3. Add following code into the Config.xcconfig, replace [your_exchangeratesapi_access_key] with your access_key of exchangeratesapi
     ACCESS_KEY = [your_exchangeratesapi_access_key]
     BASE_URL = api.exchangeratesapi.io/v1/latest
4. Go to the terminal and cd to the project folder, then run command "pod install"
5. Build and run
