//
//  MovieDetailViewControllerTests.swift
//  PlayTests
//
//  Created by douglas taquary on 18/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import Play

class MovieDetailViewControllerTests: QuickSpec {
    
    var viewController: MovieDetailViewController!
    let snapshotService = SnapshotService()
    var window: UIWindow!
    
    override func spec() {
        let movie = Movie(id: 2, mediaType: "Madmax", voteCount: 13, title: "name", posterPath: "/path", overview: "Description")
        movie.posterImage = UIImage(named: "madmax")
        
        describe("MovieDetailViewController Layout") {
            beforeEach {
                
                self.viewController = MovieDetailViewController(with: movie)

                let frame = UIScreen.main.bounds
                let window = UIWindow(frame: frame)
                window.rootViewController = self.viewController
                window.makeKeyAndVisible()
                self.window = window
                self.viewController.view.frame = frame
            }
            
//            it("should have the correct portrait layout on all Sizes") {
//               expect(self.viewController.view).to(self.snapshotService.haveSnapshot())
//            }
        }
    }
}
