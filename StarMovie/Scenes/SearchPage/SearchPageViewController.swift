//
//  SearchPageViewController.swift
//  Super easy dev
//
//  Created by petar on 17.04.2024
//

import UIKit
import SnapKit

protocol SearchPageViewProtocol: AnyObject {
}

class SearchPageViewController: UIViewController {
    
    var presenter: SearchPagePresenterProtocol?
    
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = Resources.Fonts.gillSansFont(size: 23, blod:  false)
        textField.textColor = Resources.Colors.mainColorLight
        textField.backgroundColor = Resources.Colors.mainColorGray
        textField.textAlignment = .center
        textField.attributedPlaceholder = NSAttributedString(string: "Enter your film",
                                                             attributes: [.font: Resources.Fonts.gillSansFont(size: 23, blod: false)])
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = Resources.Colors.mainColorLight.cgColor
        textField.layer.borderWidth = 3
        return textField
    }()
    
    var filmCollectionView = HomeCollectionView()
    
    let horizontalMenuCollectionView = MenuCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

private extension SearchPageViewController {
    func initialize() {
        view.backgroundColor = Resources.Colors.mainColorGray
        navigationItem.title = Resources.Titls.searchPage
        searchTextField.delegate = self
        addCompontntsForScreen()
    }
    
    func addCompontntsForScreen(){
        view.addSubviews(searchTextField, filmCollectionView, horizontalMenuCollectionView)
        
        searchTextField.snp.makeConstraints { textField in
            textField.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            textField.leading.equalToSuperview().offset(10)
            textField.trailing.equalToSuperview().offset(-10)
            textField.height.equalTo(45)
            textField.width.equalTo(view.bounds.width - 20)
        }
        
        horizontalMenuCollectionView.snp.makeConstraints { manu in
            manu.leading.trailing.equalToSuperview()
            manu.top.equalTo(searchTextField.snp.bottom).inset(-10)
            manu.height.equalTo(40)
        }
        
        filmCollectionView.snp.makeConstraints { collection in
            collection.bottom.equalToSuperview()
            collection.leading.equalToSuperview().offset(10)
            collection.trailing.equalToSuperview().offset(-10)
            collection.top.equalTo(horizontalMenuCollectionView.snp.bottom).inset(-10)
        }
    }
}

// MARK: - SearchPageViewProtocol
extension SearchPageViewController: SearchPageViewProtocol {
}

//MARK: - Method Delegate Text Field
extension SearchPageViewController: UITextFieldDelegate{
    
    //user tap for searchTextField
    func textFieldDidBeginEditing(_ textField: UITextField) {
        filmCollectionView.removeFromSuperview()
        horizontalMenuCollectionView.removeFromSuperview()
    }
}
