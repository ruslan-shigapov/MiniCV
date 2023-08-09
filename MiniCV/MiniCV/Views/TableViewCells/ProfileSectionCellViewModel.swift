//
//  ProfileSectionCellViewModel.swift
//  MiniCV
//
//  Created by Руслан Шигапов on 09.08.2023.
//

import Foundation

protocol ProfileSectionCellViewModelProtocol {
    var isEditingMode: Bool { get set }
    func changeEditingMode()
}

final class ProfileSectionCellViewModel: ProfileSectionCellViewModelProtocol {
    
    var isEditingMode = false
    
    func changeEditingMode() {
        isEditingMode.toggle()
    }
}
