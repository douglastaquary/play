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
    
    override func spec() {
        var controller: MovieDetailViewController!
        //let snapshotService = SnapshotService()
        
        let movie = Movie(id: 2, mediaType: "Madmax", voteCount: 13, title: "name", posterPath: "/path", overview: "Description")
        movie.posterImage = UIImage(named: "madmax")
        
        describe("MovieDetailViewController") {
            beforeEach {
                let movie = Movie(id: 2, mediaType: "Madmax", voteCount: 13, title: "name", posterPath: "/path", overview: "Description")
                controller = MovieDetailViewController(with: movie)
            }
            
            it("should be able to create a controller") {
               expect(controller).toNot(beNil())
            }
            
            it("should have a view of type"){
                controller.viewWillAppear(true)
                expect(controller.view).to(beAKindOf(MovieDetailView.self))
            }
        }
    }
}
