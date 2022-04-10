//
//  Extensions.swift
//  NetflexClone
//
//  Created by 김희진 on 2022/04/04.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
