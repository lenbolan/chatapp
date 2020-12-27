//
//  Builder.swift
//  Tabbar
//
//  Created by lenbo lan on 2020/12/26.
//

import UIKit

import Utility
import Chatrooms
import Friends
import Profile

public final class Builder {
    
    public static func build() -> UITabBarController {
        let submodules: Router.Submodules = (
            chatrooms: Chatrooms.Builder.build(usingNavigationFactory: UINavigationController.build),
            friends: Friends.Builder.build(usingNavigationFactory: UINavigationController.build),
            profile: Profile.Builder.build(usingNavigationFactory: UINavigationController.build)
        )
        
        let tabs: LiaoliaoTabs = Router.tabs(usingSubmodules: submodules)
        
        let presenter = Presenter(useCases: ())
        
        let view = LiaoliaoTabbarController(tabs: tabs)
        
        presenter.view = view
        
        view.presenter = presenter
        
        return view
    }
    
}
