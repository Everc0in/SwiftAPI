//
//  LimitResponse.swift
//  SwiftAPI
//
//  Created by Evercoin on 26.09.2017.
//  Copyright © 2017 evercoin. All rights reserved.
//

import Foundation

public class LimitResponse:Response{
    
    public var depositCoin:String?
    public var destinationCoin:String?
    public var maxDeposit:String?
    public var minDeposit:String?
    
    public override init(error:String) {
        super.init(error: error)
    }
    
   public init(depositCoin:String, destinationCoin:String, maxDeposit:String, minDeposit:String) {
        super.init()
        self.depositCoin = depositCoin
        self.destinationCoin = destinationCoin
        self.maxDeposit = maxDeposit
        self.minDeposit = minDeposit
    }
}
