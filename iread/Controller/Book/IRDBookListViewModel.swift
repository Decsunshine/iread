//
//  IRDBookListViewModel.swift
//  iread
//
//  Created by honglianglu on 12/02/2017.
//  Copyright © 2017 cc. All rights reserved.
//

import Foundation
import RxSwift

class IRDBookListViewModel: NSObject {
    let model = IRDBookModel.init()
    var bookList = Variable([])
    
    var pageNumber = "0"
    var pageSize = "20"

    func fetchBookList () {
        model.bookList(pageNumber: self.pageNumber, pageSize: self.pageSize) { (list, pageNumber, pageSize, error) in
            self.pageNumber = pageNumber
            self.pageSize = pageSize
            if let list = list {
                self.bookList.value = list
            }
        }
    }
}
