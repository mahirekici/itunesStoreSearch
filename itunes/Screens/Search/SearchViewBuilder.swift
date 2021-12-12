//
//  SearchViewBuilder.swift
//  Imkb
//
//  Created by mahir ekici on 7.12.2021.
//  Copyright © 2021 mahir ekici. All rights reserved.
//

import Foundation

final class SearchViewBuilder {
    
    static func build() -> SearchViewController {
        let viewController = SearchViewController.instantiate()
        
        let router = SearchViewRouter()
        router.viewController = viewController
        
        let service = AppService.shared
        
        viewController.viewModelBuilder = { [router] in
            let viewModel = SearchViewModel(input: $0,
                            dependencies: (
                                service: service, ()
                            )
            )
            
            viewModel.router = router
            
            return viewModel
        }
        
        return viewController
    }
}
