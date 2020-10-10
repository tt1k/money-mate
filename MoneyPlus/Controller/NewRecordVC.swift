//
//  NewRecordVC.swift
//  MoneyPlus
//
//  Created by FakeCoder on 2020/10/11.
//

import UIKit
import SnapKit

class NewRecordVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavSetting()
    }
    
    func initNavSetting() {
        edgesForExtendedLayout = UIRectEdge.bottom
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        view.backgroundColor = AppConstants.kWhiteColor
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(closeDidTap))
        navigationItem.rightBarButtonItem?.tintColor = AppConstants.kBlackColor
    }
    
    @objc func closeDidTap() {
        dismiss(animated: true)
    }
    
}
