//
//  Array+Only.swift
//  Memorize
//
//  Created by Nathan on 7/8/20.
//  Copyright © 2020 Nathan. All rights reserved.
//

import Foundation



extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
