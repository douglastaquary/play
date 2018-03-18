//
//  MoviesViewControllerTests.swift
//  PlayTests
//
//  Created by douglas taquary on 18/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
import RxSwift
import RxNimble

@testable import Play

class MoviesViewControllerTests: QuickSpec {
    
    override func spec() {
        var viewController: MoviesViewController!
        let moviesMock: [Movie] = [Movie(id: 1, mediaType: "type", voteCount: 1, title: "name", posterPath: "/path", overview: "Descroption"),
                                   Movie(id: 2, mediaType: "type1", voteCount: 13, title: "name", posterPath: "/path", overview: "Descroption")]

        beforeEach {
            let storyboard = UIStoryboard(name: Storyboard.Main.storyboardName, bundle: nil)
            viewController = storyboard.instantiateViewController(withIdentifier: "MoviesViewController") as? MoviesViewController
        }
        
        it("should not be nil") {
            expect(viewController).notTo(beNil())
        }

        describe("Collection validation") {
            beforeEach {
  
                
                _ = viewController.view
                viewController.beginAppearanceTransition(true, animated: false)
            }
            
            it("view controlller tilte"){
                expect(viewController.title) == "Filmes"
            }
            
            
            it ("with empty response"){
                expect(viewController.numberOfSections(in: viewController.collectionView)) == 1
                expect(viewController.collectionView(viewController.collectionView, numberOfItemsInSection: 0)) == 0
            }
            
            it("with list movies") {
                viewController.setupCollectionView(with: moviesMock)
                expect(viewController.numberOfSections(in: viewController.collectionView)) == 1
                expect(viewController.collectionView(viewController.collectionView, numberOfItemsInSection: 0)) == 2
            }
        }
        
    }
    
}
    


