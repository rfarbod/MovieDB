//
//  MovieDBUITests.swift
//  MovieDBUITests
//
//  Created by Farbod Rahiminik on 9/14/24.
//

import XCTest

final class MovieDBUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()

        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testIfTableViewIsThere() {
        let tableView = app.tables["MoviesTableView"]
        XCTAssertTrue(tableView.exists, "The table view should exist on the screen")
    }

    func testTableViewInteraction() {
        let tableView = app.tables["MoviesTableView"]
        let expectation = self.expectation(description: "Waiting for 5 seconds")

        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
            expectation.fulfill()
        })

        waitForExpectations(timeout: 5.0)

        let firstCell = tableView.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists, "The first cell should exist")

        firstCell.tap()

        let detailView = app.otherElements["MovieDetailsView"]
        XCTAssertTrue(detailView.exists, "The detail view should be displayed after tapping the cell")
    }
}
