//
//  IRDAddBookProgressViewModel.swift
//  iread
//
//  Created by honglianglu on 18/02/2017.
//  Copyright © 2017 cc. All rights reserved.
//

import Foundation
import RxSwift

class IRDAddBookProgressViewModel: NSObject {
    var book: IRDBook?
    let model = IRDBookModel.init()
    var addBookProgressSuccess = Variable(false)
    
    func addBookProgress(startPage: String, endPage: String) -> Void {
        guard (startPage.count > 0 || endPage.count > 0) else { return }
        if let book = self.book {
            let bookID = book.ID
            self.model.addBookProgress(startPage: startPage, endPage: endPage, bookID: bookID) { (error) in
                print(error ?? "success")
                if (error != nil) {
                    self.addBookProgressSuccess.value = false
                } else {
                    self.addBookProgressSuccess.value = true
                }
            }
        }
    }
}
