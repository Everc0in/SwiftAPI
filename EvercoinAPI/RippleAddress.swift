//
//  RippleAddress.swift
//  SwiftAPI
//
//  Created by Evercoin on 26.09.2017.
//  Copyright © 2017 evercoin. All rights reserved.
//

import Foundation

public class RippleAddress:Address{
    
    public var destinationTag:String = ""
    
    public init(mainAddress:String, destinationTag:String) {
        super.init(mainAddress: mainAddress)
        self.destinationTag = destinationTag
    }
    
    public override func getJsonValue() -> Dictionary<String, String>{
        let params = ["mainAddress":mainAddress, "tagName":"Destination Tag", "destinationTag":destinationTag]
        return params
    }
}
