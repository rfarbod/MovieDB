//
//  MovieDBTests.swift
//  MovieDBTests
//
//  Created by Farbod Rahiminik on 9/14/24.
//

import AppDomain
import Combine
import MovieDB
import XCTest

final class MovieDBTests: XCTestCase {
    private var viewModel: MoviesViewModel!
    private var mockAPI: MockMovieAPI!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockAPI = MockMovieAPI()
        viewModel = MoviesViewModel(movieAPI: mockAPI, model: .default)
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockAPI = nil
        cancellables = nil
        super.tearDown()
    }

    func testGetItemsSuccess() {
        mockAPI.moviesList = MovieResponse(
            results: [
                .init(id: 1, posterPath: "path1", overview: "overview", title: "title1", voteAverage: 9.4, voteCount: 250, genres: [.init(id: 1, name: "Drama")], productionCompanies: []),
                .init(id: 1, posterPath: "path1", overview: "overview", title: "title2", voteAverage: 9.4, voteCount: 250, genres: [.init(id: 1, name: "Drama")], productionCompanies: [])
            ],
            page: 1,
            totalPages: 10,
            totalResults: 100
        )
        
        viewModel = .init(movieAPI: mockAPI, model: .default)
        viewModel.getItems()

        let expectation = XCTestExpectation(description: "Movies should be loaded successfully")

        viewModel.$model
            .sink { model in
                if !model.isLoading && model.items.count == 2{
                    XCTAssertEqual(model.items[0].title, "title1")
                    XCTAssertEqual(model.items[1].title, "title2")
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 5.0)
    }

    func testGetItemsFailure() {
        mockAPI.shouldReturnError = true

        viewModel = .init(movieAPI: mockAPI, model: .default)

        let expectation = XCTestExpectation(description: "Loading should stop on failure")
        viewModel.getItems()
        viewModel.$model
            .sink { model in
                if !model.isLoading {
                    XCTAssertTrue(model.items.isEmpty)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2.0)
    }

}
