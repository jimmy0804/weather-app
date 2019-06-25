//
//  UIStoryboard+InstantiateViewController.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/25/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    /**
        The uniform place to state all the storyboards we have
     */
    enum Storyboard: String {
        case main       = "Main"
    }
    
    /**
        The convenience initializer to create an instance of storyboard using our defined enum value
     */
    convenience init(_ storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.rawValue, bundle: bundle)
    }
    
    /**
        Instantiates and returns the view controller for view controllers that have confirmed to StoryboardIdentifiable.
     */
    func instantiateViewController<T: UIViewController>() -> T {
        guard let viewController = instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }
        
        return viewController
    }
    
}
