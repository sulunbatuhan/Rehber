//
//  RehberUnitTests.swift
//  RehberUnitTests
//
//  Created by batuhan on 20.10.2023.
//

import XCTest
@testable import Rehber

final class RehberUnitTests: XCTestCase {

    private var viewModel : ContactsViewModel!
    private var view : MockContactsController!

    override func setUp() {
        super.setUp()
        view = .init()
        viewModel = .init(view: view)
    }
    
    override func tearDown() {
        super.tearDown()
    }

    
    func test_detail(){
        viewModel.didSelectRow(at: 2)
//        XCTAssertEqual(viewModel.cellForRow(indexPath: at), <#T##expression2: Equatable##Equatable#>)
    }
    

}
