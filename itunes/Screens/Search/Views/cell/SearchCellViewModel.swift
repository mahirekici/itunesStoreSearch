//
//  SearchCellViewModel.swift
//  Imkb
//
//  Created by mahir ekici on 7.12.2021.
//  Copyright © 2021 mahir ekici. All rights reserved.
//

import Foundation

enum WrapperType: String, Decodable {
    case audiobook = "audiobook"
    case track = "track"
}

struct SearchCellViewModel {

    var collectionName : String?
    var kind : String?
    var trackId : Int?
    var artistId : Int?
    var artistName : String?
    var trackName : String?
    var wrapperType :WrapperType?
    var artworkUrl60 : String?
    init(result: SearchResultDto) {
        wrapperType =   WrapperType(rawValue: result.wrapperType!)
        kind =  result.kind
        trackId =  result.trackId
        artistName =  result.artistName
        trackName =  result.trackName
        collectionName = result.collectionName
        artistId = result.artistId
        artworkUrl60 =  result.artworkUrl60
    
    }
    
//    func getId() -> Int?{
//        // track ise track id
//        // değilse artist is
//        return wrapperType == WrapperType.track
//            ? trackId
//            : artistId
 //   }
}


import RxDataSources


struct SearchTableViewModel {
    var title: String
    var items: [SearchCellViewModel]
}

extension SearchTableViewModel: SectionModelType {
    typealias Item = SearchCellViewModel
    
    init(original: SearchTableViewModel, items: [Item]) {
        self = original
        self.items = items
    }
}

