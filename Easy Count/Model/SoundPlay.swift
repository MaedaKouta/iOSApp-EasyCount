//
//  SoundPlay.swift
//  Easy Count
//
//  Created by 前田航汰 on 2021/08/06.
//

import Foundation
import AVFoundation

class SoundPlay{

    var audioPlayer : AVAudioPlayer!

    func play(fileName:String, extentionName:String){

        //パスを生成
        guard let soundFilePath = Bundle.main.path(forResource:fileName, ofType: extentionName) else {
            print("サウンドファイルが見つからない")
            return
        }
 
        // AVAudioPlayerのインスタンスを作成,ファイルの読み込み
        do {
            let sound: URL = URL(fileURLWithPath: soundFilePath)
            audioPlayer = try AVAudioPlayer(contentsOf: sound, fileTypeHint: nil)
        } catch {
            print("AVAudioPlayerInstance代入時にエラー")
        }

        //バックミュージック流しながらでも効果音を流すコード
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(AVAudioSession.Category.ambient)
            try audioSession.setActive(true)
        } catch {
            print("バックミュージックを流しながら効果音を流すコードでエラー")
        }

        if audioPlayer.prepareToPlay() {
            audioPlayer.currentTime = 0
            audioPlayer.play()
        } else {
            print("再生直前に失敗")
        }
    }

}

