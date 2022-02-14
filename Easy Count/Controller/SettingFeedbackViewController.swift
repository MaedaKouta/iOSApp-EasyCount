//
//  SettingFeedbackViewController.swift
//  Easy Count
//
//  Created by 前田航汰 on 2022/02/08.
//

import UIKit
import WebKit

class SettingFeedbackViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: "https://forms.gle/84rk1eZP49ZQzusL6") {
            self.webView.load(URLRequest(url: url))
        } else if let url = URL(string: "https://tetoblog.org/error02/") {
            self.webView.load(URLRequest(url: url))
            print("エラー専用のURLが取得されました")
        } else {
            print("URLが取得できませんでした。")
        }
    }
}
