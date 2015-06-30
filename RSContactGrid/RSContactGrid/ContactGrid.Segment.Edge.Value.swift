//
//  ContactGrid.Segment.Edge.Value.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 29.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

// MARK: CustomStringConvertible / CustomDebugStringConvertible

extension ContactGrid.Segment.Edge.Value : CustomDebugStringConvertible {
    
    /// A textual representation of `self`.
    public var description: String {
        switch self {
        case .Left: return "left"
        case .Top: return "top"
        case .Right: return "right"
        case .Bottom: return "bottom"
        }
    }
    
    /// A textual representation of `self`, suitable for debugging.
    public var debugDescription: String { return "ContactGrid.Segment.Edge.Value(\(self)" }
}