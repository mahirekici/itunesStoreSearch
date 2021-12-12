//
//  ErrorModel.swift
//  Imkb
//
//  Created by mahir ekici on 12.12.2021.
//  Copyright © 2021 mahir ekici. All rights reserved.
//

import Foundation

enum ErrorModel: Error {
    case network(string: String)
    case parse(string: String)
    case other(string: String)
}
