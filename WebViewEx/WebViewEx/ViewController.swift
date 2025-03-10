//
//  ViewController.swift
//  WebViewEx
//
//  Created by 윤태한 on 3/10/25.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textUrl: UITextField!
    @IBOutlet weak var myWebView: WKWebView!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    func loadWebPage(_ url: String){
        // URL -> URLRequest -> Load
        let myUrl = URL(string: url)!
        let myRequest = URLRequest(url: myUrl)
        myWebView.load(myRequest)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebPage("https://www.naver.com")
    }


    @IBAction func btnGotoUrl(_ sender: UIButton) {
        myActivityIndicator.startAnimating()
        myActivityIndicator.isHidden = false
        loadWebPage(textUrl.text ?? "")
    }
    @IBAction func btnSite1(_ sender: UIButton) {
        myActivityIndicator.startAnimating()
        myActivityIndicator.isHidden = false
    }
    @IBAction func btnSite2(_ sender: UIButton) {
        myActivityIndicator.startAnimating()
        myActivityIndicator.isHidden = false
    }
    @IBAction func btnLoadHtmlString(_ sender: UIButton) {
        myActivityIndicator.startAnimating()
        myActivityIndicator.isHidden = false
    }
    @IBAction func btnLoadHTMLFile(_ sender: UIButton) {
        myActivityIndicator.startAnimating()
        myActivityIndicator.isHidden = false
    }
    
    @IBAction func btnStop( sender: UIBarButtonItem) {
    }

    @IBAction func btnReload( sender: UIBarButtonItem) {
    }

    @IBAction func btnGoBack( sender: UIBarButtonItem) {
    }

    @IBAction func btnGoForward(_ sender: UIBarButtonItem) {
    }
}

