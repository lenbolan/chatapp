//
//  LiaoliaoTabbarController.swift
//  Tabbar
//
//  Created by lenbo lan on 2020/12/26.
//

import UIKit

typealias LiaoliaoTabs = ()

protocol Presentation {
    
}

protocol TabbarView: class {
    
}

class LiaoliaoTabbarController: UITabBarController {
    
    var presenter: Presentation?
    
    init(tabs: LiaoliaoTabs) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension LiaoliaoTabbarController: TabbarView {
    
}
