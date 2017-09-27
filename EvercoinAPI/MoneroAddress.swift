//
//  MoneroAddress.swift
//  SwiftAPI
//
//  Created by Evercoin on 26.09.2017.
//  Copyright © 2017 evercoin. All rights reserved.
//

import Foundation

public class MoneroAddress:Address{
    
    public  var paymentId:String = ""
    
    public init(mainAddress:String, paymentId:String) {
        super.init(mainAddress: mainAddress)
        self.paymentId = paymentId
    }
    
    public override func getJsonValue() -> Dictionary<String, String>{
        let params = ["mainAddress":mainAddress, "tagName":"Payment Id", "paymentId":paymentId]
        return params
    }
}
