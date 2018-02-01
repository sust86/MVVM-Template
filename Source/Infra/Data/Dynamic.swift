//
//  Dynamic.swift
//  QA
//
//  Created by Stefan Stumpfl on 1/31/18.
//  Copyright © 2018 LinkedIn. All rights reserved.
//

import Foundation

class Dynamic<T> {
    typealias Listener = (T) -> ()

    // MARK: - Public Properties

    var listener: Listener?

    var value: T {
        didSet {
            listener?(value)
        }
    }

    // MARK: - Lifecycle

    init(_ v: T) {
        value = v
    }

    // MARK: - Public Methods

    func bind(_ listener: Listener?) {
        self.listener = listener
    }

    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }

}
