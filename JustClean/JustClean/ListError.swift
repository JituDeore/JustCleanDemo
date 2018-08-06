//
//  ListError.swift
//  JustClean
//
//  Created by Jitendra Deore on 06/08/18.
//  Copyright © 2018 Jitendra Deore. All rights reserved.
//

import Foundation
struct ListErrorCodes {
    static let JSONParse           = 2001
    static let noContent           = 204
    static let noNetWork           = -1009
    static let invalidURL          = 20003
    static let invalidData         = 20004
    static let timeOut             = NSURLErrorTimedOut
}

enum ListError: Error {
    case apiError(error: Error?)
    case parseError(json: [String: Any]?)
    case defaultError()
}

