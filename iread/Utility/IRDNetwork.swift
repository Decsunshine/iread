//
//  IRDNetwork.swift
//  iread
//
//  Created by honglianglu on 05/02/2017.
//  Copyright © 2017 cc. All rights reserved.
//

import Foundation
import Alamofire

class IRDNetwork: NSObject {
    let host = "http://43.241.215.199:3333"
    
    public func get(path: String, params: Dictionary<String, String>, completion:@escaping (_ data: Dictionary<String, Any>?, _ error: NSError?) -> Void) {
        
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
                if let result = result as? Dictionary<String, Any> {
                    completion(result, nil)
                }
            case .failure(let error):
                completion(nil, error as NSError?)
            }
            
        }
    }
    
    public func post(path: String, params: Dictionary<String, Any>, completion:@escaping (_ data: NSDictionary?, _ error: NSError?) -> Void)  {
        let URL = host + path
        
        Alamofire.request(URL, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success(let result):
                print(result)
                if let result = result as? Dictionary<String, Any> {
                    completion(result as NSDictionary?, nil)
                }
            case .failure(let error):
                print(error)
                completion(nil, error as NSError?)
            }
            
        }
    }
}
