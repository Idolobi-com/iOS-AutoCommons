//
//  HomePresenter.swift
//  AutoCommonsExamples
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 11/08/20.
//  Copyright © 2020 Idolobi. All rights reserved.
//

import Foundation

class HomePresenter: HomeViewToPresenterProtocol {
    var view: HomePresenterToViewProtocol?
    var interactor: HomePresenterToInteractorProtocol?
    var router: HomePresenterToRouterProtocol?
}

extension HomePresenter: HomeInteractorToPresenterProtocol {
}
