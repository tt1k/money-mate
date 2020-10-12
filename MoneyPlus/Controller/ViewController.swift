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

    var recordsList = [NSManagedObject]()
    var income: Double = 0
    var expense: Double = 0
    var totalBalance: Double = 0
    
    private let recordsListView: UITableView = {
        let table = UITableView()
        table.indicatorStyle = .white
        table.separatorStyle = .none
        table.register(RecordTableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppConstants.kBackgroudColor
        updateRecordListView()
        addSubviews()
        initNavSetting()
        initLayout()
    }

    private let totalBalanceView: UIView = {
        let view = UIView()
        view.backgroundColor = AppConstants.kTotalBalanceColor
        view.layer.cornerRadius = AppConstants.kCornerRadius
        view.layer.borderWidth = 1
        view.layer.borderColor = AppConstants.kWhiteColor.cgColor
        
        let title = UILabel()
        title.text = "Total Balance"
        title.font = UIFont.systemFont(ofSize: 40, weight: UIFont.Weight.bold)
        title.textColor = AppConstants.kTotalBalanceTitleColor
        view.addSubview(title)
        
        title.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.top.equalTo(view.snp.top).offset(20)
        }
        
        return view
    }()
    
    private let totalBalanceViewAmountLabel: UILabel = {
        let balance = UILabel()
        balance.text = "$0"
        balance.font = UIFont.systemFont(ofSize: 50, weight: UIFont.Weight.bold)
        balance.textColor = AppConstants.kWhiteColor
        return balance
    }()
    
    private let incomeView: UIView = {
        let view = UIView()
        view.backgroundColor = AppConstants.kIncomeColor
        view.layer.cornerRadius = AppConstants.kCornerRadius
        view.layer.borderWidth = 1
        view.layer.borderColor = AppConstants.kWhiteColor.cgColor
        
        let title = UILabel()
        title.text = "Income"
        title.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.bold)
        title.textColor = AppConstants.kIncomeTitleColor
        view.addSubview(title)
        
        title.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.top.equalTo(view.snp.top).offset(20)
        }

        return view
    }()
    
    private let incomeViewAmountLabel: UILabel = {
        let balance = UILabel()
        balance.text = "+$0"
        balance.font = UIFont.systemFont(ofSize: 36, weight: UIFont.Weight.bold)
        balance.textColor = AppConstants.kWhiteColor
        return balance
    }()
    
    private let expenseView: UIView = {
        let view = UIView()
        view.backgroundColor = AppConstants.kExpenseColor
        view.layer.cornerRadius = AppConstants.kCornerRadius
        view.layer.borderWidth = 1
        view.layer.borderColor = AppConstants.kWhiteColor.cgColor
        
        let title = UILabel()
        title.text = "Expense"
        title.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.bold)
        title.textColor = AppConstants.kExpenseTitleColor
        view.addSubview(title)
        
        title.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.top.equalTo(view.snp.top).offset(20)
        }
        
        return view
    }()
    
    private let expenseViewAmountLabel: UILabel = {
        let balance = UILabel()
        balance.text = "-$0"
        balance.font = UIFont.systemFont(ofSize: 36, weight: UIFont.Weight.bold)
        balance.textColor = AppConstants.kWhiteColor
        return balance
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
        view.addSubview(label)
        
        label.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(image.snp.right).offset(AppConstants.kViewMargin / 2)
            make.centerY.equalTo(view)
        }
        
        return view
    }()
    
    func initNavSetting() {
        edgesForExtendedLayout = UIRectEdge.bottom
        navigationController?.navigationBar.backgroundColor = AppConstants.kBackgroudColor
        navigationController?.navigationBar.barTintColor = AppConstants.kBackgroudColor
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addDidTap))
        navigationItem.rightBarButtonItem?.tintColor = AppConstants.kAntiBackgroudColor
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
            income = 0
            expense = 0
            totalBalance = 0
            for data in result as! [NSManagedObject] {
                recordsList.append(data)
                let type = data.value(forKey: "type") as? Int32
                let amount = (data.value(forKey: "amount") as? Double)!
                if type == 0 {
                    income += amount
                    totalBalance += amount
                } else {
                    expense += amount
                    totalBalance -= amount
                }
            }
            expenseViewAmountLabel.text = "-$\(expense)"
            incomeViewAmountLabel.text = "+$\(income)"
            totalBalanceViewAmountLabel.text = "$\(totalBalance)"
        } catch let error as NSError {
            print("Could not retrieve. \(error), \(error.userInfo)")
        }
        
        recordsListView.reloadData()
    }
    
    func addSubviews() {
        view.addSubview(totalBalanceView)
        view.addSubview(incomeView)
        view.addSubview(expenseView)
        view.addSubview(recentTransactionsView)
        
        recordsListView.delegate = self
        recordsListView.dataSource = self
        view.addSubview(recordsListView)
    }
    
    func initLayout() {
        let margin: Float = Float(AppConstants.kViewMargin)
        let totalBalanceViewHeight: Float = 150
        totalBalanceView.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(AppConstants.kScreenWidth)
            make.height.equalTo(totalBalanceViewHeight)
            make.top.equalTo(margin)
            make.left.equalTo(margin)
            make.right.equalTo(-margin)
        }
        totalBalanceView.addSubview(totalBalanceViewAmountLabel)
        totalBalanceViewAmountLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(totalBalanceView.snp.centerX)
            make.bottom.equalTo(totalBalanceView.snp.bottom).offset(-margin)
        }
        
        let incomeViewSize: Float = (Float(AppConstants.kScreenWidth) - margin * 3) / 2
        let incomeViewHeight: Float = 120
        incomeView.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(incomeViewSize)
            make.height.equalTo(incomeViewHeight)
            make.top.equalTo(totalBalanceView.snp.bottom).offset(margin)
            make.left.equalTo(margin)
        }
        incomeView.addSubview(incomeViewAmountLabel)
        incomeViewAmountLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(incomeView.snp.centerX)
            make.bottom.equalTo(incomeView.snp.bottom).offset(-margin)
        }
        
        let expenseViewSize: Float = incomeViewSize
        let expenseViewHeight: Float = incomeViewHeight
        expenseView.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(expenseViewSize)
            make.height.equalTo(expenseViewHeight)
            make.top.equalTo(totalBalanceView.snp.bottom).offset(margin)
            make.right.equalTo(-margin)
        }
        expenseView.addSubview(expenseViewAmountLabel)
        expenseViewAmountLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(expenseView.snp.centerX)
            make.bottom.equalTo(expenseView.snp.bottom).offset(-margin)
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
        let detailVC = DetailRecordVC()
        detailVC.title = "Record Detail"
        detailVC.recordEntity = recordsList[indexPath.row]
        let navVC = UINavigationController(rootViewController: detailVC)
        present(navVC, animated: true)
    }
    
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordsList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecordTableViewCell
        cell.layer.borderWidth = 1
        cell.layer.borderColor = AppConstants.kLightGrayColor.cgColor
        cell.layer.cornerRadius = AppConstants.kCornerRadius / 2
        cell.titleLabel.text = recordsList[indexPath.row].value(forKey: "title") as? String
        cell.dateLabel.text = recordsList[indexPath.row].value(forKey: "date") as? String
        let type = recordsList[indexPath.row].value(forKey: "type") as? Int32
        cell.amountLabel.text = (type == 0 ? "+"  :"-") + "$" + String((recordsList[indexPath.row].value(forKey: "amount") as? Double)!)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerLabel = UILabel()
        footerLabel.text = "That's all"
        footerLabel.textAlignment = NSTextAlignment.center
        footerLabel.textColor = AppConstants.kLightGrayColor
        return footerLabel
    }

}
