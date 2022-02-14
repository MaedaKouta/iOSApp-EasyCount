//
//  ViewController.swift
//  Easy Count
//
//  Created by 前田航汰 on 2021/08/05.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum countType {
        case up
        case down
        case reset
    }

    @IBOutlet private weak var countNumberTextLabel: UILabel!
    @IBOutlet private weak var countUpButton: UIButton!
    @IBOutlet private weak var countDownButton: UIButton!

    private var countNumberInt: Int = 0
    private var upGradientColor: CAGradientLayer!
    private var downGradientColor: CAGradientLayer!
    private let soundPlay = SoundPlay()  //サウンドのインスタンス
    private let touchSense = TouchSense()  //触覚フィードバックのインスタンス
    private let gradation = Gradation()  //グラデーションのインスタンス

    override func viewDidLoad() {
        super.viewDidLoad()
        
        countNumberTextLabel.adjustsFontSizeToFitWidth = true
        countNumberInt = UserDefaults.standard.integer(forKey: "countNumberInt")
        UIApplication.shared.isIdleTimerDisabled = UserDefaults.standard.bool(forKey: "screenLock")
        countNumberTextLabel.text = String(countNumberInt)
        

        //UPグラーデションを配置
        upGradientColor = gradation.upGradient()
        upGradientColor.frame = self.view.bounds
        countUpButton.layer.insertSublayer(upGradientColor, at:0)
        //DOWNグラーデションを配置
        downGradientColor = gradation.downGradient()
        downGradientColor.frame = self.view.bounds
        countDownButton.layer.insertSublayer(downGradientColor, at:0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        countNumberInt = UserDefaults.standard.integer(forKey: "initialNumber")
        countNumberTextLabel.text = String(countNumberInt)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UserDefaults.standard.set(self.countNumberInt, forKey: "countNumberInt")
    }

    @IBAction private func pressUpButton(_ sender: Any) {
        buttonAction(countType: countType.up)
        print(UIApplication.shared.isIdleTimerDisabled)
    }

    @IBAction private func pressDownButton(_ sender: Any) {
        buttonAction(countType: countType.down)
    }

    @IBAction private func pressResetButton(_ sender: Any) {
        buttonAction(countType: countType.reset)
    }

    //設定画面への画面遷移
    @IBAction private func setting(_ sender: Any) {
        let nextView = storyboard?.instantiateViewController(withIdentifier: "Next") as! SettingTableViewController
        nextView.modalPresentationStyle = .fullScreen
        self.present(nextView, animated: true, completion: nil)
    }

    private func buttonAction(countType: countType) {
        var soundName = ""
        
        switch countType {
        case .up:
            countNumberInt += 1
            soundName = "soundUp"
        case .down:
            countNumberInt -= 1
            soundName = "soundUp"
        case .reset:
            countNumberInt = UserDefaults.standard.integer(forKey: "initialNumber")
            soundName = "soundUp"
        }
        
        // TextLabelへの表示
        countNumberTextLabel.fadeTransition(0.1)
        countNumberTextLabel.text = String(countNumberInt)
        
        // 設定項目のSoundとVibrationを判定
        if(UserDefaults.standard.bool(forKey: "vibrateValue") == true){
            touchSense.vibrate()
        }
        if(UserDefaults.standard.bool(forKey: "soundValue") == true){
            soundPlay.play(fileName: soundName, extentionName: "mp3")
        }
    }

}

//カウントアップのアニメーションをextention
extension UIView {
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}
