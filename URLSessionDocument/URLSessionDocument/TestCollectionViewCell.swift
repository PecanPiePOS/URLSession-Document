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
    private let touchAreaBox: UIView = UIView()
    
    private let touchAreaInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let hitTestEdgeInsets = UIEdgeInsets(top: touchAreaInsets.top, left: touchAreaInsets.left, bottom: touchAreaInsets.bottom, right: touchAreaInsets.right)
        
        let hitFrame = bounds.inset(by: hitTestEdgeInsets)
        return hitFrame.contains(point)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        basicSetup()
        setUI()
        setLayout()
    }
    
    private func basicSetup() {
        self.backgroundColor = .clear
    }
    
    private func setUI() {
        touchAreaBox.do {
            $0.backgroundColor = .purple
            $0.isUserInteractionEnabled = false
        }
        
        puzzleImage.do {
            $0.contentMode = .scaleAspectFit
            $0.clipsToBounds = true
            $0.isUserInteractionEnabled = false
        }
    }
    
    private func setLayout() {
        self.addSubview(puzzleImage)
        self.addSubview(touchAreaBox)
        
        puzzleImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        touchAreaBox.snp.makeConstraints {
            $0.size.equalTo(50)
            $0.center.equalToSuperview()
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
    
    @objc
    private func cellTapped() {
        print("ddddd")
    }
}
