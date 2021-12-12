//
//  SearchCellViewModel.swift
//  Imkb
//
//  Created by mahir ekici on 7.12.2021.
//  Copyright © 2021 mahir ekici. All rights reserved.
//

import Foundation


struct SearchDetailCellViewModel {

    
    var wrapperType: String?

    var artistName: String?
    var trackName: String?
    var collectionArtistId, amgArtistId: Int?
    var primaryGenreId: Int?
    var collectionId: Int?
    var collectionName, collectionCensoredName: String?
    var artistViewURL, collectionViewURL: String?
    var  artworkUrl100: String?
    var longDescription:String?
 
 
    
    init(result: DetailsResultDto) {
   
        self.wrapperType =  result.wrapperType
        self.artistName =  result.artistName
        self.collectionArtistId =  result.collectionArtistId
        self.collectionName =  result.collectionName
        self.artworkUrl100 =  result.artworkUrl100
        self.collectionId = result.collectionId
        self.collectionViewURL = result.collectionArtistViewUrl
        self.trackName = result.trackName
        self.collectionName =  result.collectionName
        self.longDescription = result.longDescription
    }
    

}


import RxDataSources


struct SearchDetailTableViewModel {
    var title: String
    var items: [SearchDetailCellViewModel]
}

extension SearchDetailTableViewModel: SectionModelType {
    typealias Item = SearchDetailCellViewModel
    
    init(original: SearchDetailTableViewModel, items: [Item]) {
        self = original
        self.items = items
    }
}

