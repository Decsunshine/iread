//
//  IRDTask.swift
//  iread
//
//  Created by honglianglu on 22/02/2017.
//  Copyright © 2017 cc. All rights reserved.
//

import Foundation
import SwiftyJSON

class IRDTask: NSObject {
    var ID: String = ""
    var reviewDate: String = ""
    var desc: String = ""
    
    public func transferFromDic(dictionary : [String: JSON]) -> Void {
        if let ID = dictionary["taskId"]?.int {
            self.ID = "\(ID)"
        }
        
        if let reviewDate = dictionary["mayReviewDate"]?.string {
            self.reviewDate = reviewDate
        }
        if let bookItem = dictionary["ponBookItem"]?.dictionary,
            let status = dictionary["taskStatus"]?.string{
            if let book = bookItem["ponBook"]?.dictionary,
                let startPage = bookItem["startPos"]?.string,
                let endPage = bookItem["endPos"]?.string,
                let readTimeDic = bookItem["readTime"]?.array {
                if let name = book["name"]?.string,
                    let year = readTimeDic[0].int,
                    let month = readTimeDic[1].int,
                    let day = readTimeDic[2].int{
                    desc = "\(year)" + "-" + "\(month)" + "-" + "\(day)" + " 《" + name + "》 " + startPage + "页 => " + endPage + "页  " + status
                }
            }
        }
        
    }
    
}
