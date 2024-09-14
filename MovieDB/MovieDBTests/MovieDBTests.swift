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

    func testPaginationAvoidingDuplicates() {
        mockAPI.shouldReturnError = false
        viewModel = .init(movieAPI: mockAPI, model: .default)

        for i in 1...50 {
            mockAPI.moviesList = MovieResponse(
                results: [
                    .init(id: UUID().hashValue, posterPath: "path1", overview: "overview", title: "title1", voteAverage: 9.4, voteCount: 250, genres: [.init(id: 1, name: "Drama")], productionCompanies: []),
                    .init(id: UUID().hashValue, posterPath: "path2", overview: "overview", title: "title2", voteAverage: 9.4, voteCount: 250, genres: [.init(id: 1, name: "Drama")], productionCompanies: [])
                ],
                page: i,
                totalPages: 50,
                totalResults: 100
            )
            
            viewModel.getItems()

            let expection = XCTestExpectation(description: "Wait for 25 milliseconds")

            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(25), execute: {
                expection.fulfill()
            })

            wait(for: [expection], timeout: 0.025)
        }

        XCTAssertTrue(viewModel.model.items.count == 100)

        let ids = viewModel.model.items.map { $0.id }
        var seenIds: Set<String> = .init()
        for id in ids {
            if seenIds.contains(id) {
                XCTAssertThrowsError(TestError.foundDuplicates, "Found duplicates")
            } else {
                seenIds.insert(id)
            }
        }
    }

}

enum TestError: Error {
    case foundDuplicates
}
