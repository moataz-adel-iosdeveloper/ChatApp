//
//  FrindesView.swift
//  ChatApp
//
//  Created by ModyMayaAser on 25/02/2022.
//

import UIKit
import Kingfisher

class FrindesView: UIViewController {
    
    @IBOutlet weak var tableFrindes: UITableView!
    var imageProfile : UIImageView = UIImageView.init(image: UIImage(named: "User.png"))
    private var presenter: FrindesViewPresenterProtocol?
    
    init() {
        super.init(nibName: "\(FrindesView.self)", bundle: nil)
        presenter = FrindesViewPresenter(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableFrindes.register(UINib(nibName: "FrindesViewCell", bundle: nil), forCellReuseIdentifier: "FrindesViewCell")
        self.navigationItem.setHidesBackButton(true, animated: true)
        AddNavigationBarItems()
        presenter?.getMyFrindes()
        //presenter?.getProfileData()
    }
    
    func AddNavigationBarItems() {
        let btnLogo = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        btnLogo.setTitle("", for: .normal)
        btnLogo.backgroundColor = UIColor.clear
        btnLogo.layer.cornerRadius = 12.5
        btnLogo.layer.masksToBounds = true
        btnLogo.addTarget(self, action: #selector(goToProfilePage), for: UIControl.Event.touchUpInside)
        imageProfile.image = imageProfile.image?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        btnLogo.setImage(imageProfile.image, for: .normal)
        let barButton = UIBarButtonItem(customView: btnLogo)
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFrinde))
        navigationItem.rightBarButtonItems = [barButton,add]
    }
    @objc func goToProfilePage() {
        self.navigationController?.pushViewController(Profile(), animated: true)
    }
    @objc func addFrinde() {
        self.navigationController?.pushViewController(AddFrindeView(), animated: true)
    }
}

extension FrindesView : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (presenter?.getFrindesCount())!
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableFrindes.dequeueReusableCell(withIdentifier: "FrindesViewCell", for: indexPath) as! FrindesViewCell
        if let item = presenter?.getFrindeItem(index: indexPath.row) {
            cell.setCell(name: item.fullname ?? "" , phone: "\(item.id ?? 0)")
        }
        return cell
    }
}

extension FrindesView : FrindesViewProtocol {
    func errorInAction(errorMessage: String) {
        self.showToast(message: errorMessage, seconds: 4)
    }
    
    func updateDate(userImage: String) {
        if let url = URL(string: userImage) {
            self.imageProfile.kf.setImage(with: url)
        }
    }
    
    func notifiyDataChange() {
        tableFrindes.reloadData()
    }
}
