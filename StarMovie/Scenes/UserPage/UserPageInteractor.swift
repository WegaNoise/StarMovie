//
//  UserPageInteractor.swift
//  StarMovie
//
//  Created by petar on 17.04.2024
//

protocol UserPageInteractorProtocol: AnyObject {
}

class UserPageInteractor: UserPageInteractorProtocol {
    weak var presenter: UserPagePresenterProtocol?
}
