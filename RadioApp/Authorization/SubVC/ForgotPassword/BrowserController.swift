//
//  BrowserController.swift
//  RadioApp
//
//  Created by Мария Нестерова on 05.08.2024.
//

import UIKit
import WebKit

final class BrowserController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    private var completion: (() -> Void)?
    
    init(completion: (() -> Void)?) {
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        completion?()
    }
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://www.google.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}
