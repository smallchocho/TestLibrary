//
//  ViewController.swift
//  hangge_1594
//
//  Created by hangge on 2017/3/16.
//  Copyright © 2017年 hangge.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //普通的flow流式布局
    var flowLayout:UICollectionViewFlowLayout!
    //自定义的线性布局
    var customLayout:CustomLayout!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //重用的单元格的Identifier
    let CellIdentifier = "myCell"
    
    //课程名称和图片，每一门课程用字典来表示
    let courses = [
        ["name":"Swift","pic":"swift.png"],
        ["name":"Xcode","pic":"xcode.png"],
        ["name":"Java","pic":"java.png"],
        ["name":"PHP","pic":"php.png"],
        ["name":"JS","pic":"js.png"],
        ["name":"React","pic":"react.png"],
        ["name":"Ruby","pic":"ruby.png"],
        ["name":"HTML","pic":"html.png"],
        ["name":"C#","pic":"c#.png"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初始化Collection View
        initCollectionView()
    }
    
    private func initCollectionView() {
        //初始化flow布局
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 100, height: 100)
        
        //初始化自定义布局
        customLayout = CustomLayout()
        
        //初始化Collection View
        collectionView.setCollectionViewLayout(customLayout, animated: false)
        
        //Collection View代理设置
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        
        //注册重用的单元格
        let cellXIB = UINib.init(nibName: "MyCollectionViewCell", bundle: Bundle.main)
        collectionView.register(cellXIB, forCellWithReuseIdentifier: CellIdentifier)
        
        //将Collection View添加到主视图中
        view.addSubview(collectionView)
    }
    
    //切换布局样式
    @IBAction func changeLayout(_ sender: Any) {
        self.collectionView.collectionViewLayout.invalidateLayout()
       
        //交替切换新布局
        let newLayout = collectionView.collectionViewLayout
            .isKind(of: CustomLayout.self) ? flowLayout : customLayout
        collectionView.setCollectionViewLayout(newLayout!, animated: true)
        //将滚动条移动到顶部
        let indexPath = IndexPath(row: 0, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at:.top, animated: false)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//Collection View数据源协议相关方法
extension ViewController: UICollectionViewDataSource {
    //获取分区数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //获取每个分区里单元格数量
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return courses.count
    }
    
    //返回每个单元格视图
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //获取重用的单元格
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
            CellIdentifier, for: indexPath) as! MyCollectionViewCell
        cell.label.text = courses[indexPath.item]["name"]
        //设置内部显示的图片
        cell.imageView.image = UIImage(named: courses[indexPath.item]["pic"]!)
        return cell
    }
}

//Collection View样式布局协议相关方法
extension ViewController: UICollectionViewDelegate {
    
}
