//
//  StatusResponse.swift
//  SwiftAPI
//
//  Created by Evercoin on 26.09.2017.
//  Copyright © 2017 evercoin. All rights reserved.
//

import Foundation

public class StatusResponse:Response{
    
    public  var exchangeStatus:Status?
    public var depositAmount:Double?
    public var depositCoin:String?
    public var destinationCoin:String?
    public var destinationAmount:Double?
    public var refundAddress:Address?
    public var destinationAddress:Address?
    public var depositAddress:Address?
    public var creationTime:Int64?
    public var depositExpectedAmount:Double?
    public var destinationExpectedAmount:Double?
    public var txURL:String?
    public var minDeposit:Double?
    public var maxDeposit:Double?
    
    public override init(error:String) {
        super.init(error: error)
    }
    
    public init(exchangeStatus:Status, depositAmount:Double, depositCoin:String, destinationCoin:String, destinationAmount:Double, refundAddress:Address,
         destinationAddress:Address, depositAddress:Address, creationTime:Int64, depositExpectedAmount:Double, destinationExpectedAmount:Double,
         txURL:String, minDeposit:Double, maxDeposit:Double) {
        super.init()
        self.depositCoin = depositCoin
        self.exchangeStatus = exchangeStatus
        self.depositAmount = depositAmount
        self.depositCoin = depositCoin
        self.destinationCoin = destinationCoin
        self.destinationAmount = destinationAmount
        self.refundAddress = refundAddress
        self.destinationAddress = destinationAddress
        self.depositAddress = depositAddress
        self.creationTime = creationTime
        self.depositExpectedAmount = depositExpectedAmount
        self.destinationExpectedAmount = destinationExpectedAmount
        self.txURL = txURL
        self.minDeposit = minDeposit
        self.maxDeposit = maxDeposit
    }
}
