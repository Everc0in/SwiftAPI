//
//  EvercoinApiConfig.swift
//  SwiftAPI
//
//  Created by Evercoin on 26.09.2017.
//  Copyright © 2017 evercoin. All rights reserved.
//

import Foundation

public class EvercoinApiConfig:NSObject{
    
    public var apiKey:String?
    public var version:String?
    
    public init(apiKey:String, version:String) {
        self.apiKey = apiKey
        self.version = version
    }
}
