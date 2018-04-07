//
//  RadioButtonsSheet.swift
//  Ureed
//
//  Created by Amjad Tubasi on 1/7/18.
//  Copyright © 2018 Amjad Tubasi. All rights reserved.
//

import UIKit


protocol RadioButtonsSheetDelegate {
    func numberOfChoices(in sheet:RadioButtonsSheet,for tableView:UITableView)->Int
    func choiceString(in sheet:RadioButtonsSheet,for tableView:UITableView,at indexPath:IndexPath)->String?
    func choiceImageUrl(in sheet:RadioButtonsSheet,for tableView:UITableView,at indexPath:IndexPath)->String?
    func isChoiceSelecred(in sheet:RadioButtonsSheet,for tableView:UITableView,at indexPath:IndexPath)->Bool
    func didSelectChoice(in sheet:RadioButtonsSheet,for tableView:UITableView,at indexPath:IndexPath)
    func choiceStringHeight(in sheet:RadioButtonsSheet,for tableView:UITableView,at indexPath:IndexPath)->CGFloat?
}

extension RadioButtonsSheetDelegate {
    func choiceStringHeight(in sheet:RadioButtonsSheet,for tableView:UITableView,at indexPath:IndexPath)->CGFloat?{return nil}
}

class RadioButtonsSheet: BaseView {

    @IBOutlet var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: BaseTableView!
   
    var delegate:RadioButtonsSheetDelegate? = nil {
        didSet{
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    override func xibSetup() {
        super.xibSetup()
        tableView.registeCell(nibName: RadioButtonCellNibName, Id: RadioButtonCellId)
    }
    
    func reloadData(){
        self.tableView.reloadData()
    }
    
    var title:String? = nil {
        didSet{
            guard let title = title , !title.isBlank else {
                tableView.tableHeaderView = nil
                return
            }
            titleLabel.text = title
            tableView.tableHeaderView = titleView
        }
    }
}

extension RadioButtonsSheet : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.numberOfChoices(in: self, for: tableView) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RadioButtonCellId, for: indexPath) as! RadioButtonCell
        cell.title = delegate?.choiceString(in: self, for: tableView, at: indexPath)
        cell.imageUrl = delegate?.choiceImageUrl(in: self, for: tableView, at: indexPath)
        cell.isChoiceSelected = delegate?.isChoiceSelecred(in: self, for: tableView, at: indexPath) ?? false
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return delegate?.choiceStringHeight(in: self, for: tableView, at: indexPath) ?? RadioButtonCellHeight
    }
}

extension RadioButtonsSheet : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectChoice(in: self, for: tableView, at: indexPath)
    }
}
