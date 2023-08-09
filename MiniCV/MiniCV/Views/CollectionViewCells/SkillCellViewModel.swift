//
//  SkillCellViewModel.swift
//  MiniCV
//
//  Created by Руслан Шигапов on 04.08.2023.
//

import Foundation

protocol SkillCellViewModelProtocol {
    var name: String { get }
    init(skill: Skill)
    func deleteSkill()
}

final class SkillCellViewModel: SkillCellViewModelProtocol {
   
    private let skill: Skill
    
    var name: String {
        skill.name ?? "Unknown name"
    }
    
    required init(skill: Skill) {
        self.skill = skill
    }
    
    func deleteSkill() {
        StorageManager.shared.delete(skill)
    }
}
