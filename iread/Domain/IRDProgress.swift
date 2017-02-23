//
//  IRDProgress.swift
//  iread
//
//  Created by honglianglu on 22/02/2017.
//  Copyright © 2017 cc. All rights reserved.
//

import Foundation

class IRDProgress: NSObject {
    var ID: String = ""
    var startPage: String = ""
    var endPage: String = ""
    var time: String = ""
    
    public func transferFromDic(dictionary : Dictionary<String, Any>) -> Void {
        if let ID = dictionary["bookItemId"] as? Int {
            self.ID = "\(ID)"
        }
        if let endPage = dictionary["endPos"] as? String {
            self.endPage = endPage
        }
        if let startPage = dictionary["startPos"] as? String {
            self.startPage = startPage
        }
        if let time = dictionary["readTime"] as? String {
            self.time = time
        }
    }
}
