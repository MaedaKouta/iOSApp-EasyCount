//
//  SettingInitialNumberViewController.swift
//  Easy Count
//
//  Created by 前田航汰 on 2022/02/08.
//

import UIKit

class SettingInitialNumberViewController: UIViewController {
    
    @IBOutlet weak var InitialNumberTextField: UITextField!
    @IBOutlet weak var decisionButton: UIButton!
    @IBOutlet weak var errorTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        InitialNumberTextField.setUnderLine()
        decisionButton.layer.cornerRadius = 20
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        InitialNumberTextField.becomeFirstResponder()
    }
    
    @IBAction func pressDecisionButton(_ sender: Any) {
        if let initialNumber = Int(InitialNumberTextField.text ?? "") {
            errorTextLabel.text = ""
            UserDefaults.standard.set(initialNumber, forKey: "initialNumber")
            self.navigationController?.popViewController(animated: true)
        } else {
            errorTextLabel.text = "⚠適切な数値を入力して下さい"
        }
        
        
    }
    
    
    
}

extension UITextField {
    func setUnderLine() {
        // 枠線を非表示にする
        borderStyle = .none
               let underline = UIView()
               // heightにはアンダーラインの高さを入れる
        underline.frame = CGRect(x: 0, y: frame.height, width: frame.width, height: 2.0)
               // 枠線の色
               underline.backgroundColor = .blue
               addSubview(underline)
               // 枠線を最前面に
               bringSubviewToFront(underline)
    }
}
