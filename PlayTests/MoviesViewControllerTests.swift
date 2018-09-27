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

@testable import Play

class MoviesViewControllerTests: QuickSpec {
    
    override func spec() {
        var controller: MoviesViewController!
        let moviesMock: [Movie] = [Movie(id: 1, mediaType: "type", voteCount: 1, title: "name", posterPath: "/path", overview: "Description")]

        beforeEach {
            let storyboard = UIStoryboard(name: Storyboard.Main.storyboardName, bundle: nil)
            controller = storyboard.instantiateViewController(withIdentifier: "MoviesViewController") as? MoviesViewController
        }
        
        it("should not be nil") {
            expect(controller).notTo(beNil())
        }

        describe("MoviesViewController") {
            beforeEach {
                _ = controller.view
                controller.beginAppearanceTransition(true, animated: false)
            }
            
            it("view controlller tilte"){
                expect(controller.title) == "Filmes"
            }
            
            it ("with empty movies"){
                expect(controller.numberOfSections(in: controller.collectionView)) == 1
                expect(controller.collectionView(controller.collectionView, numberOfItemsInSection: 0)) == 0
            }
            
            it("with list of movies") {
                controller.setupCollectionView(with: moviesMock)
                expect(controller.numberOfSections(in: controller.collectionView)) == 1
                expect(controller.collectionView(controller.collectionView, numberOfItemsInSection: 0)) == 1
            }
            
            it("should be able to update the collection") {
                controller.setupCollectionView(with: moviesMock)
                let itemsCount = controller.collectionView.numberOfItems(inSection: 0)
                expect(itemsCount).to(equal(1))
            }
            
            context("didSelectedMovie") {
                beforeEach {
                    let navController: UINavigationController = Storyboard.Main.initialViewController()
                    controller = navController.viewControllers.first as? MoviesViewController
                    let _ = controller.view
                    controller.viewDidLoad()
                }

            }

            context("valid selected movie callback"){
                it("should trigger did select for valid callback") {
                    controller.setupCollectionView(with: moviesMock)
                    let firstIndex = IndexPath(item: 0, section: 0)
                    
                    controller.didSelectMovie(at: firstIndex)
                }
            }
            
            context("nil selected movie callback") {
                it("should not trigger did select for invalid callback") {
                    controller.setupCollectionView(with: moviesMock)
                    let firstIndex = IndexPath(item: 0, section: 0)
                    
                    expect { () -> Void in
                        controller.didSelectMovie(at: firstIndex)
                    }.toNot(throwAssertion())
                }
            }
        }
    }
    
    
}
    


