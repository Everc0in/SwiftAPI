//
//  Coin.swift
//  SwiftAPI
//
//  Created by Evercoin on 26.09.2017.
//  Copyright © 2017 evercoin. All rights reserved.
//

import Foundation

public class Coin:NSObject{
    
    public var name:String?
    public var symbol:String?
    public var fromAvailable:Bool?
    public var toAvailable:Bool?
    
    public init(name:String, symbol:String, fromAvailable:Bool, toAvailable:Bool) {
        self.name = name
        self.symbol = symbol
        self.fromAvailable = fromAvailable
        self.toAvailable = toAvailable
    }
}
