//
//  Router.swift
//  Tabbar
//
//  Created by lenbo lan on 2020/12/26.
//

import UIKit

class Router {
    
    typealias Submodules = (
        chatrooms: UIViewController,
        friends: UIViewController,
        profile: UIViewController
    )
    
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
}

extension Router {
    
    static func tabs(usingSubmodules submodules: Submodules) -> LiaoliaoTabs {
        
        let chatsImage = UIImage(systemName: "ellipsis.bubble.fill")
        let friendsImage = UIImage(systemName: "person.2.fill")
        let profileImage = UIImage(systemName: "person.fill")
        
        let chatroomsTabbarItem =  UITabBarItem(title: "Chat", image: chatsImage, tag: 100)
        let friendsTabbarItem =  UITabBarItem(title: "Friends", image: friendsImage, tag: 101)
        let profileTabbarItem =  UITabBarItem(title: "Profile", image: profileImage, tag: 102)
        
        submodules.chatrooms.tabBarItem = chatroomsTabbarItem
        submodules.friends.tabBarItem = friendsTabbarItem
        submodules.profile.tabBarItem = profileTabbarItem
        
        return (
            chatrooms: submodules.chatrooms,
            friends: submodules.friends,
            profile: submodules.profile
        )
    }
    
}

extension Router: Routing {
    
}
