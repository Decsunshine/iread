//
//  IRDAddBookProgressViewModel.swift
//  iread
//
//  Created by honglianglu on 18/02/2017.
//  Copyright © 2017 cc. All rights reserved.
//

import Foundation

class IRDAddBookProgressViewModel: NSObject {
    var book: IRDBook?
    let model = IRDBookModel.init()
    
    func addBookProgress(startPage: String, endPage: String) -> Void {
        guard (startPage.characters.count > 0 || endPage.characters.count > 0) else { return }
        if let book = self.book {
            let bookID = book.ID
            self.model.addBookProgress(startPage: startPage, endPage: endPage, bookID: bookID) { (error) in
                print(error ?? "success")
            }
        }
    }
}
