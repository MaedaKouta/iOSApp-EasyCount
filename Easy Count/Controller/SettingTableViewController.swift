//
//  SettingTableViewController.swift
//  Easy Count
//
//  Created by 前田航汰 on 2021/08/06.
//

import UIKit

class SettingTableViewController: UITableViewController {

    @IBOutlet private weak var soundSwitch: UISwitch!
    @IBOutlet private weak var vibrationSwitch: UISwitch!
    @IBOutlet private weak var screenLockSwitch: UISwitch!
    @IBOutlet private weak var initialNumberTextLabel: UILabel!
    @IBOutlet private weak var versionLabel: UILabel!

    override func viewDidLoad() {
        print("didload")
        super.viewDidLoad()
        versionLabel.text = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }

    override func viewWillAppear(_ animated: Bool) {
        print("willAppear")
        super.viewWillAppear(animated)
        soundSwitch.isOn = UserDefaultsKey.sound.get() ?? Bool()
        vibrationSwitch.isOn = UserDefaultsKey.vibration.get() ?? Bool()
        initialNumberTextLabel.text = UserDefaultsKey.initialNumber.get() ?? "0"
        screenLockSwitch.isOn = UserDefaultsKey.screenLock.get() ?? Bool()
    }

    @IBAction private func soundSwitch(_ sender: UISwitch) {
        if sender.isOn {
            UserDefaultsKey.sound.set(value: true)
        } else {
            UserDefaultsKey.sound.set(value: false)
        }
    }

    @IBAction private func vibrateSwitch(_ sender: UISwitch) {
        if sender.isOn {
            UserDefaultsKey.vibration.set(value: true)
        } else {
            UserDefaultsKey.vibration.set(value: false)
        }
        print(UserDefaultsKey.initialNumber.get() ?? String())
    }

    @IBAction private func screenLockSwitch(_ sender: UISwitch) {
        if sender.isOn {
            UIApplication.shared.isIdleTimerDisabled = true
            UserDefaultsKey.screenLock.set(value: true)
        } else {
            UIApplication.shared.isIdleTimerDisabled = false
            UserDefaultsKey.screenLock.set(value: false)
        }
    }

    @IBAction private func pressWriteReviewButton(_ sender: Any) {
        if let url = URL(string: "https://apps.apple.com/jp/app/easy-count/id1580335092?uo=4&action=write-review") {
            UIApplication.shared.open(url)
        }
    }

    @IBAction private func pressShareButton(_ sender: Any) {
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

    @IBAction private func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
