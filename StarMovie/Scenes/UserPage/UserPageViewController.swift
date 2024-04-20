//
//  UserPageViewController.swift
//  Super easy dev
//
//  Created by petar on 17.04.2024
//

import UIKit

protocol UserPageViewProtocol: AnyObject {
}

class UserPageViewController: UIViewController {
    // MARK: - Public
    var presenter: UserPagePresenterProtocol?

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

// MARK: - Private functions
private extension UserPageViewController {
    func initialize() {
    }
}

// MARK: - UserPageViewProtocol
extension UserPageViewController: UserPageViewProtocol {
}
