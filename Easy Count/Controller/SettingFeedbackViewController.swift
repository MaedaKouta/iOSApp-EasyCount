//
//  SettingFeedbackViewController.swift
//  Easy Count
//
//  Created by 前田航汰 on 2022/02/08.
//

import UIKit
import WebKit

class SettingFeedbackViewController: UIViewController {

    @IBOutlet private weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: "https://forms.gle/84rk1eZP49ZQzusL6") {
            self.webView.load(URLRequest(url: url))
        } else {
            print("URLが取得できませんでした。")
        }
    }
}
