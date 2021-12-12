//
//  SearchRouter.swift
//  Imkb
//
//  Created by mahir ekici on 7.12.2021.
//  Copyright © 2021 mahir ekici. All rights reserved.
//

import Foundation


import UIKit

protocol SearchRouter {
    var viewController: SearchViewController? { get }
    
    func routeToDetail(with id: Int, searchMediaType:SearchMediaType)
}

final class SearchViewRouter: SearchRouter {
    var viewController: SearchViewController?
    
    func routeToDetail(with id: Int, searchMediaType:SearchMediaType) {
        let detailViewController = SearchDetailViewBuilder.build(with: (id,searchMediaType))
        viewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}



