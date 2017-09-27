//
//  Address.swift
//  SwiftAPI
//
//  Created by Evercoin on 26.09.2017.
//  Copyright © 2017 evercoin. All rights reserved.
//

import Foundation

public class Address:NSObject{
   
    public var mainAddress:String = ""
    
    public init(mainAddress:String) {
        self.mainAddress = mainAddress
    }
    
    public func getJsonValue() -> Dictionary<String, String>{
        let params = ["mainAddress":mainAddress] as Dictionary<String, String>
        return params
    }
}
