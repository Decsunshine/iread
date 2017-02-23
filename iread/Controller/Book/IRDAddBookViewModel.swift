//
//  IRDAddBookViewModel.swift
//  iread
//
//  Created by honglianglu on 16/02/2017.
//  Copyright © 2017 cc. All rights reserved.
//

import Foundation

class IRDAddBookViewModel: NSObject {
    let model = IRDBookModel.init()
    
    func addBook(bookName: String) -> Void {
        guard (bookName.characters.count > 0) else { return }
        self.model.addBook(name: bookName) { (error) in
            print(error ?? "success")
        }
    }
}
