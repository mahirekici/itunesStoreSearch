//
//  SearchViewBuilder.swift
//  Imkb
//
//  Created by mahir ekici on 7.12.2021.
//  Copyright © 2021 mahir ekici. All rights reserved.
//

import Foundation


final class SearchDetailViewBuilder: ViewBuilder {
    typealias BuildData = (Int,SearchMediaType)
    typealias ViewController = SearchDetailViewController
    
    static func build(with buildData: BuildData? = nil) -> SearchDetailViewController {
        let viewController = SearchDetailViewController.instantiate()
        
        let id = buildData?.0 ?? 0
        
        let service = AppService.shared
        
        viewController.viewModelBuilder = {
            SearchDetailViewModel(
                input: $0,
                dependencies: (
                    id: id,
                    service: service,
                    searchMediaType:buildData!.1
                )
            )
        }
        
        return viewController
    }
}
