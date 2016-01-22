#Shipping Service API
This project is built on top of the (ActiveShipping gem)[https://github.com/Shopify/active_shipping], providing an easy to use interface for getting **shipping rates** from various shipping carriers. It currently supports the following shipping carriers:
- (UPS)[https://www.ups.com/]
- (USPS)[https://www.usps.com/]

#Accessing the API
The API can be accessed at https://botsy-shipping.herokuapp.com/ through the two endpoints:
- https://botsy-shipping.herokuapp.com/ups_rates  
- https://botsy-shipping.herokuapp.com/usps_rates

To access the API, post a request to one of the endpoints with a JSON with valid data for a package's origin, destination, and package dimensions

##Example JSON
```
{ "origin" :
    {"country" : "US","state" : "WA","city" : "Seattle","postal_code" : "98102"},
  "destination" :
    {"country" : "US","state" : "CA","city" : "Los Angeles","postal_code" : "90024"},
  "package" :
    {"weight" : 20,"length" : 10,"width" : 10,"height" : 10, "cylinder" : false}
}
```

###Example curl request

```
curl -H "Content-Type: application/json" -X POST --data '{ "origin" : {"country" : "US","state" : "WA","city" : "Seattle","postal_code" : "98102"},"destination" : {"country" : "US","state" : "CA","city" : "Los Angeles","postal_code" : "90024"},"package" : {"weight" : 20,"length" : 10,"width" : 10,"height" : 10, "cylinder" : false}}' https://botsy-shipping.herokuapp.com/ups_rates
```

###Example HTTParty request
```
HTTParty.post("https://botsy-shipping.herokuapp.com/ups_rates",
  :headers => { 'Content-Type' => 'application/json' },
  :body => {
    "origin" => {"country" : "US","state" : "WA","city" : "Seattle","postal_code" : "98102"}, "destination" => {"country" : "US","state" : "CA","city" : "Los Angeles","postal_code" : "90024"},  
    "package" => @{"weight" : 20,"length" : 10,"width" : 10,"height" : 10, "cylinder" : false} }.to_json)
```

###Sample response
```
[ ["UPS Ground",1198],
  ["UPS Three-Day Select",1767],
  ["UPS Second Day Air",2354],
  ["UPS Next Day Air Saver",5462],
  ["UPS Next Day Air",5922],
  ["UPS Next Day Air Early A.M.",9050]
]
```

#Running the API Locally
