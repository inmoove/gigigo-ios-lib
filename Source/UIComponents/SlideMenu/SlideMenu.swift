//
//  SlideMenu.swift
//  GIGLibrary
//
//  Created by Alejandro Jiménez Agudo on 11/4/16.
//  Copyright © 2016 Gigigo SL. All rights reserved.
//

import Foundation


open class SlideMenu {
	
	open var sectionSelectorColor: UIColor = UIColor.white {
		didSet {
			SlideMenuConfig.shared.sectionSelectorColor = self.sectionSelectorColor
		}
	}
	
	open var menuBackgroundColor: UIColor = UIColor.black {
		didSet {
			SlideMenuConfig.shared.menuBackgroundColor = self.menuBackgroundColor
		}
	}
    
    fileprivate lazy var menuViewController = SlideMenuVC.menuVC()
    fileprivate var sections: [MenuSection] = []
    
	
	public init() { }
	
    // MARK: - Public methods
    
	open func menuVC(_ statusBarStyle: UIStatusBarStyle = .default) -> UIViewController {
        guard let menuVC = self.menuViewController else {
            LogWarn("Couldn't instantiate menu")
            return UIViewController()
        }
		
		self.menuViewController?.statusBarStyle = statusBarStyle
        
        return menuVC
    }
    
    open func userDidTapMenu() {
        self.menuViewController?.userDidTapMenuButton()
    }

    
    open func addSection(_ section: MenuSection) {
        self.sections.append(section)
        self.menuViewController?.sections = self.sections
    }
    
    open func selectSection(_ index: Int) {
        let section = self.sections[index]
        self.menuViewController?.setSection(section.sectionController, index: index)
    }
    
}
