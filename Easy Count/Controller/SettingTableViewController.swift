//
//  SettingTableViewController.swift
//  Easy Count
//
//  Created by 前田航汰 on 2021/08/06.
//

import UIKit


class SettingTableViewController: UITableViewController {

    @IBOutlet private weak var soundSwitch: UISwitch!
    @IBOutlet private weak var vibrateSwitch: UISwitch!
    @IBOutlet private weak var screenLockSwitch: UISwitch!
    @IBOutlet private weak var initialNumberTextLabel: UILabel!
    @IBOutlet private weak var versionLabel: UILabel!
    
    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String


    override func viewDidLoad() {
        super.viewDidLoad()
        soundSwitch.isOn = UserDefaults.standard.bool(forKey: "soundValue")
        vibrateSwitch.isOn = UserDefaults.standard.bool(forKey: "vibrateValue")
        screenLockSwitch.isOn = UserDefaults.standard.bool(forKey: "screenLock")
        versionLabel.text = version
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initialNumberTextLabel.text = UserDefaults.standard.string(forKey: "initialNumber")
    }

    @IBAction func soundSwitch(_ sender: UISwitch) {
        if (sender.isOn) {
            UserDefaults.standard.set(true, forKey: "soundValue")
        }else{
            UserDefaults.standard.set(false, forKey: "soundValue")
        }
    }

    @IBAction func vibrateSwitch(_ sender: UISwitch) {
        if (sender.isOn) {
            UserDefaults.standard.set(true, forKey: "vibrateValue")
        }else{
            UserDefaults.standard.set(false, forKey: "vibrateValue")
        }
    }
    
    @IBAction func screenLockSwitch(_ sender: UISwitch) {
        if (sender.isOn) {
            UIApplication.shared.isIdleTimerDisabled = true
            UserDefaults.standard.set(true, forKey: "screenLock")
        }else{
            UIApplication.shared.isIdleTimerDisabled = false
            UserDefaults.standard.set(false, forKey: "screenLock")
            
        }
    }
    
    
    @IBAction func pressWriteReviewButton(_ sender: Any) {
        if let url = URL(string: "https://apps.apple.com/jp/app/easy-count/id1580335092?uo=4&action=write-review") {
            UIApplication.shared.open(url)
        }
    }
        
    
    @IBAction func pressShareButton(_ sender: Any) {
        let shareText = """
        シンプルなカウントアプリ
        「EasyCount」
        
        最高にシンプル。
        最高に使いやすい。
        あなたに最高のカウント体験を。
        
        iOSダウンロード
        https://apps.apple.com/jp/app/easy-count/id1580335092?uo=4
        """

        let activityItems = [shareText] as [Any]

        // 初期化処理
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)

        // 使用しないアクティビティタイプ
        let excludedActivityTypes = [
            UIActivity.ActivityType.postToFacebook,
            UIActivity.ActivityType.postToTwitter,
            UIActivity.ActivityType.message,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.print
        ]

        activityVC.excludedActivityTypes = excludedActivityTypes

        // UIActivityViewControllerを表示
        self.present(activityVC, animated: true, completion: nil)
    }
    
    

    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
