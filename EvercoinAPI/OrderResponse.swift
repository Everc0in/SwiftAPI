//
//  OrderResponse.swift
//  SwiftAPI
//
//  Created by Evercoin on 26.09.2017.
//  Copyright © 2017 evercoin. All rights reserved.
//

import Foundation

public class OrderResponse:Response{
    
    public var orderId:String?
    public var depositAddress:Address?
    
    public override init(error:String) {
        super.init(error: error)
    }
    
    public init(orderId:String, depositAddress:Address) {
        super.init()
        self.orderId = orderId
        self.depositAddress = depositAddress
    }
}
