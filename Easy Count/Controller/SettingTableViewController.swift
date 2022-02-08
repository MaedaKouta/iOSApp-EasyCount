//
//  SettingTableViewController.swift
//  Easy Count
//
//  Created by 前田航汰 on 2021/08/06.
//

import UIKit

class SettingTableViewController: UITableViewController {

    @IBOutlet weak var soundSwitch: UISwitch!
    @IBOutlet weak var vibrateSwitch: UISwitch!
    @IBOutlet weak var versionLabel: UILabel!
    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String

        
    override func viewDidLoad() {
        super.viewDidLoad()

        soundSwitch.isOn = UserDefaults.standard.bool(forKey: "soundValue")
        vibrateSwitch.isOn = UserDefaults.standard.bool(forKey: "vibrateValue")
        versionLabel.text = version
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
    

    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
