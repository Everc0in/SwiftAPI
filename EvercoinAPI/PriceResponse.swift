//
//  PriceResponse.swift
//  SwiftAPI
//
//  Created by Evercoin on 26.09.2017.
//  Copyright © 2017 evercoin. All rights reserved.
//

import Foundation

public class PriceResponse:Response{
    
    public var depositCoin:String?
    public var destinationCoin:String?
    public var depositAmount:Double?
    public var destinationAmount:Double?
    public var signature:String?
    
    public override init(error:String) {
        super.init(error: error)
    }
    
    public init(depositCoin:String, destinationCoin:String, depositAmount:Double, destinationAmount:Double, signature:String) {
        super.init()
        self.depositCoin = depositCoin
        self.destinationCoin = destinationCoin
        self.depositAmount = depositAmount
        self.destinationAmount = destinationAmount
        self.signature = signature
    }
}
