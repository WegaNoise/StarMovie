//
//  EditUserRouter.swift
//  StarMovie
//
//  Created by petar on 27.10.2024
//

protocol EditUserRouterProtocol {
    var delegate: EditUserModuleDelegate? { get }
    func popViewController()
    func showAlertImageSource()
    func showImagePicker()
}

final class EditUserRouter: EditUserRouterProtocol {
    weak var viewController: EditUserViewController?
    weak var delegate: EditUserModuleDelegate?
    
    func popViewController() {
        viewController?.dismiss(animated: true)
    }
    
    func showAlertImageSource() {
        guard let alert = viewController?.imagePickerAlert else { return }
        viewController?.present(alert, animated: true)
    }
    
    func showImagePicker() {
        guard let picker = viewController?.imagePicker else { return }
        viewController?.present(picker, animated: true)
    }
}

//This protocol and its delegate are needed to update the data received from the user in the UserPage and update the user's name and photo.
protocol EditUserModuleDelegate: AnyObject {
    func editUserModuleDidSaveData()
}
