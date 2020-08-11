//
//  HomeRouter.swift
//  AutoCommonsExamples
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 11/08/20.
//  Copyright © 2020 Idolobi. All rights reserved.
//

import UIKit

class HomeRouter: HomePresenterToRouterProtocol {
    
    static func createModule(param: HomeParam) -> HomeViewController {
        let layout = UICollectionViewFlowLayout()
        let view = HomeViewController(collectionViewLayout: layout)
        let presenter: HomeViewToPresenterProtocol & HomeInteractorToPresenterProtocol = HomePresenter()
        let interactor: HomePresenterToInteractorProtocol = HomeInteractor()
        let router: HomePresenterToRouterProtocol = HomeRouter()
        view.param = param
        view.title = ""
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return view
    }
}
