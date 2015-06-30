//
//  GridTests.swift
//  RSContactGridTests
//
//  Created by Matthias Fey on 22.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

import XCTest
import RSContactGrid

class GridTests: XCTestCase {
    
    var grid: ContactGrid!
    
    override func setUp() {
        super.setUp()
        
        grid = ContactGrid()
    }
    
    func testInsertingAndRemoving() {
        XCTAssert(grid.isEmpty)
        XCTAssertEqual(grid.count, 0)
        grid.insert(ContactGrid.Segment(x: 0, y: 0))
        XCTAssert(!grid.isEmpty)
        XCTAssertEqual(grid.count, 1)
        grid.insertAtX(1, y: 0)
        XCTAssert(!grid.isEmpty)
        XCTAssertEqual(grid.count, 2)
        grid.insertAtX(1, y: 0)
        XCTAssert(!grid.isEmpty)
        XCTAssertEqual(grid.count, 2)
        grid.removeAtX(1, y: 0)
        XCTAssert(!grid.isEmpty)
        XCTAssertEqual(grid.count, 1)
        grid.removeAtX(2, y: 0)
        XCTAssert(!grid.isEmpty)
        XCTAssertEqual(grid.count, 1)
        grid.remove(ContactGrid.Segment(x: 2, y: 0))
        XCTAssert(!grid.isEmpty)
        XCTAssertEqual(grid.count, 1)
        grid.remove(ContactGrid.Segment(x: 0, y: 0))
        XCTAssert(grid.isEmpty)
        XCTAssertEqual(grid.count, 0)
        
        grid.insertAtX(0, y: 0)
        grid.insertAtX(2, y: 0)
        let segment1 = grid[0, 0]
        XCTAssert(segment1 != nil)
        XCTAssertEqual(segment1!.x, 0)
        XCTAssertEqual(segment1!.y, 0)
        let segment2 = grid[1, 0]
        XCTAssert(segment2 == nil)
        XCTAssert(!grid.isEmpty)
        XCTAssertEqual(grid.count, 2)
        grid.removeAll()
        XCTAssert(grid.isEmpty)
        XCTAssertEqual(grid.count, 0)
    }
    
    func testHashingAndEquality() {
        var grid1 = ContactGrid()
        grid1.insertAtX(0, y: 0)
        
        var grid2 = ContactGrid()
        grid2.insertAtX(1, y: 0)
        
        XCTAssertNotEqual(grid1.hashValue, grid2.hashValue)
        XCTAssertNotEqual(grid1, grid2)
        
        grid1.insertAtX(1, y: 0)
        grid2.insertAtX(0, y: 0)
        
        XCTAssertEqual(grid1.hashValue, grid2.hashValue)
        XCTAssertEqual(grid1, grid2)
    }
    
    func testInitialising() {
        let grid1 = ContactGrid()
        XCTAssertEqual(grid1.count, 0)
        XCTAssert(grid1.isEmpty)
        
        let grid2 = ContactGrid(minimumCapacity: 10)
        XCTAssertEqual(grid2.count, 0)
        XCTAssert(grid2.isEmpty)
        
        let grid3: ContactGrid = [ContactGrid.Segment(x: 0, y: 0), ContactGrid.Segment(x: 1, y: 0)]
        XCTAssertEqual(grid3.count, 2)
        XCTAssert(!grid3.isEmpty)
        
        let grid4 = ContactGrid(Set([ContactGrid.Segment(x: 0, y: 0), ContactGrid.Segment(x: 1, y: 0)]))
        XCTAssertEqual(grid4.count, 2)
        XCTAssert(!grid4.isEmpty)
        
        let grid5 = ContactGrid([ContactGrid.Segment(x: 0, y: 0), ContactGrid.Segment(x: 1, y: 0), ContactGrid.Segment(x: 1, y: 0)])
        XCTAssertEqual(grid5.count, 2)
        XCTAssert(!grid5.isEmpty)
    }
    
    func testSequenceType() {
        grid.insertAtX(0, y: 0)
        grid.insertAtX(1, y: 0)
        grid.insertAtX(2, y: 0)
        
        for (index, segment) in grid.enumerate() {
            XCTAssertLessThan(index, 3)
            XCTAssertEqual(segment.y, 0)
            XCTAssertLessThan(segment.x, 3)
        }
        
        let filteredGrid = ContactGrid(grid.filter { $0.x == 0 })
        XCTAssertEqual(filteredGrid.count, 1)
        XCTAssert(!filteredGrid.isEmpty)
        
        let mappedArray = grid.map { $0.x }
        XCTAssertEqual(mappedArray.count, 3)
        XCTAssert(!mappedArray.isEmpty)
        XCTAssertEqual(mappedArray.sort(), [0, 1, 2])
    }
}
