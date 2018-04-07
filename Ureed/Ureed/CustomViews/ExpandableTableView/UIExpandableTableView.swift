//
//  UIExpandableTableView.swift
//  SQExpandableTable
//
//  Created by Amjad Tubasi on 6/13/17.
//  Copyright © 2017 Amjad Tubasi. All rights reserved.
//

import UIKit


public protocol UIExpandableTableViewDataSource {
    func numberOfSection(for expandableTableView:UITableView)->Int
    func numberOfRows(at section:Int,for expandableTableView:UITableView)->Int
    func viewForSection(at section:Int,for expandableTableView:UITableView)->UIView?
    func cellForRow(at indexPath:IndexPath,for expandableTableView:UITableView)->UITableViewCell
}

public protocol UIExpandableTableViewDelegate {
    func heightForRow(at indexPath:IndexPath,for expandableTableView:UITableView)->CGFloat
    func heightForHeaderSection(at section:Int,for expandableTableView:UITableView)->CGFloat
    func didSelectRow(at indexPath:IndexPath,for expandableTableView:UITableView)
    func didSelectSection(at section:Int,for expandableTableView:UITableView)
    func isExpandableSection(at section:Int,for expandableTableView:UITableView)->Bool
    func willDisplay(cell: UITableViewCell,at indexPath:IndexPath,for expandableTableView:UITableView)
}

public extension UIExpandableTableViewDelegate {
    func heightForHeaderSection(at section:Int,for expandableTableView:UITableView)->CGFloat {return 55}
    func didSelectRow(at indexPath:IndexPath,for expandableTableView:UITableView){}
    func didSelectSection(at section:Int,for expandableTableView:UITableView){}
    func isExpandableSection(at section:Int,for expandableTableView:UITableView)->Bool {return true}
    func willDisplay(cell: UITableViewCell,at indexPath:IndexPath,for expandableTableView:UITableView){}
}

class ExpandableEelement : NSObject {
    var isExpandable = true
    var numberOfChilds = 0
    var opened  = false
}

open class UIExpandableTableView: UITableView {

    public var expandableDelegate:UIExpandableTableViewDelegate?
    public var expandableDataSource:UIExpandableTableViewDataSource?
    public var oneSectionOpenedAtTime = false
    public var openedSections:[Int] {
        var sections = [Int]()
        for (index,element) in cellsArray.enumerated() {
            if element.opened {
                sections.append(index)
            }
        }
        return sections
    }
    
    fileprivate var cellsArray = [ExpandableEelement]()
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.dataSource = self
        self.delegate = self
    }

    public func isSectionOpened(section:Int)->Bool {
        if section < cellsArray.count {
            return cellsArray[section].opened
        }
        return false
    }
    
    public func invalidateExpandableTable(){
//        let sections = openedSections
        self.cellsArray = [ExpandableEelement]()
        self.reloadData()
//        for section in sections {
//            if section < cellsArray.count {
//                cellsArray[section].opened = true
//            }
//        }
//        self.reloadData()
    }
    
    public func expandSection(at section: Int) {
        guard section > -1 && section < cellsArray.count else {
            return
        }
        
        if oneSectionOpenedAtTime {
            for element in cellsArray {
                element.opened = false
            }
        }
        cellsArray[section].opened = true
        self.reloadData()
    }
    
}

extension UIExpandableTableView : UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        expandableDelegate?.didSelectRow(at: indexPath, for: tableView)
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = expandableDataSource?.viewForSection(at: section, for: tableView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapSection(_:)))
        view?.tag = section
        view?.addGestureRecognizer(tapGesture)
        return view
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return expandableDelegate?.heightForHeaderSection(at: section, for: tableView) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return expandableDelegate?.heightForRow(at: indexPath, for: tableView) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        expandableDelegate?.willDisplay(cell: cell, at: indexPath, for: tableView)
    }
    
    @objc func tapSection(_ sender: UITapGestureRecognizer){
        guard let section = sender.view?.tag else {
            return
        }

        var sectionsToReload: [Int] = [section]
        
        if oneSectionOpenedAtTime {
            for (index, element) in cellsArray.enumerated() {
                if section != index {
                    if element.opened {
                        sectionsToReload.append(index)
                        element.opened = false
                    }
                }
            }
        }
        
        cellsArray[section].opened = !cellsArray[section].opened
        expandableDelegate?.didSelectSection(at: section, for: self)

        if !cellsArray.isEmpty {
            self.beginUpdates()
            for section in sectionsToReload {
                let indexSet = NSIndexSet(index: section)
                self.reloadSections(indexSet as IndexSet, with: .automatic)
            }
            self.endUpdates()
        
        } else {
            self.reloadData()
        }
    }
    
}

extension UIExpandableTableView : UITableViewDataSource {

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = expandableDataSource?.cellForRow(at: indexPath, for: tableView) ?? UITableViewCell()
        return cell
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let element = cellsArray[section]
        if element.isExpandable == false {
            return cellsArray[section].numberOfChilds
        }
    
        
        if element.opened {
            return cellsArray[section].numberOfChilds
        }
        
        return 0
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int{
        let sections = expandableDataSource?.numberOfSection(for: tableView) ?? 0
        
        if cellsArray.isEmpty && sections > 0 {
            cellsArray = [ExpandableEelement]()
            for section in 0...sections - 1 {
                let expandableElement = ExpandableEelement()
                expandableElement.isExpandable = expandableDelegate?.isExpandableSection(at: section, for: tableView) ?? true
                expandableElement.numberOfChilds = expandableDataSource?.numberOfRows(at: section, for: tableView) ?? 0
                cellsArray.append(expandableElement)
            }
        }
        
        return cellsArray.count
    }
    
}
