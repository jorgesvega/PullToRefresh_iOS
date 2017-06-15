//
//  ViewController.swift
//  PullToRefresh
//
//  Created by Jorge Sánchez Vega on 12/6/17.
//  Copyright © 2017 Jorge Sánchez Vega. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    fileprivate var numbersCollection = [Int]()
    fileprivate var numberOfElements = Int(arc4random_uniform(100)) //Returns a random number between 0 and 99
    fileprivate var counter: Int = 0
    fileprivate let cellHeight: CGFloat = 44
    fileprivate let refreshControl = UIRefreshControl()
    
    //MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        generateArray(elements: numberOfElements)
    }
    
    //MARK: - Private methods
    fileprivate func configureTableView() {
        tableView.register(UINib(nibName: CustomTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        }
        else {
            tableView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(ViewController.actionWhenPull), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Updating numbers")
    }
    
    fileprivate func generateArray(elements: Int) {
        while counter < numberOfElements {
            let member = Int(arc4random_uniform(1000))
            numbersCollection.append(member)
            numbersCollection.sort()
            counter += 1
        }
    }
    
    @objc fileprivate func actionWhenPull() {
        numberOfElements = Int(arc4random_uniform(100)) // When pull, we modify also the number of elements in the array
        numbersCollection = [Int]()
        counter = 0
        generateArray(elements: numberOfElements)
        tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    /**
     This function return a different color for text of even numbers
    */
    fileprivate func numberColor(number: Int) -> UIColor {
        if number % 2 == 0 {
            return UIColor.green
        }
        else {
            return UIColor.red
        }
    }
    
    //MARK: - Operative methods

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfElements
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        
        cell.labelCell.text = String(numbersCollection[indexPath.row])
        
        cell.labelCell.textColor = numberColor(number: numbersCollection[indexPath.row])
        
        return cell
    }
}

