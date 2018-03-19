//
//  MovieTests.swift
//  PlayTests
//
//  Created by douglas taquary on 18/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
import RxSwift

@testable import Play

class MovieTests: QuickSpec {
    
    override func spec() {
        var movie: Play.Movie!
        
        describe("A movie") {
            beforeEach {
                movie = Movie(id: 2, mediaType: "Madmax", voteCount: 13, title: "name", posterPath: "/path", overview: "Description")
            }
            
            it("should not be nil") {
                expect(movie).toNot(beNil())
            }
            
            it("should have a title") {
                expect(movie.title).toNot(beNil())
            }
            
            it("should have a votes count") {
                expect(movie.voteCount).toNot(beNil())
            }
        }
    }
}
