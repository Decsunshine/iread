//
//  IRDBook.swift
//  iread
//
//  Created by honglianglu on 05/02/2017.
//  Copyright © 2017 cc. All rights reserved.
//

import Foundation

class IRDBook: NSObject {
    var name: String = ""
    var ID: String = ""
    
    public func transferFromDic(dictionary : Dictionary<String, Any>) -> Void {
        if let bookName = dictionary["name"] as? String{
            name = bookName;
        }
        if let bookID = dictionary["bookId"] as? Int {
            ID = "\(bookID)"
        }
    }
}
