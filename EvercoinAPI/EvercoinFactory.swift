//
//  EvercoinFactory.swift
//  SwiftAPI
//
//  Created by Evercoin on 26.09.2017.
//  Copyright © 2017 evercoin. All rights reserved.
//

import Foundation

var URI:String = "https://api.evercoin.com/"
let EVERCOIN_API_KEY:String = "EVERCOIN-API-KEY";

public class EvercoinFactory:NSObject{
    
    private static var evercoin:Evercoin?
    
    public static func  create(config: EvercoinApiConfig) ->Evercoin {
        if evercoin == nil{
            let defaults = UserDefaults.standard
            if let endpoint = defaults.string(forKey: "evercoin.api.endpoint") {
                URI = endpoint
            }
            evercoin = EvercoinImpl(apiKey: config.apiKey!, version: config.version!)
        }
        return evercoin!
    }
}

class EvercoinImpl: Evercoin{

    var version:String?
    var apiKey:String?
    private var LIMIT_SERVICE:String = ""
    private var VALIDATE_ADDRESS_SERVICE:String = ""
    private var GET_COINS_SERVICE:String = ""
    private var GET_PRICE_SERVICE:String = ""
    private var CREATE_ORDER_SERVICE:String = ""
    private var GET_STATUS_SERVICE:String = ""
    
