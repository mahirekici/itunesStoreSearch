//
//  KeychainType.swift
//  Imkb
//
//  Created by mahir ekici on 4.12.2021.
//  Copyright © 2021 mahir ekici. All rights reserved.
//

import RxSwift

protocol AppAPI {
    func search(term: String, limit: Int, offset: Int,searchMediaType:SearchMediaType) -> Single<SearchDto>
    func searchDetail(id: String) -> Single<DetailsDto>
}
