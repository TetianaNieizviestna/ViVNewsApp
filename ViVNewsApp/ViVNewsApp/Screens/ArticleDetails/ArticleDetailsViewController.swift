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
        let url: String
        let isFavourite: Bool
        
        let onBack: Command
        let onFavourite: Command
        
        static let initial: Props = .init(url: "", isFavourite: false, onBack: .nop, onFavourite: .nop)
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
            self?.render(props)
        }
    }
    
    private func setupUI() {
        setupButtons()
    }
    
    private func setupButtons() {
        favouritesBtn.setImage(Style.Image.favourite, for: .normal)
        favouritesBtn.setImage(Style.Image.favouriteSelected, for: .selected)
    }
    
    func render(_ props: Props) {
        self.props = props
        favouritesBtn.isSelected = props.isFavourite
        if props.isFavourite {
            favouritesBtn.setImage(Style.Image.favouriteSelected, for: .selected)
        } else {
            favouritesBtn.setImage(Style.Image.favourite, for: .normal)
        }
        
        if let url = URL(string: props.url){
            webView.load(URLRequest(url: url))
        }
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.props.onBack.perform()
    }
    
    @IBAction func favouritesBtnAction(_ sender: UIButton) {
        self.props.onFavourite.perform()
    }
    
}
