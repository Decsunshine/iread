//
//  IRDEnvironment.swift
//  iread
//
//  Created by honglianglu on 12/02/2017.
//  Copyright © 2017 cc. All rights reserved.
//

import Foundation

class IRDEnvironment: NSObject {
    let user = IRDUser.init()
    
    // http://www.cocoachina.com/swift/20151207/14584.html
    static let shareInstance = IRDEnvironment()
    private override init() {}
}
