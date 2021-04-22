//
//  InternetVC.swift
//  BottleRocketTest
//
//  Created by Eze Emenike on 4/13/21.
//

import UIKit
import WebKit

class InternetVC: UIViewController {
    
    //MARK: - Property
    
    private var refreshButton: UIButton?
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView(frame: .zero)
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.view = webView
        webView.navigationDelegate = self
        return webView
    }()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadWebPage()
        self.setupNavItems()
    }
    
    // MARK: - Private
    
    private func setupNavItems() {
        let backButton = UIBarButtonItem(image: UIImage(named: "ic_webBack"), style: .plain, target: self, action: #selector(self.navigateBackOnWeb))
        backButton.tintColor = UIColor.white
        
        let refreshButton = UIButton()
        refreshButton.setImage(UIImage(named: "ic_webRefresh"), for: .normal)
        refreshButton.addTarget(self, action: #selector(self.refreshOnWeb), for: .touchUpInside)
        let barRefreshButton = UIBarButtonItem(customView: refreshButton)
        barRefreshButton.tintColor = UIColor.white
        self.refreshButton = refreshButton
        
        let forwardButton = UIBarButtonItem(image: UIImage(named: "ic_webForward"), style: .plain, target: self, action: #selector(self.navigateForwardOnWeb))
        forwardButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItems = [backButton, barRefreshButton, forwardButton]
    }
    
    // MARK: - Private
    
    private func loadWebPage() {
        guard let url = URL(string: NetworkConstants.webPage) else { return }
        self.webView.load(URLRequest(url: url))
        self.webView.allowsBackForwardNavigationGestures = true
    }
    
    @objc func navigateBackOnWeb() {
        self.webView.goBack()
    }
    
    @objc func refreshOnWeb() {
        if self.webView.isLoading {
            self.webView.stopLoading()
            self.refreshButton?.setImage(UIImage(named: "ic_webRefresh"), for: .normal)
        } else {
            self.webView.reload()
            self.refreshButton?.setImage(UIImage(named: "ic_close"), for: .normal)
        }
    }
    
    @objc func navigateForwardOnWeb() {
        self.webView.goForward()
    }
    
}

extension InternetVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.refreshButton?.setImage(UIImage(named: "ic_webRefresh"), for: .normal)
    }
}
