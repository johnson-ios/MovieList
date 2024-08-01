//
//  MovieAppTests.swift
//  MovieAppTests
//
//  Created by jaya kumar on 01/08/24.
//

import XCTest
@testable import MovieApp

final class MovieAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Called after the invocation of each test method in the class.
    }

    func testFetchMovies() throws {
        let expectation = self.expectation(description: "fetchMovies")
        let apiService = APIService()
        apiService.fetchMovies(searchTerm: "Marvel") { result in
            switch result {
            case .success(let movies):
                XCTAssertFalse(movies.isEmpty, "Movies list should not be empty")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Error: \(error)")
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFetchMovieDetails() throws {
        let expectation = self.expectation(description: "fetchMovieDetails")
        let apiService = APIService()
        apiService.fetchMovieDetails(imdbID: "tt0371746") { result in
            switch result {
            case .success(let movieDetail):
                XCTAssertEqual(movieDetail.title, "Iron Man", "The movie title should be Iron Man")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Error: \(error)")
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testPerformanceExample() throws {
        // Example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
