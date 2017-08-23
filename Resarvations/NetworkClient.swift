//
//  NetworkClient.swift
//  Resarvations
//
//  Created by redEyeProgrammer on 8/20/17.
//  Copyright © 2017 redEye. All rights reserved.
//

import Foundation


public final class NetworkClient {
    
    // MARK: - Instance Properties
    internal let baseURL: URL
    internal let session = URLSession.shared
    
    // MARK: - Class Constructors
    public static let shared: NetworkClient = {
        let file = Bundle.main.path(forResource: "ServerEnvironments", ofType: "plist")!
        let dictionary = NSDictionary(contentsOfFile: file)!
        let urlString = dictionary["service_url"] as! String
        let url = URL(string: urlString)!
        return NetworkClient(baseURL: url)
    }()
    
    // MARK: - Object Lifecycle
    private init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    public func getService(forType type: Services.ServiceType,
                            success _success: @escaping ([Services]) -> Void,
                            failure _failure: @escaping (NetworkError) -> Void) {
        
        let success: ([Services]) -> Void = { services in
            DispatchQueue.main.async { _success(services) }
        }
        let failure: (NetworkError) -> Void = { error in
            DispatchQueue.main.async { _failure(error) }
        }
        let url = baseURL.appendingPathComponent("/redEyeProgrammer/Reservations/planes")
        
        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
            
            
            guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode.isSuccessHTTPCode,
                let data = data,
                let jsonObject = try? JSONSerialization.jsonObject(with: data),
                let json = jsonObject as? [[String: Any]] else {
                    if let error = error {
                        failure(NetworkError(error: error))
                    } else {
                        failure(NetworkError(response: response))
                    }
                    return
            }

            let services = Services.array(jsonArray: json)
            success(services)
        })
        
        task.resume()
    }
    
    
}
