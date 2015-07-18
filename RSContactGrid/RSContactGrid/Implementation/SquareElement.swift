//
//  SquareElement.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 24.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

public struct SquareElementArea {
    
    // MARK: Static variables
    
    /// Defines the width of a squared element.
    public static var width: CGFloat = 20
    
    /// Defines the height of a squared element.
    public static var height: CGFloat = 20
}

public struct SquareElement<T, S> : GridElementType {
    
    // MARK: Initializers
    
    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    /// Create a `SquareElement` at x- and y-coordinates with specific
    /// content and contact.
    public init(x: Int, y: Int, content: T?, contact: S?) {
        self.init(x: x, y: y)
        self.content = content
        self.contact = contact
    }
    
    // MARK: Instance variables
    
    public let x: Int
    
    public let y: Int
    
    /// The content stored by the element.
    public var content: T?
    
    /// The contact stored by the element.
    public var contact: S?
    
    // MARK: Static variables
    
    // The width of the element.
    public static var width: CGFloat { return SquareElementArea.width }
    
    // The height of the element.
    public static var height: CGFloat { return SquareElementArea.height }
}

// MARK: Instance variables

extension SquareElement {
    
    public var frame: CGRect {
        return CGRect(x: CGFloat(x)*SquareElement<T, S>.width,
                      y: CGFloat(y)*SquareElement<T, S>.height,
                      width: SquareElement<T, S>.width,
                      height: SquareElement<T, S>.height)
    }

    public var vertices: [CGPoint] {
        return [CGPoint(x: CGFloat(x)*SquareElement<T, S>.width, y: CGFloat(y)*SquareElement<T, S>.height),
                CGPoint(x: CGFloat(x)*SquareElement<T, S>.width, y: CGFloat(y+1)*SquareElement<T, S>.height),
                CGPoint(x: CGFloat(x+1)*SquareElement<T, S>.width, y: CGFloat(y+1)*SquareElement<T, S>.height),
                CGPoint(x: CGFloat(x+1)*SquareElement<T, S>.width, y: CGFloat(y)*SquareElement<T, S>.height)]
    }
}

// MARK: Instance functions

extension SquareElement {
    
    public func intersectsRelativeLineSegment(point1 point1: RelativeRectPoint, point2: RelativeRectPoint) -> Bool {
        return true
    }
}

// MARK: Static functions

extension SquareElement {

    public static func elementsInRect<T, S>(rect: CGRect) -> Set<SquareElement<T, S>> {
        
        let startSegment = segmentOfCoordinates(rect.origin)
        let endSegment = segmentOfCoordinates(CGPoint(x: rect.origin.x+rect.size.width, y: rect.origin.y+rect.size.height))
        
        var elements = Set<SquareElement<T, S>>(minimumCapacity: (endSegment.0-startSegment.0)*(endSegment.1-startSegment.1))
        for x in startSegment.0...endSegment.0 {
            for y in startSegment.1...endSegment.1 {
                elements.insert(SquareElement<T, S>(x: x, y: y))
            }
        }
        return elements
    }
    
    private static func segmentXOfCoordinate(coordinate: CGFloat) -> Int {
        return coordinate < 0 && fmod(coordinate, width) != 0 ? Int(coordinate/width)-1 : Int(coordinate/width)
    }
    
    private static func segmentYOfCoordinate(coordinate: CGFloat) -> Int {
        return coordinate < 0 && fmod(coordinate, height) != 0 ? Int(coordinate/height)-1 : Int(coordinate/height)
    }
    
    private static func segmentOfCoordinates(coordinates: CGPoint) -> (Int, Int) {
        return (segmentXOfCoordinate(coordinates.x), segmentYOfCoordinate(coordinates.y))
    }
}

// MARK: Comparable

extension SquareElement {}
public func == <T, S>(lhs: SquareElement<T, S>, rhs: SquareElement<T, S>) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}
public func < <T, S>(lhs: SquareElement<T, S>, rhs: SquareElement<T, S>) -> Bool {
    return lhs.y < rhs.y || (lhs.y == rhs.y && lhs.x < rhs.x)
}

// MARK: CustomDebugStringConvertible

extension SquareElement {

    public var debugDescription: String { return "SquareElement(\(self)" }
}
