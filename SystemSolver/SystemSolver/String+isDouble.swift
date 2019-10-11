//
//  String+isInt.swift
//  SystemSolver
//
//  Created by Lance Sigersmith on 3/2/19.
//  Copyright © 2019 Lance Sigersmith. All rights reserved.
//

import Foundation

extension String {
    var isDouble: Bool {
        return Double(self) != nil
    }
}
