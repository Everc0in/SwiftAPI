//
//  OrderStatus.swift
//  SwiftAPI
//
//  Created by Evercoin on 26.09.2017.
//  Copyright © 2017 evercoin. All rights reserved.
//

import Foundation

public class Status: NSObject {
    
    public static let awaitingDeposit = Status(statusId: 1, status: "AWAITING DEPOSIT")
    public static let awaitingConfirm = Status(statusId: 2, status: "AWAITING EXCHANGE")
    public static let awaitingExchange = Status(statusId: 3, status: "ALMOST DONE")
    public static let awaitingRefund = Status(statusId: 4, status: "AWAITING REFUND")
    public static let allDone = Status(statusId: 5, status: "ALL DONE")
    public static let refundDone = Status(statusId: 6, status: "REFUND COMPLETED")
    public static let minimumCancel = Status(statusId: 7, status: "DEPOSIT CONFIRMED")
    public static let sendMoneyError = Status(statusId: 8, status: "DEPOSIT CONFIRMED")
    public static let expireExchange = Status(statusId: 9, status: "ORDER EXPIRED")
    public static let cancel = Status(statusId: 10, status: "CANCEL")
    
    public var statusId:Int?
    public var status:String?
    
    public init(statusId:Int, status:String) {
        self.statusId = statusId
        self.status = status
    }
    
    public static func getStatus(statusId:Int) -> Status{
        switch statusId {
        case 1:
            return awaitingDeposit
        case 2:
            return awaitingConfirm
        case 3:
            return awaitingExchange
        case 4:
            return awaitingRefund
        case 5:
            return allDone
        case 6:
            return refundDone
        case 7:
            return minimumCancel
        case 8:
            return sendMoneyError
        case 9:
            return expireExchange
        case 10:
            return cancel
        default:
            return awaitingDeposit
        }
    }
}
