//
//  Evercoin.swift
//  SwiftAPI
//
//  Created by Evercoin on 26.09.2017.
//  Copyright © 2017 evercoin. All rights reserved.
//

import Foundation

public protocol Evercoin: class {
    func getLimit(depositCoin:String, destinationCoin:String) -> LimitResponse;
    func validateAddress(coin:String, address:String) -> ValidateResponse;
    func getCoins() -> CoinsResponse;
    func getPrice(depositCoin:String, destinationCoin:String, depositAmount:Double?, destinationAmount:Double?) -> PriceResponse;
    func createOrder(priceResponse:PriceResponse, refundAddress:Address, destinationAddress:Address) -> OrderResponse;
    func getStatus(orderId:String) -> StatusResponse;
}
