//
//  HomeViewController.swift
//  AutoCommonsExamples
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 11/08/20.
//  Copyright © 2020 Idolobi. All rights reserved.
//

import UIKit
import AutoCommons

class HomeViewController: UICollectionViewController {
    
    var presenter: HomeViewToPresenterProtocol?
    var param: HomeParam?
    
    let buttonFill: ACButton = {
        return acLayout.button(id: "fill", style: .fillNormal, title: "Button Fill Normal", titleColor: .white, bgColor: .green50)
    }()
    
    let buttonGhost: ACButton = {
        return acLayout.button(id: "ghost", style: .ghostNormal, title: "Button Ghost Normal", titleColor: .green50, bgColor: .white, borderColor: .green50)
    }()
    
    let buttonNude: ACButton = {
        return acLayout.button(id: "nude", style: .nudeNormal, title: "Button Nude Normal", titleColor: .green50)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
        setupComponent()
        setupConstraint()
        setupListener()
    }
    
    private func setupComponent() {
        view.addSubview(buttonFill)
        view.addSubview(buttonGhost)
        view.addSubview(buttonNude)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            buttonFill.consTopSafeArea(view: view, constant: 16),
            buttonFill.consLeading(view: view, constant: 16),
            buttonFill.consTrailing(view: view, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            buttonGhost.topAnchor.constraint(equalTo: buttonFill.bottomAnchor, constant: 16),
            buttonGhost.consLeading(view: view, constant: 16),
            buttonGhost.consTrailing(view: view, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            buttonNude.topAnchor.constraint(equalTo: buttonGhost.bottomAnchor, constant: 16),
            buttonNude.consLeading(view: view, constant: 16),
            buttonNude.consTrailing(view: view, constant: -16)
        ])
    }
    
    private func setupListener() {
        buttonFill.onClick {
            ACSnacky.show(title: "Button Fill Normal clicked !")
        }
        
        buttonGhost.onClick {
            ACSnacky.show(title: "Button Ghost Normal clicked !")
        }
        
        buttonNude.onClick {
            ACSnacky.show(view: self.view, title: "Title wkwkkwk wkkwkwk wkwkkw kwkwkw wkkwkw wkkwkw kwkwk wkkwkw kwkwk", buttonTitle: "Title", completion: { (isClick) in
                if isClick {
                    ACSnacky.show(title: "Clicked")
                }
            })
        }
    }
    
}
