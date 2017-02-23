//
//  IRDTask.swift
//  iread
//
//  Created by honglianglu on 22/02/2017.
//  Copyright © 2017 cc. All rights reserved.
//

import Foundation

class IRDTask: NSObject {
    var ID: String = ""
    var reviewDate: String = ""
    var desc: String = ""
    
    public func transferFromDic(dictionary : Dictionary<String, Any>) -> Void {
        if let ID = dictionary["taskId"] as? Int {
            self.ID = "\(ID)"
        }
        
        if let reviewDate = dictionary["mayReviewDate"] as? String {
            self.reviewDate = reviewDate
        }
        if let bookItem = dictionary["ponBookItem"] as? NSDictionary,
            let status = dictionary["taskStatus"] as? String{
            if let book = bookItem["ponBook"] as? NSDictionary,
                let startPage = bookItem["startPos"] as? String,
                let endPage = bookItem["endPos"] as? String,
                let readTimeDic = bookItem["readTime"] as? NSArray {
                if let name = book["name"] as? String,
                    let year = readTimeDic[0] as? Int,
                    let month = readTimeDic[1] as? Int,
                    let day = readTimeDic[2] as? Int{
                    desc = "\(year)" + "-" + "\(month)" + "-" + "\(day)" + " 《" + name + "》 " + startPage + "页 => " + endPage + "页  " + status
                }
            }
        }
        
    }
    
}
