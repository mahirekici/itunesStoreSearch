//
//  Imkb
//
//  Created by mahir ekici on 4.12.2021.
//  Copyright © 2021 mahir ekici. All rights reserved.
//
import UIKit

extension UIViewController {
    
    class func instantiate<T: UIViewController>(from storyboard: UIStoryboard, with identifier: String) -> T {
        storyboard.instantiateViewController(identifier: identifier) as! T
    }
    
    class func instantiate(from storyboard: UIStoryboard) -> Self {
        instantiate(from: storyboard, with: String(describing: self))
    }
    
    class func instantiate() -> Self {
        let className = String(describing: self)
        return instantiate(from: UIStoryboard(name: className, bundle: nil))
    }
}
