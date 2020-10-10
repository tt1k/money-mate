//
//  ViewController.swift
//  MoneyPlus
//
//  Created by FakeCoder on 2020/10/10.
//

import UIKit
import SnapKit
import CoreData

class ViewController: UIViewController {

    var recordsList = [String]()
    
    private let recordsListView: UITableView = {
        let table = UITableView()
        table.indicatorStyle = .white
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavSetting()
        initLayout()
        recordsListView.reloadData()
    }

    private let totalBalanceView: UIView = {
        let view = UIView()
        view.backgroundColor = AppConstants.kBlueColor
        view.layer.cornerRadius = AppConstants.kCornerRadius
        
        let title = UILabel()
        title.text = "Total Balance"
        title.font = UIFont.systemFont(ofSize: 40, weight: UIFont.Weight.bold)
        title.textColor = AppConstants.kWhiteColor
        view.addSubview(title)
        
        title.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.top.equalTo(view.snp.top).offset(20)
        }

        let balance = UILabel()
        balance.text = "$0"
        balance.font = UIFont.systemFont(ofSize: 50, weight: UIFont.Weight.bold)
        balance.textColor = AppConstants.kWhiteColor
        view.addSubview(balance)
        
        balance.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.top.equalTo(title.snp.bottom).offset(10)
        }
        
        return view
    }()
    
    private let incomeView: UIView = {
        let view = UIView()
        view.backgroundColor = AppConstants.kPinkColor
        view.layer.cornerRadius = AppConstants.kCornerRadius
        
        let title = UILabel()
        title.text = "Income"
        title.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.bold)
        title.textColor = AppConstants.kWhiteColor
        view.addSubview(title)
        
        title.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.top.equalTo(view.snp.top).offset(20)
        }

        let balance = UILabel()
        balance.text = "$0"
        balance.font = UIFont.systemFont(ofSize: 36, weight: UIFont.Weight.bold)
        balance.textColor = AppConstants.kWhiteColor
        view.addSubview(balance)
        
        balance.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.top.equalTo(title.snp.bottom).offset(10)
        }
        
        return view
    }()
    
    private let expenseView: UIView = {
        let view = UIView()
        view.backgroundColor = AppConstants.kPurpleColor
        view.layer.cornerRadius = AppConstants.kCornerRadius
        
        let title = UILabel()
        title.text = "Expense"
        title.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.bold)
        title.textColor = AppConstants.kWhiteColor
        view.addSubview(title)
        
        title.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.top.equalTo(view.snp.top).offset(20)
        }

        let balance = UILabel()
        balance.text = "$0"
        balance.font = UIFont.systemFont(ofSize: 36, weight: UIFont.Weight.bold)
        balance.textColor = AppConstants.kWhiteColor
        view.addSubview(balance)
        
        balance.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.top.equalTo(title.snp.bottom).offset(10)
        }
        
        return view
    }()
    
    private let recentTransactionsView: UIView = {
        let view = UIView()
        
        let image = UIImageView()
        image.image = UIImage.init(named: "src_transaction")
        view.addSubview(image)
        
        let imageSize: Float = 30
        image.snp.makeConstraints { (make) ->Void in
            make.width.equalTo(imageSize)
            make.height.equalTo(imageSize)
            make.left.equalTo(AppConstants.kViewMargin)
            make.centerY.equalTo(view)
        }

        let label = UILabel()
        label.text = "Recent Transactions"
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        label.textColor = AppConstants.kBlackColor
        view.addSubview(label)
        
        label.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(image.snp.right).offset(AppConstants.kViewMargin / 2)
            make.centerY.equalTo(view)
        }
        
        return view
    }()
    
    func initNavSetting() {
        edgesForExtendedLayout = UIRectEdge.bottom
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        view.backgroundColor = AppConstants.kWhiteColor
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addDidTap))
        navigationItem.rightBarButtonItem?.tintColor = AppConstants.kBlackColor
    }
    
    @objc func addDidTap() {
        let newVC = NewRecordVC()
        newVC.title = "New Record"
        newVC.updateRootVCData = {
            DispatchQueue.main.async {
                self.updateRecordListView()
            }
        }
        let navVC = UINavigationController(rootViewController: newVC)
        present(navVC, animated: true)
    }
    
    func updateRecordListView() {
        recordsList.removeAll()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RecordEntity")

        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let str = data.value(forKey: "title") as! String
                recordsList.append(str)
            }
        } catch let error as NSError {
            print("Could not retrieve. \(error), \(error.userInfo)")
        }
        
        recordsListView.reloadData()
    }
    
    func initLayout() {
        view.addSubview(totalBalanceView)
        view.addSubview(incomeView)
        view.addSubview(expenseView)
        view.addSubview(recentTransactionsView)
        
        recordsListView.delegate = self
        recordsListView.dataSource = self
        view.addSubview(recordsListView)
        
        let margin: Float = Float(AppConstants.kViewMargin)
        let totalBalanceViewHeight: Float = 150
        totalBalanceView.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(AppConstants.kScreenWidth)
            make.height.equalTo(totalBalanceViewHeight)
            make.top.equalTo(margin)
            make.left.equalTo(margin)
            make.right.equalTo(-margin)
        }
        
        let incomeViewSize: Float = (Float(AppConstants.kScreenWidth) - margin * 3) / 2
        let incomeViewHeight: Float = 120
        incomeView.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(incomeViewSize)
            make.height.equalTo(incomeViewHeight)
            make.top.equalTo(totalBalanceView.snp.bottom).offset(margin)
            make.left.equalTo(margin)
        }
        
        let expenseViewSize: Float = incomeViewSize
        let expenseViewHeight: Float = incomeViewHeight
        expenseView.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(expenseViewSize)
            make.height.equalTo(expenseViewHeight)
            make.top.equalTo(totalBalanceView.snp.bottom).offset(margin)
            make.right.equalTo(-margin)
        }
        
        let recentTransactionsViewHeight: Float = 50
        recentTransactionsView.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(AppConstants.kScreenWidth)
            make.height.equalTo(recentTransactionsViewHeight)
            make.top.equalTo(incomeView.snp.bottom).offset(margin)
        }
        
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let statusBarHeight: Float = Float((keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height)!)
        let navigationBarHeight: Float = Float((navigationController?.navigationBar.frame.height)!)
        let recordsListViewHeight: Float = Float(AppConstants.kScreenHeight) - totalBalanceViewHeight - incomeViewHeight - recentTransactionsViewHeight - navigationBarHeight - statusBarHeight
        recordsListView.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(AppConstants.kScreenWidth)
            make.height.equalTo(recordsListViewHeight)
            make.top.equalTo(recentTransactionsView.snp.bottom).offset(margin)
        }
    }

}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(recordsList[indexPath.row])"
        return cell
    }
}
