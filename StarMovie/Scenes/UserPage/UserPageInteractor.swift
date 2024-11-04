//
//  UserPageInteractor.swift
//  StarMovie
//
//  Created by petar on 17.04.2024
//
import Foundation

protocol UserPageInteractorProtocol: AnyObject {
    func loadUserData()
}

final class UserPageInteractor: UserPageInteractorProtocol {
    weak var presenter: UserPagePresenterProtocol?
    
    private let avatarUserFileName = Resources.User.userAvatarFileName
    private let userNameKey = Resources.User.userNameDefaultKey
    
    func loadUserData() {
        let userAvatarData = loadProfileImageData()
        let userName = loadUserName()
        let user = User(userName: userName ?? "UserName", userAvatar: userAvatarData ?? Data())
        presenter?.userDataLoaded(user: user)
    }
    
    private func loadUserName() -> String? {
        UserDefaults.standard.string(forKey: userNameKey)
    }
    
    private func loadProfileImageData() -> Data? {
        let filePath = getDocumentsDirectory().appendingPathComponent(avatarUserFileName)
        return try? Data(contentsOf: filePath)
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
