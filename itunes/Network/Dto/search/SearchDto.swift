//
//  Json4Swift_Base.swift
//  Imkb
//
//  Created by mahir ekici on 7.12.2021.
//  Copyright © 2021 mahir ekici. All rights reserved.
//



import Foundation
struct SearchDto : Codable {
    let resultCount : Int?
    let results : [SearchResultDto]?

    enum CodingKeys: String, CodingKey {

        case resultCount = "resultCount"
        case results = "results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        resultCount = try values.decodeIfPresent(Int.self, forKey: .resultCount)
        results = try values.decodeIfPresent([SearchResultDto].self, forKey: .results)
    }

}
