//
//  EditUserInteractor.swift
//  StarMovie
//
//  Created by petar on 27.10.2024
//

import Foundation

protocol EditUserInteractorProtocol: AnyObject {
    func saveNewUserName(_ userName: String)
    func saveNewUserAvatar(_ imageData: Data)
}

final class EditUserInteractor: EditUserInteractorProtocol {
    weak var presenter: EditUserPresenterProtocol?
    private let imageFileName = Resources.User.userAvatarFileName
    private let userNameKey = Resources.User.userNameDefaultKey
    
    func saveNewUserName(_ userName: String) {
        UserDefaults.standard.set(userName, forKey: userNameKey)
        UserDefaults.standard.synchronize()
    }
    
    func saveNewUserAvatar(_ imageData: Data) {
        deleteOldUserAvatar()
        let pathToFile = getPathDirectory().appendingPathComponent(imageFileName)
        try? imageData.write(to: pathToFile)
    }
    
    func deleteOldUserAvatar() {
        let pathToFile = getPathDirectory().appendingPathComponent(imageFileName)
        if FileManager.default.fileExists(atPath: pathToFile.path) {
            try? FileManager.default.removeItem(at: pathToFile)
        }
    }
    
    func getPathDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
}
