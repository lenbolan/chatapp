//
//  Builder.swift
//  ChatroomLogin
//
//  Created by lenbo lan on 2020/12/18.
//

import UIKit
import Utility

public final class Builder {
    
    public static func build() -> UIViewController {
        let storyboard = UIStoryboard.init(name: "ChatroomLogin", bundle: Bundle.init(for: self))
        let view = ChatroomLoginViewController.instantiate(from: storyboard)
        return view
    }
    
}
