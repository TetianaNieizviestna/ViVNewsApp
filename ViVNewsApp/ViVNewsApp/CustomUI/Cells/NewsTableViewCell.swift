//
//  NewsTableViewCell.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 20.03.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    struct Props {
        let title: String
        let author: String
        let source: String
        let date: String
        let description: String
        let imageUrl: String?
        let isFavorite: Bool
        let type: NewsSegmentTab
        
        let onSelect: Command
        
        static let initial: Props = .init(title: "", author: "", source: "", date: "", description: "", imageUrl: nil, isFavorite: false, type: .emailed, onSelect: .nop)
    }

    @IBOutlet private var bgView: UIView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var loadedImageView: UIImageView!
    @IBOutlet private var favouritesImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        loadedImageView.setCornersRadius(6)
        bgView.setCornersRadius(6)
    }
    
    func render(_ props: Props) {
        titleLabel.text = props.title
        descriptionLabel.text = props.description
        dateLabel.text = props.date
        if props.isFavorite {
            favouritesImageView.image = Style.Image.favouriteSelected
        } else {
            favouritesImageView.isHidden = true
        }
        loadedImageView.setImage(by: props.imageUrl)
    }
}
