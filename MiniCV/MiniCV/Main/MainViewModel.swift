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

protocol MainViewModelProtocol {
    func numberOfSection() -> Int
    func numberOfRows() -> Int
}

final class MainViewModel: MainViewModelProtocol {
        
    func numberOfSection() -> Int {
        Section.allCases.count
    }
    
    func numberOfRows() -> Int {
        Section.allCases.count / Section.allCases.count
    }
}
