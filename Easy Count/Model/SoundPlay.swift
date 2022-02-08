//
//  SoundPlay.swift
//  Easy Count
//
//  Created by 前田航汰 on 2021/08/06.
//

import Foundation
import AVFoundation

class SoundPlay{
    
    var audioPlayerInstance : AVAudioPlayer! = nil
    
    func play(fileName:String, extentionName:String){
        //パスを生成
        guard let soundFilePath = Bundle.main.path(forResource:fileName, ofType: extentionName) else {
            print("サウンドファイルが見つかりません。")
            return
        }
        let sound:URL = URL(fileURLWithPath: soundFilePath)
 
        // AVAudioPlayerのインスタンスを作成,ファイルの読み込み
        do {
            audioPlayerInstance = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
        } catch {
            print("AVAudioPlayerインスタンス作成でエラー")
        }
        
        //バックミュージック流しながらでも効果音を流すコード
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(AVAudioSession.Category.ambient)
            try audioSession.setActive(true)
        } catch let error {
                    print(error)
        }
        
        audioPlayerInstance.prepareToPlay()  // 再生準備
        audioPlayerInstance.currentTime = 0  // 再生箇所を頭に移す
        audioPlayerInstance.play()
    }
}

