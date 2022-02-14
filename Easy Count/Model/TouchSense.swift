//
//  touchSense.swift
//  Easy Count
//
//  Created by 前田航汰 on 2021/08/06.
//

import Foundation
import AudioToolbox

class TouchSense {
    func vibrate() {
        AudioServicesPlaySystemSound(SystemSoundID(1519))
    }
}
