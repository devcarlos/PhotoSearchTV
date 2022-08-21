//
//  DataFetchPhase.swift
//  PhotoSearchTV
//
//  Created by Carlos Alcala on 20/8/22.
//

import Foundation

enum DataFetchPhase<T> {
    
    case empty
    case success(T)
    case failure(Error)
    
    var value: T? {
        if case .success(let value) = self {
            return value
        }
        return nil
    }
    
}
