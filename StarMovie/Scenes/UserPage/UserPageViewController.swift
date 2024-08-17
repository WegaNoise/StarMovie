//
//  UserPageViewController.swift
//  StarMovie
//
//  Created by petar on 17.04.2024
//

import UIKit
import SnapKit

protocol UserPageViewProtocol: AnyObject {
}

class UserPageViewController: UIViewController {
    
    var presenter: UserPagePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

private extension UserPageViewController {
    func initialize() {
        view.backgroundColor = .purple
        navigationItem.title = Resources.Titls.userPage
    }
}

// MARK: - UserPageViewProtocol
extension UserPageViewController: UserPageViewProtocol {
}
