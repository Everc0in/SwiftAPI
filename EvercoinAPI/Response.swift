//
//  Response.swift
//  SwiftAPI
//
//  Created by Evercoin on 26.09.2017.
//  Copyright © 2017 evercoin. All rights reserved.
//

import Foundation

public class Response:NSObject{
    
    public var error:String?
    public var isSuccess:Bool?
    
    public  init(error:String) {
        self.error = error
        self.isSuccess = false
    }
    
    public  override init() {
        self.error = nil
        self.isSuccess = true
    }
}
