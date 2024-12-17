//
//  UserPageViewController.swift
//  StarMovie
//
//  Created by petar on 17.04.2024
//

import UIKit
import SnapKit

protocol UserPageViewProtocol: AnyObject {
    func enterUserData(_ user: User)
}

final class UserPageViewController: UIViewController {
    
    var presenter: UserPagePresenterProtocol?
    
    let customTransitioningDelegate = CustomAnimationTransitionDelegate(duration: 0.2)
    
    private let userAvatrarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "iconGreenClear")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        imageView.layer.borderColor = Resources.Colors.ultraColorLight.cgColor
        imageView.layer.borderWidth = 1
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.gillSansFont(size: 23, blod:  true)
        label.backgroundColor = Resources.Colors.mainColorLight
        label.textAlignment = .center
        label.textColor = Resources.Colors.mainColorDark
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        return label
    }()
    
    private let userLibraryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delaysContentTouches = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        initialize()
    }
}

private extension UserPageViewController {
    func initialize() {
        view.backgroundColor = Resources.Colors.mainColorGray
        navigationItem.title = Resources.Titls.userPage
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(userPressedByEditButton))
        navigationItem.rightBarButtonItem?.tintColor = Resources.Colors.mainColorLight
        userLibraryCollectionView.delegate = self
        userLibraryCollectionView.dataSource = self
        userLibraryCollectionView.register(UserLibraryCell.self, forCellWithReuseIdentifier: UserLibraryCell.identifier) 
        addComponents()
    }
    
    func addComponents() {
        let screenWidth = UIScreen.main.bounds.width
        view.addSubviews(userAvatrarImageView, userNameLabel, userLibraryCollectionView)
        
        userAvatrarImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.directionalHorizontalEdges.equalToSuperview().inset(screenWidth / 6)
            make.width.height.equalTo(screenWidth / 1.5)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(userAvatrarImageView.snp.bottom)
            make.directionalHorizontalEdges.equalToSuperview().inset(screenWidth / 4)
        }
        
        userLibraryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).inset(-20)
            make.directionalHorizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc
    func userPressedByEditButton() {
        presenter?.userPressedEditProfile(userName: userNameLabel.text ?? "UserName", userAvatar: userAvatrarImageView.image?.pngData() ?? Data())
    }
}

// MARK: - UserPageViewProtocol
extension UserPageViewController: UserPageViewProtocol {
    func enterUserData(_ user: User) {
        guard let userAvatar = user.userAvatar else { return }
        userAvatrarImageView.image = UIImage(data: userAvatar)
        userNameLabel.text = user.userName
    }
}

extension UserPageViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height / 11)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.menuItemsUserPage() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserLibraryCell.identifier, for: indexPath) as! UserLibraryCell
        cell.configCell((presenter?.cellDataForIndexPath(indexPath: indexPath))!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.userSelectedMenuItem(indexPath: indexPath)
    }
}

extension UserPageViewController: EditUserModuleDelegate {
    func editUserModuleDidSaveData() {
        presenter?.loadUserData()
    }
}



