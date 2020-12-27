//
//  UINavigationController+Extension.swift
//  Utility
//
//  Created by lenbo lan on 2020/12/27.
//

import UIKit

public typealias NavigationFactory = (UIViewController) -> UINavigationController

extension UINavigationController {
    
    public static func build(rootView: UIViewController) -> UINavigationController {
        
        let navigationController = UINavigationController(rootViewController: rootView)
        navigationController.navigationBar.prefersLargeTitles = true
        
        let textStyleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor : UIColor.deepPurple,
            .font : UIFont.init(name: "ArialRoundedMTBold", size: 20.0)!
        ]
        
        let largeTextStyleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor : UIColor.deepPurple,
            .font : UIFont.init(name: "ArialRoundedMTBold", size: 36.0)!
        ]
        
        navigationController.navigationBar.titleTextAttributes = textStyleAttributes
        navigationController.navigationBar.largeTitleTextAttributes = largeTextStyleAttributes
        
        return navigationController
        
    }
    
}
