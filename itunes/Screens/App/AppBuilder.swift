//
//  
//  Imkb
//
//  Created by mahir ekici on 4.12.2021.
//  Copyright © 2021 mahir ekici. All rights reserved.
//
import UIKit

final class AppBuilder: ViewBuilder {
    typealias BuildData = UIWindow
    typealias ViewController = NSNull
    
    static func build(with window: BuildData? = nil) -> NSNull {
        
        let homeViewController = SearchViewBuilder.build()
        
        let navigationController = UINavigationController(rootViewController: homeViewController)
        
        navigationController.navigationBar.barTintColor = .red
        navigationController.navigationBar.topItem?.title =  "IMKB Hisse ve Endeksler"
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
       navigationController.navigationItem.leftBarButtonItem?.tintColor =  .white
        navigationController.navigationItem.backBarButtonItem?.tintColor =  .white
        
        

        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()
        
        return NSNull.init()
    }
}
