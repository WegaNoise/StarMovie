//
//  HomePageViewController.swift
//  Super easy dev
//
//  Created by petar on 11.04.2024
//

import UIKit
import SnapKit

protocol HomePageViewProtocol: AnyObject {
}

final class HomePageViewController: UIViewController {

    var presenter: HomePagePresenterProtocol?

    let homeCollectionView = HomeCollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

// MARK: - Private functions
private extension HomePageViewController {
    func initialize() {
        view.backgroundColor = Resources.Colors.mainColorGray
        title = Resources.Titls.homePage
        
        view.addSubview(homeCollectionView)
        homeCollectionView.snp.makeConstraints { collection in
            collection.leading.equalToSuperview().offset(10)
            collection.trailing.equalToSuperview().offset(-10)
            collection.bottom.top.equalToSuperview()
        }
    }
}

// MARK: - HomePageViewProtocol
extension HomePageViewController: HomePageViewProtocol {
}
