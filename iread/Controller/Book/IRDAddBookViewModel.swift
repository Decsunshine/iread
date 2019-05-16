//
//  IRDAddBookViewModel.swift
//  iread
//
//  Created by honglianglu on 16/02/2017.
//  Copyright © 2017 cc. All rights reserved.
//

import Foundation
import RxSwift

class IRDAddBookViewModel: NSObject {
    let model = IRDBookModel.init()
    
    var addBookSuccess = Variable(false)
    
    func addBook(bookName: String) -> Void {
        guard (bookName.count > 0) else { return }
        self.model.addBook(name: bookName) { (error) in
            print(error ?? "success")
            if (error != nil) {
                self.addBookSuccess.value = true
            } else {
                self.addBookSuccess.value = false
            }
        }
    }
}
