//
//  MoviePageViewController.swift
//  Super easy dev
//
//  Created by petar on 22.06.2024
//

import UIKit

protocol MoviePageViewProtocol: AnyObject {
}

class MoviePageViewController: UIViewController {
    // MARK: - Public
    var presenter: MoviePagePresenterProtocol?

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

// MARK: - Private functions
private extension MoviePageViewController {
    func initialize() {
    }
}

// MARK: - MoviePageViewProtocol
extension MoviePageViewController: MoviePageViewProtocol {
}
