//
//  NotificationViewController.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/9/14.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

var notiDatas: [Notifications] = []

class NotificationViewController: MenuBaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = maincolor
        return view
    }()
    
    let cellId = "cellId"
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! NotificationCell
        if let time = notiDatas[indexPath.row].created_at {
            cell.time = time
        } else {
            print("did not get the time")
        }
        
        
        if let detail = notiDatas[indexPath.row].message {
            cell.detail = detail
        }
//        if let id = notiDatas[indexPath.row].data?.course_id {
//            for i in currentCourses.data {
//                for j in i {
//                    print(id, j.id!)
//                    if id == j.id! {
//                        cell.title = String(j.course!)
//                        print(j.course!)
//                    }
//                }
//            }
//        }
        cell.setupView()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notiDatas.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 105)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    let emptyView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "empty_noti")?.withRenderingMode(.alwaysTemplate)
        view.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(notiDatas.count)
        if notiDatas.count == 0 {
            view.backgroundColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)
            setupEmptyNotiView()
        } else {
            setupCollectionView()
        }
        navigationItem.title = "Notification"
        navigationController?.navigationBar.barTintColor = alphacolor
    }
    
    private func setupEmptyNotiView() {
        view.addSubview(emptyView)
        emptyView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        emptyView.center = view.center
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(NotificationCell.self, forCellWithReuseIdentifier: cellId)
        view.addSubview(collectionView)
        collectionView.frame = view.frame
    }
}













