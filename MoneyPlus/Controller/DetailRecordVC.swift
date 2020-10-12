//
//  DetailRecordVC.swift
//  MoneyPlus
//
//  Created by FakeCoder on 2020/10/11.
//

import Foundation
import UIKit
import SnapKit
import CoreData

class DetailRecordVC: UIViewController, UITextFieldDelegate {

    var recordEntity: NSManagedObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppConstants.kBackgroudColor
        initNavSetting()
        addSubviews()
        initLayout()
    }
    
    func initNavSetting() {
        edgesForExtendedLayout = UIRectEdge.bottom
        navigationController?.navigationBar.backgroundColor = AppConstants.kBackgroudColor
        navigationController?.navigationBar.barTintColor = AppConstants.kBackgroudColor
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func addSubviews() {
        view.addSubview(detailBGImage)
        
        mainInfoView.layer.borderWidth = 1
        mainInfoView.layer.borderColor = AppConstants.kLightGrayColor.cgColor
        mainInfoView.layer.cornerRadius = AppConstants.kCornerRadius
        view.addSubview(mainInfoView)
        mainInfoView.addSubview(titleLabel)
        titleLabel.text = recordEntity!.value(forKey: "title") as? String
        mainInfoView.addSubview(dateLabel)
        dateLabel.text = recordEntity!.value(forKey: "date") as? String
        mainInfoView.addSubview(amountLabel)
        let type = recordEntity!.value(forKey: "type") as? Int32
        amountLabel.text = (type == 0 ? "+"  :"-") + "$" + String((recordEntity!.value(forKey: "amount") as? Double)!)
        
        view.addSubview(locationLabel)
        locationLabel.text = "location    : " + String((recordEntity!.value(forKey: "location") as? String)!)
        view.addSubview(detailLabel)
        detailLabel.text = "comment : " + String((recordEntity!.value(forKey: "detail") as? String)!)
    }
    
    func initLayout() {
        let margin: Float = Float(AppConstants.kViewMargin)
        
        let BGImageWidth: Float = Float(AppConstants.kScreenWidth) - margin * 2
        detailBGImage.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(BGImageWidth)
            make.height.equalTo(BGImageWidth * 3 / 4)
            make.top.equalTo(view)
            make.left.equalTo(view).offset(margin)
            make.right.equalTo(view.snp.right).offset(-margin)
        }
        
        mainInfoView.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(BGImageWidth)
            make.height.equalTo(72)
            make.top.equalTo(detailBGImage.snp.bottom).offset(margin)
            make.left.equalTo(view).offset(margin)
        }
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(mainInfoView.snp.top).offset(margin / 2)
            make.left.equalTo(mainInfoView).offset(margin)
        }
        dateLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(titleLabel.snp.bottom).offset(margin / 2)
            make.left.equalTo(mainInfoView).offset(margin)
        }
        amountLabel.snp.makeConstraints{ (make) -> Void in
            make.right.equalTo(mainInfoView.snp.right).offset(-margin)
            make.centerY.equalTo(mainInfoView.snp.centerY)
        }
        
        locationLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(mainInfoView.snp.bottom).offset(margin)
            make.left.equalTo(view).offset(margin)
        }
        detailLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(locationLabel.snp.bottom).offset(margin)
            make.left.equalTo(view).offset(margin)
        }
    }
    
    private let mainInfoView: UIView = {
        return UIView()
    }()
    
    private let detailBGImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "src_background")
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.bold)
        label.textColor = AppConstants.kBlackColor
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = AppConstants.kTitleFont
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.bold)
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = AppConstants.kTitleFont
        return label
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.font = AppConstants.kTitleFont
        return label
    }()
}
