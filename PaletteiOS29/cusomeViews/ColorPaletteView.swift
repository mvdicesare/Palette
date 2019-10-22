//
//  ColorPaletteView.swift
//  PaletteiOS29
//
//  Created by Michael Di Cesare on 10/22/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import UIKit

class ColorPaletteView: UIView {
    
    var colors: [UIColor] {
        didSet {
          buildColorBricks()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
    }
    
    init(colors: [UIColor] = [], frame: CGRect = .zero) {
        self.colors = colors
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - - Create subviews (step 1
    lazy var colorStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    // MARK: - add subviews and constrain (step 2)
    
    private func setupViews() {
        addSubview(colorStackView)
        colorStackView.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, topPadding: 0, bottomPadding: 0, leadingPadding: 0, trailingPadding: 0)
        buildColorBricks()
    }
    
    private func generateColorBrick(for color: UIColor) -> UIView {
        let colorBrick = UIView()
        colorBrick.backgroundColor = color
        return colorBrick
    }
    
    private func resetColorBrick() {
        for subView in colorStackView.arrangedSubviews {
            self.colorStackView.removeArrangedSubview(subView)
        }
    }
    
    private func buildColorBricks() {
        resetColorBrick()
        for color in self.colors {
            let colorBrick = generateColorBrick(for: color)
            self.addSubview(colorBrick)
            self.colorStackView.addArrangedSubview(colorBrick)
        }
    }
}
