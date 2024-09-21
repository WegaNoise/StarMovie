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
    
    let activityIndicator = StarMovieActivityIndicator(sizeView: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

private extension UserPageViewController {
    func initialize() {
        view.backgroundColor = Resources.Colors.mainColorGray
        navigationItem.title = Resources.Titls.userPage
        
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        activityIndicator.changeStateActivityIndicator(state: .showAndAnimate)
    }
}

// MARK: - UserPageViewProtocol
extension UserPageViewController: UserPageViewProtocol {
}
