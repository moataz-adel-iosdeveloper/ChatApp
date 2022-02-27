//
//  AddFrindeView.swift
//  ChatApp
//
//  Created by ModyMayaAser on 25/02/2022.
//

import UIKit

class AddFrindeView: UIViewController {

    @IBOutlet weak var tableFrindes: UITableView!
    private var presenter: AddFrindePresenterProtocol?
    
    init() {
        super.init(nibName: "\(AddFrindeView.self)", bundle: nil)
        presenter = AddFrindePresenter(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableFrindes.register(UINib(nibName: "AddFrindeViewCell", bundle: nil), forCellReuseIdentifier: "AddFrindeViewCell")
        self.title = "Add Frind"
        presenter?.getAllFrindes()
    }

    @IBAction func buttonSelectedFrinde(_ sender: UIButton) {
        
    }
    
}
extension AddFrindeView : AddFrindeViewProtocol {
    func notifiyDataChange() {
        tableFrindes.reloadData()
    }
    func errorInAction(errorMessage: String) {
        self.showToast(message: errorMessage, seconds: 4)
    }
}
extension AddFrindeView : UITableViewDelegate , UITableViewDataSource ,UITableViewDataSourcePrefetching {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (presenter?.getFrindesCount())!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableFrindes.dequeueReusableCell(withIdentifier: "AddFrindeViewCell", for: indexPath) as! AddFrindeViewCell
        if let item = presenter?.getFrindeItem(index: indexPath.row) {
            cell.setCell(name: item.fullname ?? "", phone: "\(item.id ?? 0)", isSelected: (presenter?.isFrindeSelected(index: indexPath.row))!)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            if index.row >= (presenter?.getFrindesCount())! - 3 && !(presenter?.isFetsh())! {
                presenter?.getAllFrindes()
                break
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectedFrinde(index: indexPath.row)
    }
    
}
