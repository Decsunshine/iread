//
//  IRDBookModel.swift
//  iread
//
//  Created by honglianglu on 12/02/2017.
//  Copyright © 2017 cc. All rights reserved.
//

import Foundation

// Swift 本该更简洁、更具描述力

class IRDBookModel: IRDBaseModel {
    let userID = IRDEnvironment.shareInstance.user.ID
    
    func bookList(pageNumber: String, pageSize: String, completion:@escaping (_ data: Array<IRDBook>?, _ bookNumber: String, _ bookSize: String, _ error: NSError?) -> Void) -> Void {
        network.get(path: "/user/" + userID + "/books",
                    params: ["pageNum": pageNumber, "pageSize": pageSize],
                    completion: { (_ data: Dictionary?, _ error: NSError?) -> Void in
                        if (error != nil) {
                            completion(nil, "", "", error)
                        } else {
                            var pageNumber: String = ""
                            var pageSize: String = ""
                            if let number = data?["pageNum"] as? Int {
                                pageNumber = String(number)
                            }
                            if let size = data?["pageSize"] as? Int {
                                pageSize = String(size)
                            }
                            var bookList = [IRDBook]()
                            if let list = data?["list"] as? Array<AnyObject> {
                                for item in list.enumerated() {
                                    if let dic = item.1 as? Dictionary<String, AnyObject> {
                                        let book = IRDBook.init()
                                        book.transferFromDic(dictionary: dic)
                                        bookList.insert(book, at: item.0)
                                    }
                                }
                            }
                            completion(bookList, pageNumber, pageSize, nil)
                        }
        })
    }
    
    func addBook(name: String, completion: @escaping (_ error: NSError?) -> Void) -> Void {
        let param = ["name": name] as [String: Any]
        network.post(path: "/user/" + userID + "/books",
                     params: param,
                     completion: { (_ data, _ error: NSError?) -> Void in
                        completion(error)
                        
        })
    }
    
    func progressList(bookID: String?, pageNumber: String, pageSize: String, completion:@escaping (_ data: Array<IRDProgress>?, _ bookNumber: String, _ bookSize: String, _ error: NSError?) -> Void) -> Void {
        guard let bookID = bookID else { return }
        network.get(path: "/book/" + bookID + "/bookitems",
                    params: ["pageNum": pageNumber, "pageSize": pageSize],
                    completion: { (_ data: Dictionary?, _ error: NSError?) -> Void in
                        if (error != nil) {
                            completion(nil, "", "", error)
                        } else {
                            var pageNumber = ""
                            var pageSize = ""
                            if let number = data?["pageNum"] as? Int {
                                pageNumber = String(number)
                            }
                            if let size = data?["pageSize"] as? Int {
                                pageSize = String(size)
                            }
                            var progressList = [IRDProgress]()
                            if let list = data?["list"] as? Array<AnyObject> {
                                for item in list.enumerated() {
                                    if let dic = item.1 as? Dictionary<String, AnyObject> {
                                        let progress = IRDProgress.init()
                                        progress.transferFromDic(dictionary: dic)
                                        progressList.insert(progress, at: item.0)
                                    }
                                }
                            }
                            completion(progressList, pageNumber, pageSize, nil)
                        }
        })
    }
    
    func addBookProgress(startPage: String, endPage: String, bookID: String?, completion: @escaping (_ error: NSError?) -> Void) -> Void {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateformatter.string(from: NSDate() as Date)
        
        let param = ["startPos": startPage,
                     "endPos": endPage,
                     "readDate": dateString] as [String: Any]
        
        if let bookID = bookID {
            network.post(path: "/book/" + bookID + "/bookitems",
                         params: param,
                         completion: { (_ data, _ error: NSError?) -> Void in
                            completion(error)
            })
        }
    }
    
    func deleteProgress(progressID: String, completion: @escaping (_ error: NSError?) -> Void) -> Void {
        network.delete(path: "/bookitems/" + progressID,
                       params: [:],
                       completion: { (_ data, _ error: NSError?) -> Void in
                        completion(error)
        })
        
    }
}
