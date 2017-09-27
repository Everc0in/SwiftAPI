# <img src="https://raw.githubusercontent.com/Everc0in/JavaAPI/master/evercoin-logo.png" height="30" width="auto" >  Swift library

[Evercoin](https://evercoin.com) is a an instant-access cryptocurrency exchange. This Swift API enables you to easily integrate cryptocurrency exchange funtionality into your IOS app.

## Requirements
- Swift3 or higher
- API Key // contact support@evercoin.com to obtain your API key

## Download

Download a version of the Evercoin swift's framework from [SwiftAPI](https://github.com/Everc0in/Download/raw/master/EvercoinAPI.framework) 

## Usage Example
```swift
import XCTest
import Darwin

@testable import EvercoinAPI

class EvercoinAPITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        let defaults = UserDefaults.standard
        defaults.set("https://test.evercoin.com/", forKey: "evercoin.api.endpoint")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let API_KEY:String = "7f878074f09f4f673554f30be51b6a0d";
        let version:String = "v1";
        let deposit:String = "BTC";
        let destination:String = "ETH";
        let refundMainAddress:String = "n4MZ1KydkCEokrr8fVAcGSghsSMjHvNexo";
        let destinationMainAddress:String = "0xb306e1D76E4C4bd6462F370d4551F842eB4fFcad";
        let depositAmount:String = "1.0";
        
        let evercoin:Evercoin = EvercoinFactory.create(config: EvercoinApiConfig(apiKey: API_KEY, version: version))
        let coins:CoinsResponse = evercoin.getCoins()
        let depositCoin = coins.getCoin(symbol: deposit);
        let destinationCoin = coins.getCoin(symbol: destination);
        if (depositCoin != nil && !(depositCoin?.fromAvailable)!) {
            //Exchanging from BTC is currently available.
            return;
        }
        if (destinationCoin != nil && !(destinationCoin?.toAvailable)!) {
            //Exchanging to ETH is currently available.
            return;
        }
        let refundValidateReponse = evercoin.validateAddress(coin: deposit, address: refundMainAddress)
        if (refundValidateReponse.isSuccess! && refundValidateReponse.isValid! == false) {
            //Your BTC address is not valid.
            return;
        }
        let refundAddress = Address(mainAddress: refundMainAddress);
        
        let destinationValidateReponse = evercoin.validateAddress(coin: destination, address: destinationMainAddress)
        if (destinationValidateReponse.isSuccess! && destinationValidateReponse.isValid! == false) {
            //Your ETH address is not valid.
            return;
        }
        let destinationAddress = Address(mainAddress: destinationMainAddress);
        let priceResponse = evercoin.getPrice(depositCoin: deposit, destinationCoin: destination, depositAmount: Double(depositAmount), destinationAmount: nil)
        if priceResponse.isSuccess == true{
            let orderResponse = evercoin.createOrder(priceResponse: priceResponse, refundAddress: refundAddress, destinationAddress: destinationAddress)
            if orderResponse.isSuccess == true {
                print("You should deposit to this address: " + (orderResponse.depositAddress?.mainAddress)!)
                while(true){
                    sleep(10)
                    let statusResponse:StatusResponse = evercoin.getStatus(orderId: orderResponse.orderId!)
                    if (statusResponse.exchangeStatus?.statusId == Status.awaitingDeposit.statusId) {
                        let depositMainAddress = orderResponse.depositAddress?.mainAddress
                        var printStr = "Send " + depositAmount + " "
                        printStr = printStr +  deposit + " to the " + depositMainAddress!
                        EvercoinAPI.logToConsole(msg: printStr)
                    }
                    else if (statusResponse.exchangeStatus?.statusId == Status.awaitingConfirm.statusId) {
                        EvercoinAPI.logToConsole(msg: "Looks like you sent " + deposit + ". Waiting for confirmation on the blockchain.");
                    } else if (statusResponse.exchangeStatus?.statusId == Status.awaitingExchange.statusId) {
                        EvercoinAPI.logToConsole(msg:"Your " + destination + " is on the way.");
                    } else if (statusResponse.exchangeStatus?.statusId == Status.allDone.statusId) {
                        EvercoinAPI.logToConsole(msg:"Success! Enjoy your " + destination);
                        return;
                    }
                }
            }
        }
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

```
## More Info

More information and API documentation can be found at https://evercoin.com/API/

## Getting help

Please contact support@evercoin.com
