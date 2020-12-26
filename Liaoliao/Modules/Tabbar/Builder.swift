//
//  Builder.swift
//  Tabbar
//
//  Created by lenbo lan on 2020/12/26.
//

import UIKit

public final class Builder {
    
    public static func build() -> UITabBarController {
        let submodules: Router.Submodules = ()
        
        let tabs: LiaoliaoTabs = Router.tabs(usingSubmodules: submodules)
        
        let presenter = Presenter(useCases: ())
        
        let view = LiaoliaoTabbarController(tabs: tabs)
        
        presenter.view = view
        
        view.presenter = presenter
        
        return view
    }
    
}
