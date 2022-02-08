//
//  ViewController.swift
//  Easy Count
//
//  Created by 前田航汰 on 2021/08/05.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var countUpButton: UIButton!
    @IBOutlet weak var countDownButton: UIButton!

    var count = 0
    var upGradientColor:CAGradientLayer!
    var downGradientColor:CAGradientLayer!
    var soundPlay = SoundPlay()  //サウンドのインスタンス
    var touchSense = TouchSense()  //触覚フィードバックのインスタンス
    var gradation = Gradation()  //グラデーションのインスタンス
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //カウントの設定
        count = UserDefaults.standard.integer(forKey: "count")
        countLabel.text = String(count)

        //UPグラーデションを配置
        upGradientColor = gradation.upGradient()
        upGradientColor.frame = self.view.bounds
        countUpButton.layer.insertSublayer(upGradientColor, at:0)
        //DOWNグラーデションを配置
        downGradientColor = gradation.downGradient()
        downGradientColor.frame = self.view.bounds
        countDownButton.layer.insertSublayer(downGradientColor, at:0)
    }
    
    @IBAction func pressUpButton(_ sender: Any) {
        //カウントの追加,Labelの変更,Userdefaultへの登録
        count += 1
        countLabel.fadeTransition(0.1)
        countLabel.text = String(count)
        UserDefaults.standard.set(self.count, forKey: "count")
        //触覚フィードバック・サウンドのオンオフ判定から再生
        if(UserDefaults.standard.bool(forKey: "vibrateValue") == true){
            touchSense.vibrate()
        }
        if(UserDefaults.standard.bool(forKey: "soundValue") == true){
            soundPlay.play(fileName: "kako_up", extentionName: "mp3")
        }
    }
    
    
    @IBAction func pressDownButton(_ sender: Any) {
        //カウントの減少,Labelの変更,Userdefaultへの登録
        count -= 1
        countLabel.fadeTransition(0.1)
        countLabel.text = String(count)
        UserDefaults.standard.set(self.count, forKey: "count")
        //触覚フィードバック・サウンドのオンオフ判定から再生
        if(UserDefaults.standard.bool(forKey: "vibrateValue") == true){
            touchSense.vibrate()
        }
        if(UserDefaults.standard.bool(forKey: "soundValue") == true){
            soundPlay.play(fileName: "kako_down", extentionName: "mp3")
        }
    }
    
    @IBAction func pressResetButton(_ sender: Any) {
        //カウントのリセット,Labelの変更,Userdefaultへの登録
        count = 0
        countLabel.fadeTransition(0.1)
        countLabel.text = String(count)
        UserDefaults.standard.set(self.count, forKey: "count")
        //触覚フィードバック・サウンドのオンオフ判定から再生
        if(UserDefaults.standard.bool(forKey: "vibrateValue") == true){
            touchSense.vibrate()
        }
        if(UserDefaults.standard.bool(forKey: "soundValue") == true){
            soundPlay.play(fileName: "kako_reset", extentionName: "mp3")
        }
    }
    
    //設定画面への画面遷移
    @IBAction func setting(_ sender: Any) {
        let nextView = storyboard?.instantiateViewController(withIdentifier: "Next") as! SettingTableViewController
        nextView.modalPresentationStyle = .fullScreen
        self.present(nextView, animated: true, completion: nil)
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
