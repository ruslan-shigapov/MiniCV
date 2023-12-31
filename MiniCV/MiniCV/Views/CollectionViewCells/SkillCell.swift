//
//  SkillCell.swift
//  MiniCV
//
//  Created by Руслан Шигапов on 04.08.2023.
//

import UIKit

final class SkillCell: UICollectionViewCell {
    
    // MARK: - Private Properties
    private lazy var skillStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [skillNameLabel, deleteButton]
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var skillNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    // MARK: - Public Properties
    lazy var deleteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "XMark"), for: .normal)
        return button
    }()
    
    lazy var skillNameLabelTrailingConstraint: NSLayoutConstraint = {
        let constraint = skillNameLabel.trailingAnchor.constraint(
            equalTo: trailingAnchor
        )
        return constraint
    }()
    
    var viewModel: SkillCellViewModelProtocol! {
        didSet {
            skillNameLabel.text = viewModel.name
        }
    }
    
    var delegate: SkillCellDelegate!
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 12
    }
 
    // MARK: - Private Methods
    private func setupUI() {
        backgroundColor = .secondarySystemBackground
        addSubview(skillStackView)
        setDeleteAction()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            skillNameLabel.topAnchor.constraint(
                equalTo: topAnchor,
                constant: 12
            ),
            skillNameLabel.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -12
            ),
            skillNameLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 24
            ),
            skillNameLabelTrailingConstraint,
            
            deleteButton.widthAnchor.constraint(equalToConstant: 14),
            deleteButton.heightAnchor.constraint(equalToConstant: 14),
        ])
    }
    
    private func setDeleteAction() {
        let deleteButtonPressed = UIAction { [weak self] _ in
            self?.viewModel.deleteSkill()
            self?.delegate.deleteButtonWasPressed?()
        }
        deleteButton.addAction(deleteButtonPressed, for: .touchUpInside)
    }
}
