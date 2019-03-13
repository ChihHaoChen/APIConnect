//
//  AuthService.swift
//  ApiConnect
//
//  Created by chihhao on 2019-03-09.
//  Copyright © 2019 ChihHao. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService   {
    static let instance = AuthService()
    // UserDefaults is good to store simple data like strings....
    let defaults = UserDefaults.standard
    
    var isLoggedIn: Bool    {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken: String   {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String   {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(email: String, password: String)  {
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        registerLoginRequest(URL: URL_REGISTER, body: body) {(success) in
            if(success) {
                self.registerLoginRequest(URL: URL_LOGIN, body: body) { (sucess) in
                    if(success) {
                        print("A new user is registered and logged-in.")
                    }
                }
                
            }
        }

    }
    
    func loginUser(email: String, password: String)    {
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        registerLoginRequest(URL: URL_LOGIN, body: body)  {(success) in
            if(success) {
                print("User successfully logged-in.")
            }
        }
    }
    
    func registerLoginRequest(URL: String, body: [String: Any], completion: @escaping CompletionHandler) {
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                guard let dataHeader = response.response?.allHeaderFields else { return }
                let dataJson = JSON(data: data)
                let header = dataHeader as? [String: String]
                
                print("\(URL) is used here..")
                
                self.userEmail = dataJson["user"].stringValue
                guard let token = header?["x-auth"] else { return }
                self.authToken = token
                self.isLoggedIn = true
                completion(true)
            }
            else    {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
}
