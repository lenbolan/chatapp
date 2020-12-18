//
//  Builder.swift
//  Landing
//
//  Created by lenbo lan on 2020/12/17.
//

import UIKit
import Utility

public final class Builder {
    
    public static func build() -> UIViewController {
        let storyboard = UIStoryboard.init(name: "Landing", bundle: Bundle.init(for: self))
        let view = LandingViewController.instantiate(from: storyboard)
        return view
    }
}
