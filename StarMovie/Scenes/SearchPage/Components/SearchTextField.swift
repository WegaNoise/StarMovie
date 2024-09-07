//
//  SearchTextField.swift
//  StarMovie
//
//  Created by petar on 23.08.2024.
//

import UIKit

protocol SearchTextFieldProtocol: AnyObject {
    func hideHorizontalMenu()
    func showHorizontalMenu()
    func userStartedSearching(query: String)
    func searchIsEmpty()
}

final class SearchTextField: UITextField {
    
    weak var searchTextFieldDelegate: SearchTextFieldProtocol?
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 10
        layer.shadowColor = Resources.Colors.mainColorDark.cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 1
        layer.shadowRadius = 5
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
    }
}

private extension SearchTextField {
    func initialize(){
        delegate = self
        configUITextField()
        addTarget(self, action: #selector(changeText), for: .editingChanged)
        clearButtonMode = .whileEditing
    }
    
    func configUITextField() {
        borderStyle = .roundedRect
        backgroundColor = Resources.Colors.ultraColorLight
        font = Resources.Fonts.gillSansFont(size: 23, blod:  false)
        textColor = Resources.Colors.mainColorLight
        textAlignment = .center
        attributedPlaceholder = NSAttributedString(string: "Enter your film...",
                                                             attributes: [.font: Resources.Fonts.gillSansFont(size: 23, blod: false)])
    }
    
    @objc
    func changeText(){
        guard text?.count ?? 0 >= 2, let query = text else { return }
        searchTextFieldDelegate?.userStartedSearching(query: query)
    }
}

extension SearchTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchTextFieldDelegate?.hideHorizontalMenu()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard text?.isEmpty == true else { resignFirstResponder()
            return true
        }
        searchTextFieldDelegate?.searchIsEmpty()
        searchTextFieldDelegate?.showHorizontalMenu()
        resignFirstResponder()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        searchTextFieldDelegate?.showHorizontalMenu()
        searchTextFieldDelegate?.searchIsEmpty()
        return true
    }
}
