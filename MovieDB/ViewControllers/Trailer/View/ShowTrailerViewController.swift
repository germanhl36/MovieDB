//
//  ShowTrailerViewController.swift
//  MovieDB
//
//  Created by German Huerta on 09/09/21.
//

import Foundation
import UIKit
import WebKit

class ShowTrailerViewController: UIViewController {
    private var viewModel:TrailerItemProtocol!
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUIContent()
    }
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ShowTrailerViewController {
    func config(with vm:TrailerItemProtocol) {
        self.viewModel = vm
    }
}

extension ShowTrailerViewController {
    func updateUIContent() {
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: self.viewModel.getPath()) {
                let request = URLRequest(url: url)
                DispatchQueue.main.async {
                    self.webView.load(request)
                }
                
            }
        }
       
    }
}
