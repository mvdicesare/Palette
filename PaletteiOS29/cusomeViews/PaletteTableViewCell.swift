//
//  PaletteTableViewCell.swift
//  PaletteiOS29
//
//  Created by Michael Di Cesare on 10/22/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import UIKit

class PaletteTableViewCell: UITableViewCell {

    var photo: UnsplashPhoto? {
        didSet {
            updateViews()
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
    }
    
    // MARK: - Declare SubViews (step 1)
    lazy var paletteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = (contentView.frame.height/20)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var paletteTitleLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var colorPaletteView: ColorPaletteView = {
        let paletteView = ColorPaletteView()
        return paletteView
    }()
    
    // MARK: - Add subviews to cell (step two)
    
    func addAllSubviews() {
        self.addSubview(paletteImageView)
        self.addSubview(paletteTitleLabel)
        self.addSubview(colorPaletteView)
    }
    
    // MARK: - step 3 - constrain
    
    func setupViews() {
        addAllSubviews()
        
        let imageDimensions = (contentView.frame.width - (SpacingConstant.outerHorizontalPadding * 2))
        
        paletteImageView.anchor(top: contentView.topAnchor, bottom: nil, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, topPadding: SpacingConstant.outerVerticalPadding, bottomPadding: 0, leadingPadding: SpacingConstant.outerHorizontalPadding, trailingPadding: SpacingConstant.outerHorizontalPadding, width: imageDimensions, hight: imageDimensions)
        
        paletteTitleLabel.anchor(top: paletteImageView.bottomAnchor, bottom: nil, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, topPadding: SpacingConstant.verticalObjectBuffer, bottomPadding: 0, leadingPadding: SpacingConstant.outerHorizontalPadding, trailingPadding: SpacingConstant.outerHorizontalPadding, width: nil, hight: SpacingConstant.oneLineElementHight)
        
        colorPaletteView.anchor(top: paletteTitleLabel.bottomAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, topPadding: SpacingConstant.verticalObjectBuffer, bottomPadding: SpacingConstant.outerVerticalPadding, leadingPadding: SpacingConstant.outerHorizontalPadding, trailingPadding: SpacingConstant.outerHorizontalPadding, width: nil, hight: SpacingConstant.twoLineElementHight)
        
        colorPaletteView.clipsToBounds = true
        colorPaletteView.layer.cornerRadius = (SpacingConstant.twoLineElementHight / 2)
    }
    
    func updateViews() {
        guard let photo = photo else {return}
        fetchAndSetImage(for: photo)
        fetchAndSetColors(for: photo)
        paletteTitleLabel.text = photo.description
    }
    
    func fetchAndSetImage(for photo: UnsplashPhoto) {
        UnsplashService.shared.fetchImage(for: photo) { (image) in
            DispatchQueue.main.async {
                self.paletteImageView.image = image
            }
        }
    }
    
    func fetchAndSetColors(for photo: UnsplashPhoto) {
        ImaggaService.shared.fetchColorsFor(imagePath: photo.urls.regular) { (colors) in
            DispatchQueue.main.async {
                guard let colors = colors else {return}
                self.colorPaletteView.colors = colors
            }
        }
    }
}
