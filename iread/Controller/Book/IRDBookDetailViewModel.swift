//
//  IRDBookDetailViewModel.swift
//  iread
//
//  Created by honglianglu on 18/02/2017.
//  Copyright © 2017 cc. All rights reserved.
//

import Foundation
import RxSwift

class IRDBookDetailViewModel: NSObject {
    let model = IRDBookModel.init()
    
    var book: IRDBook?
    var progressList = Variable([])
    
    var pageNumber = "0"
    var pageSize = "20"
    
    func fetchProgressList() -> Void {
        model.progressList(bookID: book?.ID, pageNumber: self.pageNumber, pageSize: self.pageSize) { (list, pageNumber, pageSize, error) in
            self.pageNumber = pageNumber
            self.pageSize = pageSize
            
            if let list = list {
                self.progressList.value = list
            }
        }
    }

}
