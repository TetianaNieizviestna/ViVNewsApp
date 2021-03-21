//
//  ArticleDetailsViewController.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 21.03.2021.
//

import UIKit
import WebKit

extension ArticleDetailsViewController {
    struct Props {
        
        let state: ScreenState; enum ScreenState {
            case initial
            case failed(String)
        }
                
        let url: String
        
        static let initial: Props = .init(state: .initial, url: "")
    }
}

final class ArticleDetailsViewController: UIViewController {
    var viewModel: ArticleDetailsViewModelType!
    var props: Props = .initial

    @IBOutlet private var backBtn: UIButton!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var favouritesBtn: UIButton!
    @IBOutlet private var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        viewModel.didStateChanged = { [weak self] props in
            DispatchQueue.main.async {
                self?.render(props)
            }
        }

    }
    
    private func setupUI() {
        setupButtons()
    }
    
    private func setupButtons() {
        
    }
    
    func render(_ props: Props) {
        self.props = props
        if let url = URL(string: props.url){
            webView.load(URLRequest(url: url))
        }
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
    }
    
    @IBAction func favouritesBtnAction(_ sender: UIButton) {
    }
    
}
