//
//  Imkb
//
//  Created by mahir ekici on 4.12.2021.
//  Copyright © 2021 mahir ekici. All rights reserved.
//
import UIKit

extension UITableView {
    
    func register(with identifier: String) {
        register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
}
