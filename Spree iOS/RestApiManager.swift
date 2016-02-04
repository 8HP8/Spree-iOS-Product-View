//
//  RestApiManager.swift
//  Spree iOS
//
//  Created by Hugo Prinsloo on 2016/02/02.
//  Copyright © 2016 HugoPrinsloo. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias ServiceResponce = (JSON, NSError?) ->Void

class RestApiManager: NSObject {
    static let sharedInstance = RestApiManager()
    
    let baseURL = "https://www.spree.co.za/api/v1/catalog/browse/2641"
    
    func makeHTTPGetRequest(path: String, onCompletion: ServiceResponce){
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in

            let json : JSON = JSON(data : data!)
            onCompletion(json, error)
        }
        task.resume()
    }
    
    func doSomeThing(onCompletion: (JSON) -> Void) {
        makeHTTPGetRequest(baseURL) { (json, err) -> Void in
            onCompletion(json)
        }
    }
    
    
}