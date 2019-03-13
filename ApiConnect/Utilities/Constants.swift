//
//  Constants.swift
//  ApiConnect
//
//  Created by chihhao on 2019-03-09.
//  Copyright © 2019 ChihHao. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"
let HEADER = [
    "Content-Type": "application/json; charset=utf-8"
]

// API URL
let URL_REGISTER = "\(BASE_URL)/users"
let URL_LOGIN = "\(BASE_URL)/users/login"
