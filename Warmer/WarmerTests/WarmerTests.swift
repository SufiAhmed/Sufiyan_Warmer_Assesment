//
//  WarmerTests.swift
//  WarmerTests
//
//  Created by Sufiyan Ahmed on 10/16/25.
//

import XCTest
import Testing
@testable import Warmer

final class BrowserPageViewModelTests: XCTestCase {

    var viewModel: BrowserViewModel!

    override func setUp() {
        super.setUp()
        viewModel = BrowserViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

  private func createSampleCategories() -> [Warmer.Category] {
        return [
            Warmer.Category(
                id: 1,
                name: "Adoption",
                description: nil,
                offerings: [
                    Warmer.Offering(
                        id: 1249,
                        felloUserProfileId: 12890,
                        felloName: "Savannah V.",
                        photoURL: URL(string: "https://fello-profile-prod.s3.us-east-1.amazonaws.com/profile-pics/4f999685-546e-4ba2-a819-6af1d906fe48.jpg"),
                        offeringTitle: "Family safety and navigating abuse",
                        offeringStory: "My journey includes surviving intimate partner violence...",
                        topics: ["Complicated grief", "Embracing vulnerability", "Homelessness"],
                        felloRating: 0.0,
                        nextAvailabilityDate: "2025-10-16T09:30:00-05:00",
                        organizationName: nil
                    )
                ]
            ),
            Warmer.Category(
                id: 2,
                name: "Parenting",
                description: "Support for parents",
                offerings: [
                    Warmer.Offering(
                        id: 1786,
                        felloUserProfileId: 13706,
                        felloName: "Nathon M.",
                        photoURL: URL(string: "https://fello-profile-prod.s3.us-east-1.amazonaws.com/profile-pics/19e4de9c-d45a-4e62-aa17-d1906bd7714b.jpg"),
                        offeringTitle: "Being a parent in recovery",
                        offeringStory: "I've been in recovery for over 10 years...",
                        topics: ["Becoming a parent", "Foster parenting"],
                        felloRating: 4.95,
                        nextAvailabilityDate: "2025-10-18T07:00:00-05:00",
                        organizationName: nil
                    )
                ]
            ),
            Warmer.Category(
                id: 3,
                name: "Mental Health",
                description: "Mental health support",
                offerings: []
            )
        ]
    }

    func testInitialState() {
        XCTAssertTrue(viewModel.categoriesList.isEmpty)
        XCTAssertTrue(viewModel.searchText.isEmpty)
        XCTAssertTrue(viewModel.imageCache.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
    }

    func testFilteredCategoriesListWithEmptySearch() {
        viewModel.categoriesList = createSampleCategories()
        viewModel.searchText = ""

        let filtered = viewModel.filteredCategoriesList
        XCTAssertEqual(filtered.count, 3)
        XCTAssertEqual(filtered, viewModel.categoriesList)
    }

    func testFilteredCategoriesListWithExactMatch() {
        viewModel.categoriesList = createSampleCategories()
        viewModel.searchText = "Adoption"

        let filtered = viewModel.filteredCategoriesList
        XCTAssertEqual(filtered.count, 1)
        XCTAssertEqual(filtered.first?.name, "Adoption")
    }

    func testFilteredCategoriesListNoMatches() {
        viewModel.categoriesList = createSampleCategories()
        viewModel.searchText = "Sufiyan"

        let filtered = viewModel.filteredCategoriesList
        XCTAssertTrue(filtered.isEmpty)
    }

    func testFilteredCategoriesListMultipleMatches() {
        var categories = createSampleCategories()
        categories.append(Warmer.Category(id: 4, name: "Physical Health", description: nil, offerings: []))
        viewModel.categoriesList = categories
        viewModel.searchText = "Health"

        let filtered = viewModel.filteredCategoriesList
        XCTAssertEqual(filtered.count, 2)
        let names = filtered.compactMap { $0.name }
        XCTAssertTrue(names.contains("Mental Health"))
        XCTAssertTrue(names.contains("Physical Health"))
    }
}
