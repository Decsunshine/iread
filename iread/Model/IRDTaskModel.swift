//
//  IRDTaskModel.swift
//  iread
//
//  Created by honglianglu on 22/02/2017.
//  Copyright © 2017 cc. All rights reserved.
//

import Foundation
import SwiftyJSON

class IRDTaskModel: IRDBaseModel {
    let userID = IRDEnvironment.shareInstance.user.ID
    
    func taskList(pageNumber: String, pageSize: String, completion:@escaping (_ data: Array<IRDTask>?, _ bookNumber: String, _ bookSize: String, _ error: NSError?) -> Void) -> Void {
        network.get(path: "/user/" + userID + "/tasks/today",
                    params: ["pageNum": pageNumber, "pageSize": pageSize],
                    completion: { (_ data: JSON?, _ error: NSError?) -> Void in
                        if (error != nil) {
                            completion(nil, "", "", error)
                        } else {
                            var pageNumber = ""
                            var pageSize = ""
                            if let number = data?["pageNum"].int {
                                pageNumber = String(number)
                            }
                            if let size = data?["pageSize"].int {
                                pageSize = String(size)
                            }
                            var taskList = [IRDTask]()
                            if let list = data?["list"].array {
                                for item in list.enumerated() {
                                    if let dic = item.element.dictionary {
                                        let progress = IRDTask.init()
                                        progress.transferFromDic(dictionary: dic)
                                        taskList.insert(progress, at: item.0)
                                    }
                                }
                            }
                            completion(taskList, pageNumber, pageSize, nil)
                        }
        })
    }
    
    func finishTask(taskID: String, completion:@escaping (_ error: NSError?) -> Void) -> Void {
        network.post(path: "/task/" + taskID + "/finish",
                     params: [:],
                     completion: { (_ data, _ error: NSError?) -> Void in
                        completion(error)
        })
    }
}
