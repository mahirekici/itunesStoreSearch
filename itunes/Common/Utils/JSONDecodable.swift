
//  Imkb
//
//  Created by mahir ekici on 4.12.2021.
//  Copyright © 2021 mahir ekici. All rights reserved.
//
import Foundation

func makeJSONData<T: Codable>(_ value: T) -> Data {
    var jsonData = Data()
    let jsonEncoder = JSONEncoder()
    
    do {
        jsonData = try jsonEncoder.encode(value)
    } catch { }
    
    return jsonData
}
