//
//  ViewController.swift
//  Easy Count
//
//  Created by 前田航汰 on 2021/08/05.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum CountType {
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
    private let soundPlay = SoundPlay()  // サウンドのインスタンス
    private let touchSense = TouchSense()  // 触覚フィードバックのインスタンス
    private let gradation = Gradation()  // グラデーションのインスタンス

    override func viewDidLoad() {
        super.viewDidLoad()
        countNumberTextLabel.adjustsFontSizeToFitWidth = true
        countNumberInt = UserDefaultsKey.countNumber.get() ?? Int()
        countNumberTextLabel.text = String(countNumberInt)

        // UPグラーデションを配置
        upGradientColor = gradation.upGradient()
        upGradientColor.frame = self.view.bounds
        countUpButton.layer.insertSublayer(upGradientColor, at: 0)
        // DOWNグラーデションを配置
        downGradientColor = gradation.downGradient()
        downGradientColor.frame = self.view.bounds
        countDownButton.layer.insertSublayer(downGradientColor, at: 0)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        countNumberInt = UserDefaultsKey.countNumber.get() ?? Int()
        countNumberTextLabel.text = String(countNumberInt)

        UIApplication.shared.isIdleTimerDisabled = UserDefaultsKey.screenLock.get() ?? Bool()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UserDefaultsKey.countNumber.set(value: countNumberInt)
    }

    @IBAction private func pressUpButton(_ sender: Any) {
        buttonAction(countType: CountType.up)
    }

    @IBAction private func pressDownButton(_ sender: Any) {
        buttonAction(countType: CountType.down)
    }

    @IBAction private func pressResetButton(_ sender: Any) {
        buttonAction(countType: CountType.reset)
    }

    @IBAction private func setting(_ sender: Any) {
        guard let nextView = storyboard?.instantiateViewController(withIdentifier: "setting") as? SettingTableViewController else {
            return
        }
        nextView.modalPresentationStyle = .fullScreen
        self.present(nextView, animated: true, completion: nil)
    }

    private func buttonAction(countType: CountType) {
        var soundName = ""

        switch countType {
        case .up:
            countNumberInt += 1
            soundName = "soundUp"
        case .down:
            countNumberInt -= 1
            soundName = "soundDown"
        case .reset:
            countNumberInt = Int(UserDefaultsKey.initialNumber.get() ?? String()) ?? 0
            soundName = "soundReset"
        }

        // TextLabelを上書き
        // アニメーション一度使わない方向でリリース
        //countNumberTextLabel.fadeTransition(0.1)
        countNumberTextLabel.text = String(countNumberInt)

        // 設定項目のsoundとvibrationを判定
        if UserDefaultsKey.sound.get() ?? Bool() == true {
            soundPlay.play(fileName: soundName, extentionName: "mp3")
        }
        if UserDefaultsKey.vibration.get() ?? Bool() == true {
            touchSense.vibrate()
        }
    }
}

// カウントアップのアニメーションをextention
extension UIView {
    func fadeTransition(_ duration: CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}

