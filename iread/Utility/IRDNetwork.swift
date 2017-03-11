//
//  IRDNetwork.swift
//  iread
//
//  Created by honglianglu on 05/02/2017.
//  Copyright © 2017 cc. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class IRDNetwork: NSObject {
    let host = "http://43.241.215.199:3333"
    
    public func get(path: String, params: Dictionary<String, String>, completion:@escaping (_ data: JSON, _ error: NSError?) -> Void) {
        
        var tmpPath = path
        if !params.isEmpty {
            tmpPath.append("?")
            for (key, value) in params {
                tmpPath.append(key+"="+value+"&")
            }
        }
        let URL = host + tmpPath
        Alamofire.request(URL, method: .get).responseJSON { (response) in
            switch response.result {
            case .success(let result):
                let result = JSON(result)
                completion(result, nil)
            case .failure(let error):
                completion(JSON.null, error as NSError?)
            }
        }
    }
    
    public func post(path: String, params: Dictionary<String, Any>, completion:@escaping (_ data: JSON?, _ error: NSError?) -> Void)  {
        let URL = host + path
        
        Alamofire.request(URL, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success(let result):
                let result = JSON(result)
                completion(result, nil)
            case .failure(let error):
                completion(JSON.null, error as NSError?)
            }
        }
    }
    
    public func delete(path: String, params: Dictionary<String, Any>, completion:@escaping (_ data: JSON?, _ error: NSError?) -> Void)  {
        let URL = host + path
        
        Alamofire.request(URL, method: .delete, parameters: params, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success(let result):
                let result = JSON(result)
                completion(result, nil)
            case .failure(let error):
                completion(JSON.null, error as NSError?)
            }
        }
    }
}
