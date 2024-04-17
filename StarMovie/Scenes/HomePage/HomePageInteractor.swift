//
//  HomePageInteractor.swift
//  Super easy dev
//
//  Created by petar on 11.04.2024
//

protocol HomePageInteractorProtocol: AnyObject {
}

class HomePageInteractor: HomePageInteractorProtocol {
    weak var presenter: HomePagePresenterProtocol?
}
