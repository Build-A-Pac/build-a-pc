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


##Available Parts Calls

* cpu, ram, motherboard, psu, gpu, hard_drive, solid_state, and computer_case

#Categories for Parts

* All Categories contain:
	* manufacturer
	* name
	* salePrice
	* url
	* sku
	* categoryPath
* CPU
	* Processor Cores
	* Processor Speed
	* Processor Socket
* GPU
	* GPU Clock Speed
	* Video Memory Capacity
* RAM
	* Type of Memory (RAM)
	* Storage Capacity
* Motherboard
	* Number Of Memory Slots
	* Processor Compatibility
	* Maximum Memory Supported
	* Processor Socket
	* Form Factor
* PSU
	* Wattage
* Hard_drive
	* Hard Drive Capacity
	* Internal Or External
	* Maximum Data Transfer Rate
* Solid_State
	* Hard Drive Capacity
	* Internal Or External
* Computer_Case
	* Case Typer
	* Power Supply

##Computer
* Path: `POST '/computer/create'`
* Params:
	* computer_name
	* parts

* Path: `POST '/computer/build'`
* Params:
	* max_price

```
{
  "total_price": 1720.93,
  "parts": [
    {
      "cpu": {
        "id": 308,
        "name": "9907183",
        "make": "Intel®",
        "model": "Intel® - Core™ i7-5820K 3.3GHz Processor - Multi",
        "category": "abcat0507010",
        "cost": 399.99,
        "store_url": "http://www.bestbuy.com/site/intel-core-i7-5820k-3-3ghz-processor-multi/9907183.p?id=1219446415830&skuId=9907183",
        "created_at": "2015-07-21T14:54:43.961Z",
        "updated_at": "2015-07-21T14:54:43.961Z",
        "details": {
          "Model Compatibility": "Intel LGA2011-v3",
          "Processor Cores": "6-core",
          "Compatible Platform(s)": "Windows|Linux",
          "Processor Speed": "3.3 gigahertz",
          "Minimum System Requirements": "Not Applicable",
          "Color Category": "Multi",
          "Generation": "5th Gen",
          "Cache Memory": "15 megabytes",
          "Brand Compatibility": "Intel",
          "ENERGY STAR Certified": "No",
          "Processor Socket": "Socket LGA 2011-v3",
          "Turbo Boost Processor Speed": "3.6 gigahertz",
          "Integrated Graphics": "No",
          "Cache Level": "L3",
          "pricematch": "yes"
        }
      },
      "motherboard": {
        "id": 316,
        "name": "1290032",
        "make": "Gigabyte",
        "model": "Gigabyte - ATX Motherboard 2400/2666/2800/3000MHz (Socket LGA 2011-v3) - Multi",
        "category": "abcat0507008",
        "cost": 290.99,
        "store_url": "http://www.bestbuy.com/site/gigabyte-atx-motherboard-2400-2666-2800-3000mhz-socket-lga-2011-v3-multi/1290032.p?id=1219484417447&skuId=1290032",
        "created_at": "2015-07-21T14:54:44.002Z",
        "updated_at": "2015-07-21T14:54:44.002Z",
        "details": {
          "Number of USB Connectors": "16",
          "Number Of Memory Slots": "8",
          "Processor Compatibility": "Intel",
          "Model Compatibility": "Intel Core i7 Exteme Edition processors",
          "Color Category": "Multi",
          "Brand Compatibility": "Intel",
          "Maximum Memory Supported": "64 gigabytes",
          "Processor Socket": "Socket LGA 2011",
          "Memory Slot Type": "288-pin DIMM",
          "Computer Connectivity": "Windows",
          "Form Factor": "ATX",
          "Additional Accessories Included": "6 SATA cables, I/O shield, 2-way SLI bridge connector, two 3-way SLI bridge connectors, 4-way SLI bridge connector, 2-way crossfire bridge connector, 1-to-3 power cable",
          "Maximum Speed": "3000 megahertz",
          "pricematch": "yes"
        }
      },
      "ram": {
        "id": 411,
        "name": "1397327",
        "make": "PNY",
        "model": "PNY - 8GB PC3-12800 DDR3 Desktop Memory - Multi",
        "category": "abcat0506000",
        "cost": 75.99,
        "store_url": "http://www.bestbuy.com/site/pny-8gb-pc3-12800-ddr3-desktop-memory-multi/1397327.p?id=1219051117285&skuId=1397327&cmp=RMX&ky=2aTnwdq5C4jpifk2PoIq1D1Cz1sbgj4vH",
        "created_at": "2015-07-21T14:54:44.449Z",
        "updated_at": "2015-07-21T14:54:44.449Z",
        "details": {
          "Speed": "1600 megahertz",
          "Pin Configuration": "240",
          "Color Category": "Multi",
          "Computer Compatibility": "Universal",
          "Type of Memory (RAM)": "PC3-12800 DDR3",
          "Storage Capacity": "8 gigabytes"
        }
      },
      "storage": {
        "id": 519,
        "name": "1660001",
        "make": "Samsung",
        "model": "Samsung - 850 PRO 256GB Internal SATA III Solid State Drive - Black",
        "category": "pcmcat201300050005",
        "cost": 141.99,
        "store_url": "http://www.bestbuy.com/site/samsung-850-pro-256gb-internal-sata-iii-solid-state-drive-black/1660001.p?id=1219507979079&skuId=1660001&cmp=RMX&ky=2aTnwdq5C4jpifk2PoIq1D1Cz1sbgj4vH",
        "created_at": "2015-07-21T14:54:44.910Z",
        "updated_at": "2015-07-21T14:54:44.910Z",
        "details": {
          "Hard Drive Capacity": "256 gigabytes",
          "Color Category": "Black",
          "Minimum System Requirements": "PC: Windows Server 2003 (32- or 64-bit with SP2 or later), Server 2008 (32- or 64-bit), XP (SP2 or later), Vista (SP1 or later), 7 (32- or 64-bit) or 8 (32- or 64-bit)",
          "Form Factor": "2.5 in.",
          "Internal Or External": "Internal",
          "Interface(s)": "SATA",
          "Maximum Data Transfer Rate": "550 megabytes per second"
        }
      },
      "gpu": {
        "id": 351,
        "name": "6916327",
        "make": "MSI",
        "model": "MSI - NVIDIA GeForce GTX 980 4GB GDDR5 SDRAM PCI Express 3.0 Graphics Card - Black/Red",
        "category": "abcat0507002",
        "cost": 571.99,
        "store_url": "http://www.bestbuy.com/site/msi-nvidia-geforce-gtx-980-4gb-gddr5-sdram-pci-express-3-0-graphics-card-black-red/6916327.p?id=1219667167590&skuId=6916327",
        "created_at": "2015-07-21T14:54:44.187Z",
        "updated_at": "2015-07-21T17:50:53.678Z",
        "details": {
          "Card Size": "Standard",
          "Cooling System": "Air",
          "Connection Type": "Internal",
          "Featured Technology": "NVIDIA SLI",
          "Output(s)": "HDMI|DisplayPort|DVI",
          "Video Card Type": "Gaming",
          "Brand Compatibility": "Universal",
          "Computer Compatibility": "Windows",
          "GPU Clock Speed": "1220 megahertz",
          "DVD Decoding": "No",
          "Model Compatibility": "Universal",
          "Processor Type(s)": "NVIDIA GeForce GTX 980",
          "Video Memory Type": "GDDR5|SDRAM",
          "Number Of Processors": "1",
          "Maximum Number of Displays Supported": "4",
          "Interface(s)": "PCI Express 3.0",
          "Video Memory Capacity": "4 gigabytes",
          "Color Category": "Multi",
          "Graphics Processing Unit (GPU)": "NVIDIA GeForce GTX 980",
          "4K Ultra HD Resolution Support": "Yes",
          "Maximum Digital Display Resolution": "4096 x 2160",
          "pricematch": "yes"
        }
      },
      "computer_case": {
        "id": 546,
        "name": "8028014",
        "make": "Nanoxia",
        "model": "Nanoxia - Deep Silence 5 XL-ATX and eATX Full-Tower Case - Black",
        "category": "abcat0507006",
        "cost": 139.99,
        "store_url": "http://www.bestbuy.com/site/nanoxia-deep-silence-5-xl-atx-and-eatx-full-tower-case-black/8028014.p?id=1219307886105&skuId=8028014&cmp=RMX&ky=2aTnwdq5C4jpifk2PoIq1D1Cz1sbgj4vH",
        "created_at": "2015-07-21T16:05:09.894Z",
        "updated_at": "2015-07-21T16:05:09.898Z",
        "details": {
          "Enclosure Type": "Full tower",
          "Color Category": "Black",
          "Brand Compatibility": "Universal",
          "Model Compatibility": "Universal",
          "pricematch": "yes"
        }
      },
      "psu": {
        "id": 451,
        "name": "5416092",
        "make": "VisionTek",
        "model": "VisionTek - Modular Series 700W Internal Power Supply - Black",
        "category": "abcat0507009",
        "cost": 99.99,
        "store_url": "http://www.bestbuy.com/site/visiontek-modular-series-700w-internal-power-supply-black/5416092.p?id=1218642138744&skuId=5416092",
        "created_at": "2015-07-21T14:54:44.612Z",
        "updated_at": "2015-07-21T14:54:44.612Z",
        "details": {
          "Color Category": "Black",
          "Wattage": "700 watts",
          "Brand Compatibility": "Universal",
          "Model Compatibility": "Universal",
          "pricematch": "yes"
        }
      }
    }
  ]
}
```
