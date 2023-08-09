//
//  ProfileSectionCell.swift
//  MiniCV
//
//  Created by Руслан Шигапов on 07.08.2023.
//

import UIKit

final class ProfileSectionCell: UITableViewCell {

    // MARK: - Private Properties
    private var viewModel: ProfileSectionCellViewModelProtocol!

    private lazy var locationStackView: UIStackView = {
        let view = UIStackView(
            arrangedSubviews: [locationImageView, locationLabel]
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var locationImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Pin")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var skillsSectionBackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(skillsSectionStackView)
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private lazy var skillsSectionStackView: UIStackView = {
        let view = UIStackView(
            arrangedSubviews: [skillsSectionLabel, editButton]
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 8
        return view
    }()
    
    private lazy var skillsSectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Мои навыки"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Pencil"), for: .normal)
        button.addTarget(
            self,
            action: #selector(editButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    // MARK: - Public Properties
    lazy var photoImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    var delegate: ProfileSectionCellDelegate!
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        viewModel = ProfileSectionCellViewModel()
        setupUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.layer.cornerRadius = photoImageView.frame.width / 2
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        backgroundColor = .secondarySystemBackground
        contentView.addSubview(photoImageView)
        contentView.addSubview(fullNameLabel)
        contentView.addSubview(infoLabel)
        contentView.addSubview(locationStackView)
        contentView.addSubview(skillsSectionBackView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 335),
            
            photoImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor, constant: 24
            ),
            photoImageView.widthAnchor.constraint(equalToConstant: 120),
            photoImageView.heightAnchor.constraint(equalToConstant: 120),
            photoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            fullNameLabel.topAnchor.constraint(
                equalTo: photoImageView.bottomAnchor,
                constant: 16
            ),
            fullNameLabel.widthAnchor.constraint(equalToConstant: 190),
            fullNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            infoLabel.topAnchor.constraint(
                equalTo: fullNameLabel.bottomAnchor,
                constant: 4
            ),
            infoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            locationStackView.topAnchor.constraint(
                equalTo: infoLabel.bottomAnchor
            ),
            locationStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            locationImageView.widthAnchor.constraint(equalToConstant: 16),
            
            skillsSectionBackView.topAnchor.constraint(
                equalTo: locationStackView.bottomAnchor,
                constant: 20
            ),
            skillsSectionBackView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            ),
            skillsSectionBackView.widthAnchor.constraint(
                equalTo: contentView.widthAnchor
            ),
            
            skillsSectionStackView.topAnchor.constraint(
                equalTo: skillsSectionBackView.topAnchor,
                constant: 20
            ),
            skillsSectionStackView.bottomAnchor.constraint(
                equalTo: skillsSectionBackView.bottomAnchor,
                constant: -4
            ),
            skillsSectionStackView.leadingAnchor.constraint(
                equalTo: skillsSectionBackView.leadingAnchor,
                constant: 16
            ),
            skillsSectionStackView.trailingAnchor.constraint(
                equalTo: skillsSectionBackView.trailingAnchor,
                constant: -16
            ),
            skillsSectionStackView.heightAnchor.constraint(equalToConstant: 24),
            
            editButton.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    @objc private func editButtonPressed() {
        viewModel.changeEditingMode()
        editButton.setImage(
            UIImage(named: viewModel.isEditingMode ? "Done" : "Pencil"),
            for: .normal
        )
        delegate.editButtonWasPressed?()
    }
}
