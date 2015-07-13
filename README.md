# Build A PC
Reference this API documention as necessary.  It details all available endpoints with path parameters and HTTP request verbs.  Have fun!
##User Register
	New users must provide an email, username and password. They will be granted an access_token upon registration which must then be passed in the header for all future requests.
* Path: `POST '/users/register'`
* Params:
  * email: string
  * password: string
  * username: string
* Response:
  * Status Code: 201 if successful, 422 if unsuccessful
  * Example success:

  ```
    {
  "user": {
    "id": 1,
    "full_name": Tyler Jones
    "username": "tylerjones",
    "email": "tylerjones@email.com",
    "access_token": "c4483f576226dbb213074bfa207412a1"
  }
}

 ```
* Example Failure:

```
{
"errors": [
  "Email has already been taken",
  "Username has already been taken"
]
}
```

##User Login
* Path: `POST '/users/login'`
* Params:
* password: a string
* username: a string
* Response:
* Status Code: 201 if successful, 404 if not found
* Example success:

```
  {
"user": {
  "id": 1,
  "username": "tjterris",
  "email": "tjterris@gmail.com",
  "access_token": "c4483f576226dbb213074bfa207412a1"
}
}

```
* Example failure:

```
  {
"message": "No matching username or password found."
}
```

##Parts
  Call the part by the name of the part you want.
* Path: `GET 'parts/cpu'`
  ```
  [
{
"manufacturer": "AMD",
"name": "AMD - A10-7700K 3.4GHz Processor - Black",
"details": {
  "Model Compatibility": "DDR3 2133",
  "Additional Accessories Included": "Heat sink and fan",
  "Processor Cores": "10-core",
  "Compatible Platform(s)": "Windows|Mac|Linux",
  "Processor Speed": "3.4 gigahertz",
  "Color Category": "Black",
  "Cache Memory": "4 megabytes",
  "Brand Compatibility": "AMD",
  "ENERGY STAR Certified": "No",
  "Processor Socket": "Socket FM2+",
  "Integrated Graphics": "Yes",
  "Cache Level": "L2",
  "Turbo Core Processor Speed": "3.8 gigahertz",
  "Graphics": "AMD Radeon R7",
  "pricematch": "yes"
  },
"shortDescription": "AMD A10-7700K 3.4GHz Processor: 4MB L2 cache; HSA (Heterogeneous System Architecture); GCN (Graphics Core Next) architecture; AMD Mantle and TrueAudio technologies; for Windows, Mac and Linux computers",
"salePrice": 123.99,
"customerReviewAverage": null,
"url": "http://www.bestbuy.com/site/amd-a10-7700k-3-4ghz-processor-black/1865059.p?id=1219517899254&skuId=1865059"
}
  ]
 ```
 ## Available Parts Calls
  * cpu, ram, motherboard, psu, gpu, hard_drive, solid_state, and computer_case
