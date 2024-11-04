//
//  EditUserPresenter.swift
//  StarMovie
//
//  Created by petar on 27.10.2024
//
import Foundation

protocol EditUserPresenterProtocol: AnyObject {
    func viewDidLoad()
    func userPressedCloseButton()
    func userSelectedImageResources(sourceType: String)
    func configuredAlertController()
    func setNewUserAvatarData(_ data: Data)
    func setNewUserName(_ name: String)
    func userPressedSaveButton()
}

final class EditUserPresenter {
    weak var view: EditUserViewProtocol?
    var router: EditUserRouterProtocol
    var interactor: EditUserInteractorProtocol
    private var user: User
    private var newUserData: User
    

    init(interactor: EditUserInteractorProtocol, router: EditUserRouterProtocol, user: User) {
        self.interactor = interactor
        self.router = router
        self.user = user
        self.newUserData = User()
    }
}

extension EditUserPresenter: EditUserPresenterProtocol {
    func viewDidLoad() {
        view?.enterUserData(user)
    }
    
    func userPressedCloseButton() {
        router.popViewController()
    }
    
    func userPressedSaveButton() {
        if let avatar = newUserData.userAvatar {
            interactor.saveNewUserAvatar(avatar)
        }
        if let name = newUserData.userName, !name.isEmpty {
            interactor.saveNewUserName(name)
        }
        router.delegate?.editUserModuleDidSaveData()
        router.popViewController()
    }
    
    
    func setNewUserName(_ name: String) {
        newUserData.userName = name
    }
    
    func setNewUserAvatarData(_ data: Data) {
        newUserData.userAvatar = data
    }
    
    
// MARK: - User Avatar Methods (Alert and Picker)
    func configuredAlertController() {
        router.showAlertImageSource()
    }
    
    func userSelectedImageResources(sourceType: String) {
        switch sourceType {
        case "camera":
            view?.imagePicker.sourceType = .camera
            router.showImagePicker()
        case "library":
            view?.imagePicker.sourceType = .photoLibrary
            router.showImagePicker()
        default:
            break
        }
    }
}
