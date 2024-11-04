//
//  EditUserViewController.swift
//  StarMovie
//
//  Created by petar on 27.10.2024
//

import UIKit
import SnapKit

protocol EditUserViewProtocol: AnyObject {
    var imagePicker: UIImagePickerController { get set }
    func enterUserData(_ user: User)
}

final class EditUserViewController: UIViewController {

    var presenter: EditUserPresenterProtocol?
    
    var imagePickerAlert: UIAlertController?
    
    var imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        return picker
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = Resources.Colors.mainColorDark
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let editUserLabel: UILabel = {
        let label = UILabel()
        label.text = "Edit Your Profile"
        label.textColor = Resources.Colors.mainColorLight
        label.font = Resources.Fonts.gillSansFont(size: 19, blod: true)
        label.textAlignment = .center
        return label
    }()

    private let userAvatarImageVeiw: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.alpha = 0.7
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let maskUserAvatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "square.and.arrow.up")
        imageView.tintColor = Resources.Colors.mainColorLight
        imageView.backgroundColor = Resources.Colors.mainColorDark
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.alpha = 0.8
        return imageView
    }()
    
    private let userNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "UserName"
        textField.layer.cornerRadius = 20
        textField.font = Resources.Fonts.gillSansFont(size: 20, blod: true)
        textField.textColor = Resources.Colors.mainColorDark
        textField.backgroundColor = Resources.Colors.ultraColorLight
        textField.textAlignment = .center
        textField.clearButtonMode = .always
        return textField
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = Resources.Fonts.gillSansFont(size: 20 , blod: true)
        button.setTitleColor(Resources.Colors.accentColor, for: .normal)
        button.setTitle("Save", for: .normal)
        button.backgroundColor = Resources.Colors.ultraColorLight
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()

    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = Resources.Fonts.gillSansFont(size: 20 , blod: true)
        button.setTitleColor(Resources.Colors.mainColorDark, for: .normal)
        button.setTitle("Close", for: .normal)
        button.backgroundColor = Resources.Colors.ultraColorLight
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        presenter?.viewDidLoad()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    func userTappedCloseButton() {
        presenter?.userPressedCloseButton()
    }
    
    @objc
    func userTappedSaveButton() {
        presenter?.userPressedSaveButton()
    }

    @objc
    func userTappedEditAvatarImageView(){
        configAlertImageSelect()
    }
}


private extension EditUserViewController {
    func initialize() {
        view.backgroundColor = .black.withAlphaComponent(0.5)
        userNameTextField.delegate = self
        saveButton.addTarget(self, action: #selector(userTappedSaveButton), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(userTappedCloseButton), for: .touchUpInside)
        let avatarTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(userTappedEditAvatarImageView))
        userAvatarImageVeiw.addGestureRecognizer(avatarTapGestureRecognizer)
        imagePicker.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        addCompoments()
    }
    
    func addCompoments() {
        let screenWidth = UIScreen.main.bounds.width
        view.addSubviews(contentView.addSubviews(editUserLabel,
                                                 userAvatarImageVeiw.addSubviews(maskUserAvatarImageView),
                                                 userNameTextField,
                                                 saveButton,
                                                 closeButton))
        
        contentView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(screenWidth * 1.2)
            make.width.equalTo(screenWidth * 0.8)
        }
        
        editUserLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.directionalHorizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(screenWidth * 0.1)
        }
        
        userAvatarImageVeiw.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(editUserLabel.snp.bottom)
            make.height.equalTo(screenWidth * 0.8)
        }
        
        maskUserAvatarImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(userAvatarImageVeiw.snp.width).multipliedBy(0.5)
        }
        
        userNameTextField.snp.makeConstraints { make in
            make.top.equalTo(userAvatarImageVeiw.snp.bottom).offset(10)
            make.directionalHorizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(screenWidth * 0.12)
        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(screenWidth * 0.09)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(contentView.snp.centerX).offset(-5)
        }
        
        closeButton.snp.makeConstraints { make in
            make.height.equalTo(screenWidth * 0.09)
            make.bottom.equalToSuperview().offset(-10)
            make.trailing.equalToSuperview().offset(-20)
            make.leading.equalTo(contentView.snp.centerX).offset(5)
        }
    }
    
    func configAlertImageSelect() {
        imagePickerAlert = UIAlertController(title: "User Avatar", message: "select source", preferredStyle: .actionSheet)
        imagePickerAlert?.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.presenter?.userSelectedImageResources(sourceType: "camera")
        }))
        imagePickerAlert?.addAction(UIAlertAction(title: "Your Library", style: .default, handler: { _ in
            self.presenter?.userSelectedImageResources(sourceType: "library")
        }))
        imagePickerAlert?.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        presenter?.configuredAlertController()
    }
    
    @objc
    func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            let bottomSpace = view.frame.height - (self.userNameTextField.frame.origin.y + self.userNameTextField.frame.height)
            view.frame.origin.y = keyboardHeight - bottomSpace
        }
    }
    
    @objc
    func keyboardWillHide(_ notification: Notification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

extension EditUserViewController: EditUserViewProtocol {
    func enterUserData(_ user: User) {
        guard let userAvatar = user.userAvatar else { return }
        userAvatarImageVeiw.image = UIImage(data: userAvatar)
        userNameTextField.text = user.userName
    }
}

extension EditUserViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userNameTextField.resignFirstResponder()
        guard let newName = textField.text else { return true }
        presenter?.setNewUserName(newName)
        return true
    }
}

extension EditUserViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        if let image = info[.editedImage] as? UIImage {
            guard let imageData = image.pngData() else { return }
            userAvatarImageVeiw.image = image
            presenter?.setNewUserAvatarData(imageData)
        } else if let image = info[.originalImage] as? UIImage {
            guard let imageData = image.pngData() else { return }
            userAvatarImageVeiw.image = image
            presenter?.setNewUserAvatarData(imageData)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}


