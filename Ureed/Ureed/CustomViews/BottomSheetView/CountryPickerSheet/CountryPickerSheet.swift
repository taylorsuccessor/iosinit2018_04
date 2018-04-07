//
//  CountryPickerSheet.swift
//  Ureed
//
//  Created by Amjad Private on 2/26/18.
//  Copyright © 2018 Ureed. All rights reserved.
//

import UIKit

struct Country {
    var code = ""
    var imageUrl = ""
    var title = ""
    var dialCode = ""
}
class CountryPickerSheet: BaseView , RadioButtonsSheetDelegate {
   
    @IBOutlet weak var radioSheet: RadioButtonsSheet!
    
    class var view : CountryPickerSheet {
        return CountryPickerSheet(frame: CGRect(x: 0, y: 0, w: UIScreen.main.bounds.w, h: 250))
    }
    
    var countries = [Country]()
    var selectedCountryCode:String?  = nil {
        didSet{
            guard let code = selectedCountryCode , let index = countries.index(where: {$0.code == code}) else {return}
            radioSheet.tableView.scrollToRow(at: IndexPath(row: index, section: 0), at: .middle, animated: false)
        }
    }
    
    var selectionCompletion:((Country)->())?
    
    override func xibSetup() {
        super.xibSetup()
        radioSheet.delegate = self
    }
    
    func numberOfChoices(in sheet: RadioButtonsSheet, for tableView: UITableView) -> Int {
        return countries.count
    }
    
    func choiceString(in sheet: RadioButtonsSheet, for tableView: UITableView, at indexPath: IndexPath) -> String? {
        return "+\(countries[indexPath.row].dialCode) \(countries[indexPath.row].title)"
    }
    
    func choiceImageUrl(in sheet: RadioButtonsSheet, for tableView: UITableView, at indexPath: IndexPath) -> String? {
        return countries[indexPath.row].imageUrl
    }
    
    func isChoiceSelecred(in sheet: RadioButtonsSheet, for tableView: UITableView, at indexPath: IndexPath) -> Bool {
        guard let country = selectedCountryCode?.lowercased() , !country.isBlank else {return false}
        return countries[indexPath.row].code.lowercased() == country
    }
    
    func didSelectChoice(in sheet: RadioButtonsSheet, for tableView: UITableView, at indexPath: IndexPath) {
        selectedCountryCode = countries[indexPath.row].code
        sheet.reloadData()
        selectionCompletion?(countries[indexPath.row])
    }
}
