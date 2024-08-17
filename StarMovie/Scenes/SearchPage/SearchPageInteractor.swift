//
//  SearchPageInteractor.swift
//  StarMovie
//
//  Created by petar on 17.04.2024
//

protocol SearchPageInteractorProtocol: AnyObject {
}

class SearchPageInteractor: SearchPageInteractorProtocol {
    weak var presenter: SearchPagePresenterProtocol?
}
