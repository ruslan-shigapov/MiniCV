//
//  SkillsSectionCell.swift
//  MiniCV
//
//  Created by Руслан Шигапов on 06.08.2023.
//

import UIKit

final class SkillsSectionCell: UITableViewCell {
    
    // MARK: - Private Properties
    private lazy var collectionView: UICollectionView = {
        let collectionView = DynamicHeightCollectionView(
            frame: .zero,
            collectionViewLayout: makeLayout()
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()
                
    // MARK: - Public Properties
    var viewModel: SkillsSectionCellViewModelProtocol! {
        didSet {
            viewModel.fetchData {
                collectionView.reloadData()
                layoutIfNeeded()
            }
            viewModel.deleteButtonWasPressed = { [weak self] in
                self?.viewModel.fetchData {
                    self?.collectionView.reloadData()
                }
            }
        }
    }
    
    var delegate: SkillsSectionCellDelegate!
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        viewModel = SkillsSectionCellViewModel()
        setupUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(collectionView)
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
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 12),
            contentView.widthAnchor.constraint(equalTo: widthAnchor),
            
            collectionView.topAnchor.constraint(
                equalTo: contentView.topAnchor
            ),
            collectionView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            ),
            collectionView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16
            ),
            collectionView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -16
            )
        ])
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
        return cell ?? UICollectionViewCell()
    }
}

// MARK: - Collection View Delegate
extension SkillsSectionCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        if viewModel.isEditingMode,
           viewModel.numberOfItems() == indexPath.item + 1 {
            
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
            group.contentInsets = .init(
                top: 12,
                leading: 0,
                bottom: 0,
                trailing: 0
            )
            group.interItemSpacing = .fixed(12)
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }
}
