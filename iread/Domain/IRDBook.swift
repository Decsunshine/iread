//
//  IRDBook.swift
//  iread
//
//  Created by honglianglu on 05/02/2017.
//  Copyright © 2017 cc. All rights reserved.
//

import Foundation
import SwiftyJSON

class IRDBook: NSObject {
    var name: String = ""
    var ID: String = ""
    
    public func transferFromDic(dictionary : [String: JSON]) -> Void {
        if let bookName = dictionary["name"]?.string{
            name = bookName;
        }
        if let bookID = dictionary["bookId"]?.int {
            ID = "\(bookID)"
        }
    }
}
