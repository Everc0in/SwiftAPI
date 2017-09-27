//
//  CoinResponse.swift
//  SwiftAPI
//
//  Created by Evercoin on 26.09.2017.
//  Copyright © 2017 evercoin. All rights reserved.
//

import Foundation

public class CoinsResponse:Response{
    
    public var coinList: [Coin] = []
    
    public override init(error:String) {
        super.init(error: error)
    }
    
    public override init() {
        super.init()
    }
    
    public func getCoin(symbol:String) -> Coin?{
        for coin in self.coinList{
            if coin.symbol == symbol{
                return coin
            }
        }
        return nil
    }
}

