//
//  SettingInitialNumberViewController.swift
//  Easy Count
//
//  Created by 前田航汰 on 2022/02/08.
//

import UIKit

class SettingInitialNumberViewController: UIViewController {

    @IBOutlet private weak var initialNumberTextField: UITextField!
    @IBOutlet private weak var decisionButton: UIButton!
    @IBOutlet private weak var errorTextLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // TextFieldをアンダーラインにする
        initialNumberTextField.setUnderLine()
        decisionButton.layer.cornerRadius = 20
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // キーボードを表示させる
        initialNumberTextField.becomeFirstResponder()
    }

    @IBAction private func pressDecisionButton(_ sender: Any) {
        if let initialNumber = Int(initialNumberTextField.text ?? "") {
            errorTextLabel.text = ""
            UserDefaultsKey.initialNumber.set(value: String(initialNumber))
            self.navigationController?.popViewController(animated: true)
        } else {
            errorTextLabel.text = "⚠適切な数値を入力して下さい"
            initialNumberTextField.endEditing(true)
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
