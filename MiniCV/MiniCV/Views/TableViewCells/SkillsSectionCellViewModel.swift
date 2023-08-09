//
//  SkillsSectionCellViewModel.swift
//  MiniCV
//
//  Created by Руслан Шигапов on 07.08.2023.
//

import Foundation

protocol SkillCellDelegate {
    var deleteButtonWasPressed: (() -> Void)? { get set }
}

protocol SkillsSectionCellViewModelProtocol: SkillCellDelegate {
    var isEditingMode: Bool { get set }
    func fetchData(completion: () -> Void)
    func numberOfItems() -> Int
    func getSkillCellViewModel(at indexPath: IndexPath) -> SkillCellViewModelProtocol
}

class SkillsSectionCellViewModel: SkillsSectionCellViewModelProtocol {
    
    private var skills: [Skill] = []
    
    var deleteButtonWasPressed: (() -> Void)?
    
    var isEditingMode = false

    func fetchData(completion: () -> Void) {
        StorageManager.shared.fetchSkills { [unowned self] result in
            switch result {
            case .success(let skills):
                self.skills = skills
                completion()
            case .failure(let error):
                completion()
                print(error.localizedDescription)
            }
        }
    }
    
    func numberOfItems() -> Int {
        isEditingMode ? skills.count + 1 : skills.count
    }
    
    func getSkillCellViewModel(at indexPath: IndexPath) -> SkillCellViewModelProtocol {
        SkillCellViewModel(skill: skills[indexPath.row])
    }
}
