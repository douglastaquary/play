//
//  Storyboard.swift
//  Play
//
//  Created by douglas taquary on 17/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import Foundation

import Foundation
import UIKit

protocol StoryboardSceneType {
    static var storyboardName: String { get }
}

extension StoryboardSceneType {
    static func storyboard() -> UIStoryboard {
        return UIStoryboard(name: self.storyboardName, bundle: nil)
    }
    
    static func initialViewController() -> UIViewController {
        guard let vc = storyboard().instantiateInitialViewController() else {
            fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
        }
        return vc
    }
}

extension StoryboardSceneType where Self: RawRepresentable, Self.RawValue == String {
    func viewController() -> UIViewController {
        return Self.storyboard().instantiateViewController(withIdentifier: self.rawValue)
    }
    static func viewController(identifier: Self) -> UIViewController {
        return identifier.viewController()
    }
}

protocol StoryboardSegueType: RawRepresentable { }

extension UIViewController {
    func performSegue<S: StoryboardSegueType>(segue: S, sender: AnyObject? = nil) where S.RawValue == String {
        performSegue(withIdentifier: segue.rawValue, sender: sender)
    }
}

// swiftlint:disable file_length
// swiftlint:disable type_body_length
struct Storyboard {
    
    enum LaunchScreen: StoryboardSceneType {
        static let storyboardName = "LaunchScreen"
    }
    
    
    enum Main: String, StoryboardSceneType {
        static let storyboardName = "Main"
        
        static func initialViewController() -> UINavigationController {
            guard let vc = storyboard().instantiateInitialViewController() as? UINavigationController else {
                fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
            }
            return vc
        }
        
        case movieViewControllerScene = "MovieViewController"
        static func instantiateViewController() -> MoviesViewController {
            guard let vc = Storyboard.Main.movieViewControllerScene.viewController() as? MoviesViewController
                else {
                    fatalError("ViewController 'MoviesViewController' is not of the expected class MoviesViewController.")
            }
            return vc
        }
        
        case movieDetailViewControllerScene = "MovieDetailViewController"
        static func instantiateViewController() -> MovieDetailViewController {
            guard let vc = Storyboard.Main.movieDetailViewControllerScene.viewController() as? MovieDetailViewController
                else {
                    fatalError("ViewController 'MovieDetailViewController' is not of the expected class MovieDetailViewController.")
            }
            return vc
        }
    }
    
}

