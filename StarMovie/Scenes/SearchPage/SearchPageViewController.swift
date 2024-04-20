//
//  SearchPageViewController.swift
//  Super easy dev
//
//  Created by petar on 17.04.2024
//

import UIKit

protocol SearchPageViewProtocol: AnyObject {
}

class SearchPageViewController: UIViewController {
    // MARK: - Public
    var presenter: SearchPagePresenterProtocol?

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

// MARK: - Private functions
private extension SearchPageViewController {
    func initialize() {
    }
}

// MARK: - SearchPageViewProtocol
extension SearchPageViewController: SearchPageViewProtocol {
}
