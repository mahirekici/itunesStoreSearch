//
//  SearchRouter.swift
//  Imkb
//
//  Created by mahir ekici on 7.12.2021.
//  Copyright © 2021 mahir ekici. All rights reserved.
//

import Foundation


import UIKit

protocol SearchDetailRouter {
    var viewController: SearchDetailViewController? { get }
    
    func routeToDetail(with id: Int)
}

final class SearchDetailViewRouter: SearchDetailRouter {
    var viewController: SearchDetailViewController?
    
    func routeToDetail(with id: Int) {
      
    }
}
