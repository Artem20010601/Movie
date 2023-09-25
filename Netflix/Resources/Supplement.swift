//
//  Supplement.swift
//  Spotidy
//
//  Created by Artem on 12/09/2023.
//

import Foundation

class Observable<T> {
    
    var value: T {
        didSet {
            DispatchQueue.main.async {
                self.completion?(self.value)
            }
        }
    }
    
    init(value: T) {
        self.value = value
    }
    
    private var completion: ((T) -> Void)?
    
    func bind(_ completion: @escaping (T) -> Void) {
        completion(value)
        self.completion = completion
    }
}
