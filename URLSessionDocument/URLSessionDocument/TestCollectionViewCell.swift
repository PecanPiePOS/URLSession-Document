//
//  TestCollectionViewCell.swift
//  URLSessionDocument
//
//  Created by KYUBO A. SHIM on 2023/07/05.
//

import UIKit

import SnapKit
import Then

class TestCollectionViewCell: UICollectionViewCell {
    
    private let puzzleImage: UIImageView = UIImageView()
    private let randomBackgroundColorArray: [UIColor] = [.blue, .cyan, .clear, .orange, .green]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        basicSetup()
        setUI()
        setLayout()
    }
    
    private func basicSetup() {
        self.backgroundColor = randomBackgroundColorArray.randomElement()
    }
    
    private func setUI() {
        puzzleImage.do {
            $0.contentMode = .scaleAspectFit
            $0.clipsToBounds = true
        }
    }
    
    private func setLayout() {
        self.addSubview(puzzleImage)
        
        puzzleImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TestCollectionViewCell {
    func configureCell(imageName: String) {
        puzzleImage.image = UIImage(named: imageName)
    }
}
