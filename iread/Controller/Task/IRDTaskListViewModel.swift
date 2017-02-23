//
//  IRDTaskListViewModel.swift
//  iread
//
//  Created by honglianglu on 22/02/2017.
//  Copyright © 2017 cc. All rights reserved.
//

import Foundation
import RxSwift

class IRDTaskListViewModel: NSObject {
    
    let model = IRDTaskModel.init()
    
    var book: IRDBook?
    var taskList = Variable([])
    var finishTask = Variable(false)
    
    var pageNumber = "0"
    var pageSize = "20"
    
    func fetchTaskList() -> Void {
        model.taskList(pageNumber: self.pageNumber, pageSize: self.pageSize) { (list, pageNumber, pageSize, error) in
            self.pageNumber = pageNumber
            self.pageSize = pageSize
            
            if let list = list {
                self.taskList.value = list
            }
        }
    }
    
    func finishTask(taskID: String) -> Void {
        model.finishTask(taskID: taskID) { (error) in
            if (error != nil) {
                self.finishTask.value = false;
            } else {
                self.finishTask.value = true;
            }
        }
    }
}
