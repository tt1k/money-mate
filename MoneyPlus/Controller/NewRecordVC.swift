//
//  NewRecordVC.swift
//  MoneyPlus
//
//  Created by FakeCoder on 2020/10/11.
//

import UIKit
import SnapKit

class NewRecordVC: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavSetting()
        initLayout()
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
    
    func initLayout() {
        view.addSubview(typeLabel)
        view.addSubview(typeControl)
        
        view.addSubview(titleLabel)
        view.addSubview(titleInputField)
        titleInputField.delegate = self
        
        view.addSubview(dateLabel)
        view.addSubview(dateInputField)
        dateInputField.delegate = self
        
        view.addSubview(amountLabel)
        view.addSubview(amountInputField)
        amountInputField.delegate = self
        
        view.addSubview(locationLabel)
        view.addSubview(locationInputField)
        locationInputField.delegate = self
        
        view.addSubview(detailLabel)
        view.addSubview(detailInputField)
        detailInputField.delegate = self
        
        view.addSubview(confirmBtn)
        
        
        let margin: Float = Float(AppConstants.kViewMargin)
        
        typeLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(margin)
            make.left.equalTo(view).offset(margin)
        }
        typeControl.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(Float(AppConstants.kScreenWidth) - margin * 2)
            make.height.equalTo(AppConstants.kTextFieldHeight)
            make.top.equalTo(typeLabel.snp.bottom).offset(margin)
            make.left.equalTo(view).offset(margin)
        }
        
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(typeControl.snp.bottom).offset(margin)
            make.left.equalTo(view).offset(margin)
        }
        titleInputField.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(AppConstants.kScreenWidth)
            make.height.equalTo(AppConstants.kTextFieldHeight)
            make.top.equalTo(titleLabel.snp.bottom).offset(margin / 2)
            make.left.equalTo(view).offset(margin)
            make.right.equalTo(view).offset(-margin)
        }
        
        let halfWidth: Float = Float((AppConstants.kScreenWidth - AppConstants.kViewMargin * 4) / 2)
        dateLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(titleInputField.snp.bottom).offset(margin)
            make.left.equalTo(view).offset(margin)
        }
        dateInputField.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(halfWidth)
            make.height.equalTo(AppConstants.kTextFieldHeight)
            make.top.equalTo(dateLabel.snp.bottom).offset(margin / 2)
            make.left.equalTo(view).offset(margin)
        }
        amountInputField.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(halfWidth)
            make.height.equalTo(AppConstants.kTextFieldHeight)
            make.top.equalTo(dateLabel.snp.bottom).offset(margin / 2)
            make.right.equalTo(view).offset(-margin)
        }
        amountLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(titleInputField.snp.bottom).offset(margin)
            make.left.equalTo(amountInputField)
        }
        
        locationLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(dateInputField.snp.bottom).offset(margin)
            make.left.equalTo(view).offset(margin)
        }
        locationInputField.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(AppConstants.kScreenWidth)
            make.height.equalTo(AppConstants.kTextFieldHeight)
            make.top.equalTo(locationLabel.snp.bottom).offset(margin / 2)
            make.left.equalTo(view).offset(margin)
            make.right.equalTo(view).offset(-margin)
        }
        detailLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(locationInputField.snp.bottom).offset(margin)
            make.left.equalTo(view).offset(margin)
        }
        detailInputField.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(AppConstants.kScreenWidth)
            make.height.equalTo(AppConstants.kTextFieldHeight)
            make.top.equalTo(detailLabel.snp.bottom).offset(margin / 2)
            make.left.equalTo(view).offset(margin)
            make.right.equalTo(view).offset(-margin)
        }
        
        confirmBtn.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(Float(AppConstants.kScreenWidth) - margin * 2)
            make.height.equalTo(AppConstants.kTextFieldHeight)
            make.top.equalTo(detailInputField.snp.bottom).offset(margin)
            make.left.equalTo(view).offset(margin)
            make.right.equalTo(view.snp.right).offset(-margin)
        }
    }
    
    private let typeControl: UISegmentedControl = {
        let items = ["Income", "Expense"]
        let sc = UISegmentedControl(items: items)
        sc.selectedSegmentIndex = 0
        sc.layer.cornerRadius = AppConstants.kTextFieldCornerRadius
        sc.backgroundColor = AppConstants.kBlackColor
        sc.selectedSegmentTintColor = AppConstants.kPinkColor
        sc.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: AppConstants.kWhiteColor,
            NSAttributedString.Key.font: AppConstants.kTitleFont
        ], for: .normal)
        return sc
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = AppConstants.kTitleFont
        label.textColor = AppConstants.kBlackColor
        return label
    }()
    
    private let titleInputField: UITextField = {
        let field = UITextField()
        field.font = AppConstants.kTitleFont
        field.layer.borderWidth = 1
        field.layer.borderColor = AppConstants.kLightGrayColor.cgColor
        field.layer.cornerRadius = AppConstants.kTextFieldCornerRadius
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: AppConstants.kTextFieldHeight))
        field.leftViewMode = .always
        return field
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.font = AppConstants.kTitleFont
        label.textColor = AppConstants.kBlackColor
        return label
    }()
    
    private let dateInputField: UITextField = {
        let field = UITextField()
        field.font = AppConstants.kTitleFont
        field.layer.borderWidth = 1
        field.layer.borderColor = AppConstants.kLightGrayColor.cgColor
        field.layer.cornerRadius = AppConstants.kTextFieldCornerRadius
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: AppConstants.kTextFieldHeight))
        field.leftViewMode = .always
        return field
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.text = "Amount"
        label.font = AppConstants.kTitleFont
        label.textColor = AppConstants.kBlackColor
        return label
    }()
    
    private let amountInputField: UITextField = {
        let field = UITextField()
        field.font = AppConstants.kTitleFont
        field.layer.borderWidth = 1
        field.layer.borderColor = AppConstants.kLightGrayColor.cgColor
        field.layer.cornerRadius = AppConstants.kTextFieldCornerRadius
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: AppConstants.kTextFieldHeight))
        field.leftViewMode = .always
        return field
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.text = "Type"
        label.font = AppConstants.kTitleFont
        label.textColor = AppConstants.kBlackColor
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Location(optional)"
        label.font = AppConstants.kTitleFont
        label.textColor = AppConstants.kBlackColor
        return label
    }()

    private let locationInputField: UITextField = {
        let field = UITextField()
        field.font = AppConstants.kTitleFont
        field.layer.borderWidth = 1
        field.layer.borderColor = AppConstants.kLightGrayColor.cgColor
        field.layer.cornerRadius = AppConstants.kTextFieldCornerRadius
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: AppConstants.kTextFieldHeight))
        field.leftViewMode = .always
        return field
    }()

    private let detailLabel: UILabel = {
        let label = UILabel()
        label.text = "Detail(optional)"
        label.font = AppConstants.kTitleFont
        label.textColor = AppConstants.kBlackColor
        return label
    }()
    
    private let detailInputField: UITextField = {
        let field = UITextField()
        field.font = AppConstants.kTitleFont
        field.layer.borderWidth = 1
        field.layer.borderColor = AppConstants.kLightGrayColor.cgColor
        field.layer.cornerRadius = AppConstants.kTextFieldCornerRadius
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: AppConstants.kTextFieldHeight))
        field.leftViewMode = .always
        return field
    }()
    
    private let confirmBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.titleLabel?.textColor = AppConstants.kWhiteColor
        button.titleLabel?.font = AppConstants.kTitleFont
        button.backgroundColor = AppConstants.kPinkColor
        button.layer.cornerRadius = AppConstants.kTextFieldCornerRadius
        return button
    }()
}
