//
//  ValidateResponse.swift
//  SwiftAPI
//
//  Created by Evercoin on 26.09.2017.
//  Copyright © 2017 evercoin. All rights reserved.
//

import Foundation

public class ValidateResponse:Response{
    
    public var isValid:Bool?
    
    public override init(error:String) {
        super.init(error: error)
    }
    
    public init(isValid:Bool) {
        super.init()
        self.isValid = isValid
    }
}
