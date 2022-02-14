//
//  StorageUserDefaultKey.swift
//  Easy Count
//
//  Created by 前田航汰 on 2022/02/14.
//

import Foundation

enum UserDefaultsKey: String {
    case sound = "sound"
    case vibration = "vibration"
    case initialNumber = "initialNumber"
    case screenLock = "screenLock"
    case countNumber = "countNumber"

    func get<T>() -> T? {
        return UserDefaults.standard.object(forKey: self.rawValue) as? T
    }

    func set<T>(value: T) {
        UserDefaults.standard.set(value, forKey: self.rawValue)
    }

    func remove() {
        UserDefaults.standard.removeObject(forKey: self.rawValue)
    }
}
