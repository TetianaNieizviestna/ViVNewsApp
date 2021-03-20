//
//  NewsViewController.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 19.03.2021.
//

import UIKit

final class NewsViewController: UIViewController {
    var viewModel: NewsViewModelType!

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var segmentedControl: UISegmentedControl!
    @IBOutlet private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupSegmentedControl()
        setupTableView()
    }
    
    private func setupSegmentedControl() {
        let textAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: Style.Color.segmentText        ]
            
        segmentedControl.setTitleTextAttributes(textAttributes, for: .selected)
        segmentedControl.setTitleTextAttributes(textAttributes, for: .normal)
        segmentedControl.selectedSegmentTintColor = Style.Color.segmentBg
        segmentedControl.backgroundColor = Style.Color.segmentBgSelected
    }
    
    private func setupTableView() {

    }
}
