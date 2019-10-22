//
//  PaletteViewController.swift
//  PaletteiOS29
//
//  Created by Michael Di Cesare on 10/22/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

// step 1 declare our Views
// step 2 add our superview to the superview
// step 3 constrain our views
import UIKit

class PaletteViewController: UIViewController {

    var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }
    var buttons: [UIButton] {
        return [featuredButton, randomButton, doubleRainbow]
    }
    var photos: [UnsplashPhoto] = []
    
    override func loadView() {
        super.loadView()
        addAllSubViews()
        setUpStackView()
        constrainViews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        searchForCatagory(.featured)
        activateButtons()
        selectButton(featuredButton)
    }
    // MARK: - API helper func
    
    func searchForCatagory(_ route: UnsplashRoute) {
        UnsplashService.shared.fetchFromUnsplash(for: route) { (photos) in
            DispatchQueue.main.async {
                guard let photo = photos else {return}
                self.photos = photo
                self.paletteTableView.reloadData()
            }
        }
    }
    // MARK: - create subviews
    
    let featuredButton: UIButton = {
        let button = UIButton()
        button.setTitle("Featured", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .center
        
        return button
    }()
    
    let randomButton: UIButton = {
        let button = UIButton()
        button.setTitle("Random", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .center
        
        return button
    }()
    
    let doubleRainbow: UIButton = {
        let button = UIButton()
        button.setTitle("Double Rainbow", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = . center
        
        return button
    }()
    
    let buttonStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .fill
        
        return stackView
    }()
    
    let paletteTableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    // MARK: - add subviews (part 2)
    
    func addAllSubViews() {
        self.view.addSubview(featuredButton)
        self.view.addSubview(randomButton)
        self.view.addSubview(doubleRainbow)
        self.view.addSubview(buttonStackView)
        self.view.addSubview(paletteTableView)
    }
    
    func setUpStackView() {
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.addArrangedSubview(featuredButton)
        buttonStackView.addArrangedSubview(doubleRainbow)
        buttonStackView.addArrangedSubview(randomButton)
    }

    func configureTableView() {
        paletteTableView.delegate = self
        paletteTableView.dataSource = self
        paletteTableView.register(PaletteTableViewCell.self, forCellReuseIdentifier: "paletteCell")
        paletteTableView.allowsSelection = false
    }
    
    // MARK: - Constrain Views part 3
    
    func constrainViews(){
        paletteTableView.anchor(top: buttonStackView.bottomAnchor, bottom: self.safeArea.bottomAnchor, leading: self.safeArea.leadingAnchor, trailing: self.safeArea.trailingAnchor, topPadding: buttonStackView.frame.height/2, bottomPadding: 0, leadingPadding: 0, trailingPadding: 0)
        buttonStackView.anchor(top: self.safeArea.topAnchor, bottom: nil, leading: self.safeArea.leadingAnchor, trailing: self.safeArea.trailingAnchor, topPadding: 0, bottomPadding: 0, leadingPadding: 8, trailingPadding: 8)
    }
    
    // MARK: - IBAction: fir buttons
    
    func activateButtons() {
        buttons.forEach { $0.addTarget(self, action: #selector(searchButtonTapped(sender:)), for: .touchUpInside)}
    }
    
    @objc func searchButtonTapped(sender: UIButton) {
        selectButton(sender)
        switch sender {
        case randomButton:
            searchForCatagory(.random)
        case doubleRainbow:
            searchForCatagory(.doubleRainbow)
        case featuredButton:
            searchForCatagory(.featured)
        default:
            print("error, button not found ")
        }
    }
    func selectButton(_ button: UIButton) {
        buttons.forEach { $0.setTitleColor(UIColor(named: "offWhite"), for: .normal) }
        button.setTitleColor(UIColor(named: "DevMountainBlue"), for: .normal)
    }
}
// MARK: - TableView COnformance (delegart and Data source)

extension PaletteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "paletteCell", for: indexPath) as! PaletteTableViewCell
        let photo = photos[indexPath.row]
        cell.photo = photo
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let imageViewSpace: CGFloat = (view.frame.width - (2 * SpacingConstant.outerHorizontalPadding))
        let textLabelSpace: CGFloat = SpacingConstant.oneLineElementHight
        let colorPaletteSpacing = SpacingConstant.twoLineElementHight
        let outerVerticalSpacing: CGFloat = (2 * SpacingConstant.outerVerticalPadding)
        let innerVerticalSpacing: CGFloat = (2 * SpacingConstant.verticalObjectBuffer)
        
        return imageViewSpace + textLabelSpace + outerVerticalSpacing + innerVerticalSpacing + colorPaletteSpacing
    }
}
