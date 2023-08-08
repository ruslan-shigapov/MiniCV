//
//  MainViewModel.swift
//  MiniCV
//
//  Created by Руслан Шигапов on 04.08.2023.
//

import Foundation

enum Section: String, CaseIterable {
    case profile
    case skills
    case about
}

protocol SkillsSectionCellDelegate {
    var addButtonWasPressed: (() -> Void)? { get set }
}

protocol MainViewModelProtocol: SkillsSectionCellDelegate {
    func numberOfSection() -> Int
    func numberOfRows() -> Int
    func createSkill(by name: String, completion: () -> Void)
}

final class MainViewModel: MainViewModelProtocol {
    
    var addButtonWasPressed: (() -> Void)?
    
    func numberOfSection() -> Int {
        Section.allCases.count
    }
    
    func numberOfRows() -> Int {
        Section.allCases.count / Section.allCases.count
    }
    
    func createSkill(by name: String, completion: () -> Void) {
        StorageManager.shared.create(by: name)
        completion()
    }
}
