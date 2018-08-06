//
//  APIService.swift
//  JustClean
//
//  Created by Jitendra Deore on 06/08/18.
//  Copyright © 2018 Jitendra Deore. All rights reserved.
//

import Foundation

/// Generic enum for result
///
/// - success: will return an instance of type T
/// - failure: will return the failure with appropriate error
enum Result<T>{
    case success(T)
    case failure(Error?)
}

class APIService {
    
    var pageNum = 1
    
    /// Method to fetch api data
    ///
    /// - Parameters:
    ///   - apiURL: request URL
    ///   - onCompletion: completion handler that returns result.
    func fetchData(apiURL: String,onCompletion:@escaping (Result<List>)-> Void) {
        
        // Create the URLSession on the default configuration
        let defaultSessionConfiguration = URLSessionConfiguration.default
        let defaultSession = URLSession(configuration: defaultSessionConfiguration)
        
        // Passing the search controller text ...
        // Setup the request with URL
        
        let url = URL(string: apiURL + "&page=" + String(pageNum))
        var urlRequest = URLRequest(url: url!)  // Note: This is a demo, that's why I use implicitly unwrapped optional
        
        // Set the httpMethod and assign httpBody
        urlRequest.httpMethod = "GET"
        
        var requestInProgress = false
        // Create dataTask
        let dataTask = defaultSession.dataTask(with: urlRequest) {[weak self](data, response, error) in
            
            
            guard let strongSelf = self,!requestInProgress else{
                return
            }
            
            requestInProgress = true
            if error != nil {
                print(error ?? "")
                onCompletion(.failure(error))
            } else {
                do {
                    
                    if let response = try JSONSerialization.jsonObject(with:data!, options: []) as? JSONItem{
                        if  let listItem = List(json: response){
                            DispatchQueue.main.async {
                                strongSelf.pageNum = strongSelf.pageNum + 1
                                onCompletion(.success(listItem))
                            }
                        }
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
        }
        
        
        
        // Fire the request
        dataTask.resume()
    }
}
    



