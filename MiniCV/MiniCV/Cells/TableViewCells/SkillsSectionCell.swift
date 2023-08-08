//
//  SkillsSectionCell.swift
//  MiniCV
//
//  Created by Руслан Шигапов on 06.08.2023.
//

import UIKit

final class SkillsSectionCell: UITableViewCell {
    
    // MARK: - Private Properties
    var viewModel: SkillsSectionCellViewModelProtocol! {
        didSet {
            viewModel.deleteButtonWasPressed = { [weak self] in
                self?.viewModel.fetchData {
                    self?.collectionView.reloadData()
                }
            }
        }
    }
    
    private lazy var skillsSectionStackView = UIStackView()
    
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
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: makeLayout()
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    private lazy var collectionViewHeightConstraint: NSLayoutConstraint = {
        let constraint = collectionView.heightAnchor.constraint(equalToConstant: 56)
        return constraint
    }()
    
//    private var collectionViewHeight: CGFloat!
    
    // MARK: - Public Properties 
    var delegate: SkillsSectionCellDelegate!
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        viewModel = SkillsSectionCellViewModel()
        setupCollectionView()
        setupUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // M
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        collectionViewHeight = collectionView.collectionViewLayout.collectionViewContentSize.height
//    }
    
    // MARK: - Private Methods
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            SkillCell.self,
            forCellWithReuseIdentifier: "skillCell"
        )
        collectionView.register(
            AddButtonCell.self,
            forCellWithReuseIdentifier: "addButtonCell"
        )
    }
    
    private func setupUI() {
        skillsSectionStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(skillsSectionStackView)
        contentView.addSubview(collectionView)
        skillsSectionStackView.addArrangedSubview(skillsSectionLabel)
        skillsSectionStackView.addArrangedSubview(editButton)
        viewModel.fetchData { collectionView.reloadData() }
    }
    
    //    private func setCollectionViewHeight() {
    //        while skillsCollectionView.contentSize.height > skillsCollectionViewHeightConstraint.constant {
    //            skillsCollectionViewHeightConstraint.constant += 56
    //        }
    //    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            skillsSectionStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            skillsSectionStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            skillsSectionStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            skillsSectionStackView.heightAnchor.constraint(equalToConstant: 24),
            
            editButton.widthAnchor.constraint(equalToConstant: 24),

            collectionView.topAnchor.constraint(equalTo: skillsSectionStackView.bottomAnchor, constant: 4),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            collectionViewHeightConstraint,
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    @objc private func editButtonPressed() {
        viewModel.isEditingMode.toggle()
        editButton.setImage(
            UIImage(named: viewModel.isEditingMode ? "Done" : "Pencil"),
            for: .normal
        )
        collectionView.reloadData()
    }
}

// MARK: - Collection View Data Source
extension SkillsSectionCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {

        viewModel.numberOfItems()
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: UICollectionViewCell?
        if (viewModel.isEditingMode ? indexPath.row + 1 : indexPath.row) < viewModel.numberOfItems() {
            let skillCell = collectionView.dequeueReusableCell(withReuseIdentifier: "skillCell",
                                                               for: indexPath) as? SkillCell
            if viewModel.isEditingMode {
                skillCell?.deleteButton.isHidden = false
                skillCell?.skillNameLabelTrailingConstraint.constant = -48
            } else {
                skillCell?.deleteButton.isHidden = true
                skillCell?.skillNameLabelTrailingConstraint.constant = -24
            }
            skillCell?.viewModel = viewModel.getSkillCellViewModel(at: indexPath)
            skillCell?.delegate = viewModel as SkillCellDelegate
            cell = skillCell
        } else {
            let addButtonCell = collectionView.dequeueReusableCell(withReuseIdentifier: "addButtonCell",
                                                                   for: indexPath) as? AddButtonCell
            cell = addButtonCell
        }
//        setCollectionViewHeight()
        return cell ?? UICollectionViewCell()
    }
}

// MARK: - Collection View Delegate
extension SkillsSectionCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        if viewModel.isEditingMode, viewModel.numberOfItems() == indexPath.item + 1 {
            delegate.addButtonWasPressed?()
        }
    }
}

// MARK: - Collection View Compositional Layout
extension SkillsSectionCell {
    
    private func makeLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { _, _ in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .estimated(80),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(56)
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )
            group.contentInsets = .init(top: 12, leading: 0, bottom: 0, trailing: 0)
            group.interItemSpacing = .fixed(12)
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }
}
