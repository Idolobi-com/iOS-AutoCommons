//
//  HomeViewController.swift
//  AutoCommonsExamples
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 11/08/20.
//  Copyright © 2020 Idolobi. All rights reserved.
//

import UIKit
import AutoCommons

class HomeViewController: UICollectionViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

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
    
    lazy var spinner: ACSpinner = {
        return acLayout.spinner(id: "spinner", title: "Spinner", style: .border, delegate: self)
    }()
    
    let vehicles = ["Lamborghini", "Ferarri", "McLaren"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
        setupComponent()
        setupConstraint()
        setupListener()
        spinner.setText(title: vehicles[2])
        spinner.selectRow(row: 2)
        ACLogger.d("\(spinner.selectedRow())")
    }
    
    private func setupComponent() {
        view.addSubview(buttonFill)
        view.addSubview(buttonGhost)
        view.addSubview(buttonNude)
        view.addSubview(spinner)
        spinner.useToolBar(title: "Select")
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
        
        NSLayoutConstraint.activate([
            spinner.topAnchor.constraint(equalTo: buttonNude.bottomAnchor, constant: 16),
            spinner.consLeading(view: view, constant: 16),
            spinner.consTrailing(view: view, constant: -16)
            ])
    }
    
    private func setupListener() {
        buttonFill.onClick {
            ACSnacky.show(title: "Button fill clicked !")
        }
        buttonGhost.onClick {
            ACSnacky.show(title: "Button ghost clicked !")
        }
        buttonNude.onClick {
            ACSnacky.show(title: "Button nude clicked !")
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return vehicles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return vehicles[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        spinner.setText(title: vehicles[row])
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}