    init(apiKey:String, version:String) {
        self.apiKey = apiKey
        self.version = version
        LIMIT_SERVICE = URI + version + "/limit/";
        VALIDATE_ADDRESS_SERVICE = URI + version + "/validate/";
        GET_COINS_SERVICE = URI + version + "/coins/";
        GET_PRICE_SERVICE = URI + version + "/price/";
        CREATE_ORDER_SERVICE = URI + version + "/order/";
        GET_STATUS_SERVICE = URI + version + "/status/";
    }
    
    
    func getLimit(depositCoin:String, destinationCoin:String) -> LimitResponse{
        let urlStr = LIMIT_SERVICE + depositCoin + "-" + destinationCoin
        let url = URL(string: urlStr)
        let request = NSMutableURLRequest(url:url!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(self.apiKey, forHTTPHeaderField: EVERCOIN_API_KEY)
        request.httpMethod = "GET"
        
        let (responseData, _, _) = URLSession.shared.synchronousDataTask(with: request as URLRequest)
        if let responseData = responseData
        {
            do {
                let json = try JSON(data: responseData)
                let error = json["error"]
                if error == JSON.null{
                    let depositCoin = json["depositCoin"].string
                    let destinationCoin = json["destinationCoin"].string
                    let maxDeposit = json["maxDeposit"].string
                    let minDeposit = json["minDeposit"].string
                    return LimitResponse(depositCoin: depositCoin!, destinationCoin: destinationCoin!, maxDeposit: maxDeposit!, minDeposit: minDeposit!)
                }
                else{
                    return LimitResponse(error: error.stringValue)
                }
            } catch {
                return LimitResponse(error: "exception")
            }
        }
        return LimitResponse(error: "exception")
    }
    
    func validateAddress(coin:String, address:String) -> ValidateResponse{
        let urlStr = VALIDATE_ADDRESS_SERVICE + coin + "/" + address
        let url = URL(string: urlStr)
        let request = NSMutableURLRequest(url:url!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(self.apiKey, forHTTPHeaderField: EVERCOIN_API_KEY)
        request.httpMethod = "GET"
        
        let (responseData, _, _) = URLSession.shared.synchronousDataTask(with: request as URLRequest)
        if let responseData = responseData
        {
            do {
                let json = try JSON(data: responseData)
                let error = json["error"]
                if error == JSON.null{
                    let isValid = json["result"]["isValid"].boolValue
                    return ValidateResponse(isValid: isValid)
                }
                else{
                    return ValidateResponse(error: error.stringValue)
                }
            } catch {
                return ValidateResponse(error: "exception")
            }
        }
        return ValidateResponse(error: "exception")
    }
    
    func getCoins() -> CoinsResponse{
        let urlStr = GET_COINS_SERVICE
        let url = URL(string: urlStr)
        let request = NSMutableURLRequest(url:url!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(self.apiKey, forHTTPHeaderField: EVERCOIN_API_KEY)
        request.httpMethod = "GET"
        
        let (responseData, _, _) = URLSession.shared.synchronousDataTask(with: request as URLRequest)
        if let responseData = responseData
        {
            do {
                let json = try JSON(data: responseData)
                let error = json["error"]
                if error == JSON.null{
                    let coinResponse = CoinsResponse()
                    let coinList = json["result"].arrayValue
                    if coinList.count > 0{
                        for i in 0 ..< coinList.count{
                            let name = coinList[i]["name"].stringValue
                            let symbol = coinList[i]["symbol"].stringValue
                            let fromAvailable = coinList[i]["fromAvailable"].boolValue
                            let toAvailable = coinList[i]["toAvailable"].boolValue
                            let coin = Coin(name: name, symbol: symbol, fromAvailable: fromAvailable, toAvailable: toAvailable)
                            coinResponse.coinList.append(coin)
                        }
                        return coinResponse
                    }
                }
                else{
                    return CoinsResponse(error: error.stringValue)
                }
            } catch {
                return CoinsResponse(error: "exception")
            }
        }
        return CoinsResponse(error: "exception")
    }
    
    func getPrice(depositCoin:String, destinationCoin:String, depositAmount:Double?, destinationAmount:Double?) -> PriceResponse{
        let urlStr = GET_PRICE_SERVICE
        let url = URL(string: urlStr)
        let request = NSMutableURLRequest(url:url!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(self.apiKey, forHTTPHeaderField: EVERCOIN_API_KEY)
        request.httpMethod = "POST"
        
        if let depAmount = depositAmount{
            let params = ["depositCoin":depositCoin, "destinationCoin":destinationCoin, "depositAmount":String(describing: depAmount)] as Dictionary<String, Any>
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            } catch {
                return PriceResponse(error: "exception")
            }
        } else if let desAmount = destinationAmount{
            let params = ["depositCoin":depositCoin, "destinationCoin":destinationCoin, "destinationAmount":String(describing: desAmount)] as Dictionary<String, Any>
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            } catch {
                return PriceResponse(error: "exception")
            }
        }
        else{
            return PriceResponse(error: "Amount can not be null");
        }
        
        
        let (responseData, _, _) = URLSession.shared.synchronousDataTask(with: request as URLRequest)
        if let responseData = responseData
        {
            do {
                let json = try JSON(data: responseData)
                let error = json["error"]
                if error == JSON.null{
                    let depositCoin = json["result"]["depositCoin"].string
                    let destinationCoin = json["result"]["destinationCoin"].string
                    let depositAmount = json["result"]["depositAmount"].string
                    let destinationAmount = json["result"]["destinationAmount"].string
                    let signature = json["result"]["signature"].string
                    return PriceResponse(depositCoin: depositCoin!, destinationCoin: destinationCoin!, depositAmount: Double(depositAmount!)!, destinationAmount: Double(destinationAmount!)!, signature: signature!)
                }
                else{
                    return PriceResponse(error: error.stringValue)
                }
            } catch {
                return PriceResponse(error: "exception")
            }
        }
        return PriceResponse(error: "exception")
    }
    
    func createOrder(priceResponse:PriceResponse, refundAddress:Address, destinationAddress:Address) -> OrderResponse{
        let urlStr = CREATE_ORDER_SERVICE
        let url = URL(string: urlStr)
        let request = NSMutableURLRequest(url:url!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(self.apiKey, forHTTPHeaderField: EVERCOIN_API_KEY)
        request.httpMethod = "POST"
        
        let depositCoin:String = priceResponse.depositCoin!;
        let destinationCoin:String = priceResponse.destinationCoin!;
        let signature:String = priceResponse.signature!;
        
        if let depositAmount = priceResponse.depositAmount{
            if let destinationAmount = priceResponse.destinationAmount{
                let params = ["depositCoin":depositCoin, "destinationCoin":destinationCoin, "destinationAddress":destinationAddress.getJsonValue(), "refundAddress":refundAddress.getJsonValue(), "depositAmount":String(describing: depositAmount), "destinationAmount":String(describing: destinationAmount), "signature":signature] as Dictionary<String, Any>
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
                } catch {
                    return OrderResponse(error: "exception")
                }
            }
            else{
                return OrderResponse(error: "exception")
            }
        }
        else{
            return OrderResponse(error: "exception")
        }
        
        let (responseData, _, _) = URLSession.shared.synchronousDataTask(with: request as URLRequest)
        if let responseData = responseData
        {
            do {
                let json = try JSON(data: responseData)
                let error = json["error"]
                if error == JSON.null{
                    let orderId = json["result"]["orderId"].string
                    let depositAddress = makeAddressFromJson(json: json["result"], tag: "depositAddress")
                    return OrderResponse(orderId: orderId!, depositAddress: depositAddress)
                }
                else{
                    return OrderResponse(error: error.stringValue)
                }
            } catch {
                return OrderResponse(error: "exception")
            }
        }
        return OrderResponse(error: "exception")
    }
    
    func getStatus(orderId:String) -> StatusResponse{
        let urlStr = GET_STATUS_SERVICE + orderId
        let url = URL(string: urlStr)
        let request = NSMutableURLRequest(url:url!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(self.apiKey, forHTTPHeaderField: EVERCOIN_API_KEY)
        request.httpMethod = "GET"
        
        let (responseData, _, _) = URLSession.shared.synchronousDataTask(with: request as URLRequest)
        if let responseData = responseData
        {
            do {
                let json = try JSON(data: responseData)
                let error = json["error"]
                if error == JSON.null{
                    let exchangeStatus = Status.getStatus(statusId: json["result"]["exchangeStatus"].int!)
                    let depositAmount = json["result"]["depositAmount"].double
                    let depositCoin = json["result"]["depositCoin"].string
                    let destinationCoin = json["result"]["destinationCoin"].string
                    let destinationAmount = json["result"]["destinationAmount"].double
                    let refundAddress = makeAddressFromJson(json: json["result"], tag: "refundAddress")
                    let destinationAddress = makeAddressFromJson(json: json["result"], tag: "destinationAddress")
                    let depositAddress = makeAddressFromJson(json: json["result"], tag: "depositAddress")
                    let creationTime = json["result"]["creationTime"].int64
                    let depositExpectedAmount = json["result"]["depositExpectedAmount"].double
                    let destinationExpectedAmount = json["result"]["destinationExpectedAmount"].double
                    var txURL = json["result"]["txURL"].string
                    let minDeposit = json["result"]["minDeposit"].double
                    let maxDeposit = json["result"]["maxDeposit"].double
                    if txURL == nil{
                        txURL = ""
                    }
                    return StatusResponse(exchangeStatus: exchangeStatus, depositAmount: depositAmount!, depositCoin: depositCoin!, destinationCoin: destinationCoin!, destinationAmount: destinationAmount!, refundAddress: refundAddress, destinationAddress: destinationAddress, depositAddress: depositAddress, creationTime: creationTime!, depositExpectedAmount: depositExpectedAmount!, destinationExpectedAmount: destinationExpectedAmount!, txURL: txURL!, minDeposit: minDeposit!, maxDeposit: maxDeposit!)
                }
                else{
                    return StatusResponse(error: error.stringValue)
                }
            } catch {
                return StatusResponse(error: "exception")
            }
        }
        return StatusResponse(error: "exception")
    }
    
    func makeAddressFromJson(json:JSON, tag:String) -> Address{
        let mainAddress = json[tag]["mainAddress"].string
        let tagName = json[tag]["tagName"].string
        let tagValue = json[tag]["tagValue"].string
        if tagName == "Payment Id" {
            return MoneroAddress(mainAddress: mainAddress!, paymentId: tagValue!);
        } else if tagName == "DestinationTag" {
            return RippleAddress(mainAddress: mainAddress!, destinationTag: tagValue!);
        }
        return Address(mainAddress: mainAddress!);
    }
    
    func forTailingZero(temp: Double) -> String{
        var tempVar = String(format: "%g", temp)
        return tempVar
    }
}

extension URLSession {
    
    func synchronousDataTask(with request: URLRequest) -> (data: Data?, error:Error?, response: HTTPURLResponse?) {
        
        let semaphore = DispatchSemaphore(value: 0)
        
        var responseData: Data?
        var theResponse: URLResponse?
        var theError: Error?
        
        dataTask(with: request) { (data, response, error) -> Void in
            
            responseData = data
            theResponse = response
            theError = error
            
            semaphore.signal()
            
            }.resume()
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        return (data: responseData, error: theError, response: theResponse as! HTTPURLResponse?)
        
    }
    
}
