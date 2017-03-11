//
//  IRDProgress.swift
//  iread
//
//  Created by honglianglu on 22/02/2017.
//  Copyright © 2017 cc. All rights reserved.
//

import Foundation
import SwiftyJSON

class IRDProgress: NSObject {
    var ID: String = ""
    var startPage: String = ""
    var endPage: String = ""
    var time: String = ""
    
    public func transferFromDic(dictionary : [String: JSON]) -> Void {
        if let ID = dictionary["bookItemId"]?.int {
            self.ID = "\(ID)"
        }
        if let endPage = dictionary["endPos"]?.string {
            self.endPage = endPage
        }
        if let startPage = dictionary["startPos"]?.string {
            self.startPage = startPage
        }
        if let time = dictionary["readTime"]?.array {
            if let year = time[0].int,
                let month = time[1].int,
                let day = time[2].int {
                self.time = "\(year)" + "-" + "\(month)" + "-" + "\(day)"
            }
        }
    }
}
