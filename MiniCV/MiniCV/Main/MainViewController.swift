//
//  MainViewController.swift
//  MiniCV
//
//  Created by Руслан Шигапов on 07.08.2023.
//

import UIKit

final class MainViewController: UITableViewController {
    
    // MARK: - Private Properties
    private var viewModel: MainViewModelProtocol! {
        didSet {
            viewModel.editButtonWasPressed = { [weak self] in
                self?.viewModel.isEditingMode.toggle()
                self?.tableView.reloadData()
            }
            viewModel.addButtonWasPressed = { [weak self] in
                self?.showAddAlert()
            }
        }
    }
    
    private let profile = Profile.getProfile()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainViewModel()
        setupUI()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        title = profile.title
        view.backgroundColor = .secondarySystemBackground
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(
            ProfileSectionCell.self,
            forCellReuseIdentifier: Section.profile.rawValue
        )
        tableView.register(
            SkillsSectionCell.self,
            forCellReuseIdentifier: Section.skills.rawValue
        )
        tableView.register(
            AboutSectionCell.self,
            forCellReuseIdentifier: Section.about.rawValue
        )
    }
}

// MARK: - Table View Data Source
extension MainViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSection()
    }

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        
        viewModel.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = Section.allCases[indexPath.section]
        var cell = tableView.dequeueReusableCell(withIdentifier: section.rawValue)
        switch section {
        case .profile:
            let profileSectionCell = cell as? ProfileSectionCell
            profileSectionCell?.photoImageView.image = UIImage(named: profile.photo)
            profileSectionCell?.fullNameLabel.text = profile.fullName
            profileSectionCell?.infoLabel.text = profile.info
            profileSectionCell?.locationLabel.text = profile.location
            profileSectionCell?.delegate = viewModel as ProfileSectionCellDelegate
            cell = profileSectionCell
        case .skills:
            let skillsSectionCell = cell as? SkillsSectionCell
            skillsSectionCell?.viewModel.isEditingMode = viewModel.isEditingMode
            skillsSectionCell?.delegate = viewModel as SkillsSectionCellDelegate
            cell = skillsSectionCell
        case .about:
            let aboutSectionCell = cell as? AboutSectionCell
            aboutSectionCell?.aboutLabel.text = profile.about
            cell = aboutSectionCell
        }
        return cell ?? UITableViewCell()
    }
}

// MARK: - UIAlertController
extension MainViewController {

    private func showAddAlert() {
        let alert = UIAlertController(
            title: "Добавление навыка",
            message: "Введите название навыка, которым вы владеете",
            preferredStyle: .alert
        )
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        let doneAction = UIAlertAction(
            title: "Добавить",
            style: .default
        ) { [weak self] _ in
            guard let name = alert.textFields?.first?.text else { return }
            guard !name.isEmpty else { return }
            self?.viewModel.createSkill(by: name) {
                self?.tableView.reloadData()
            }
        }
        alert.addAction(cancelAction)
        alert.addAction(doneAction)
        alert.addTextField { textField in
            textField.placeholder = "Введите название"
        }
        present(alert, animated: true)
    }
}
