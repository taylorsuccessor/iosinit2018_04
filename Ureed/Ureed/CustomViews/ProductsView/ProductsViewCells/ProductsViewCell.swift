//
//  ProductsViewCell.swift
//  Ureed
//
//  Created by Amjad Tubasi on 1/3/18.
//  Copyright © 2018 Amjad Tubasi. All rights reserved.
//

import UIKit

protocol ProductsViewCellDelegate {
    func didTapAddToFavorites(in :ProductsViewCell,at indexPath:IndexPath)
    func didTapShowProductInfo(in :ProductsViewCell,at indexPath:IndexPath)
    func didTapRemoveProductButton(in cell:ProductsViewCell,at indexPath:IndexPath)
}

class ProductsViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var infoButton: UIButton?
    @IBOutlet weak var favoriteButton: UIButton?
    @IBOutlet weak var eanLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var removeButton: UIButton?
    @IBOutlet weak var skuLabel: UILabel?
    @IBOutlet weak var quantityLabel: UILabel?
    @IBOutlet weak var priceLabel: UILabel?
    @IBOutlet weak var stackView: UIStackView?
    @IBOutlet weak var stackViewHeightConstraint: NSLayoutConstraint?
    
    var delegate:ProductsViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        eanLabel.text = nil
        titleLabel.text = nil
        imageView.image = nil
        stackViewHeightConstraint?.constant = 0
        stackView?.isHidden = true
        stackView?.removeSubviews()
    }
    
    @IBAction func addTofavoritesAction(_ sender: Any) {
        delegate?.didTapAddToFavorites(in: self, at: indexPath)
    }
    
    @IBAction func showProductInfoAction(_ sender: Any) {
        delegate?.didTapShowProductInfo(in: self, at: indexPath)
    }
    
    @IBAction func removeProductAction(_ sender: Any) {
        delegate?.didTapRemoveProductButton(in: self, at: indexPath)
    }
    
    var title:String? = nil {
        didSet{
            titleLabel.text = title
        }
    }
    
    var imageUrl:String? = nil {
        didSet{
            ImageLoaderHelper.loadImage(url: imageUrl, into: imageView, pleacholder: .country)
        }
    }
    
    var ean : String? = nil {
        didSet{
            eanLabel.text = ean
        }
    }
    
    var isProductInFavorites : Bool = false {
        didSet{
            guard let favoriteButton = favoriteButton else {return}
            favoriteButton.setImage(isProductInFavorites ? #imageLiteral(resourceName: "add_to_favorites_selected") : #imageLiteral(resourceName: "add_to_favorites_default"), for: .normal)
        }
    }
    
    var quantity : String? = nil {
        didSet{
            quantityLabel?.text = quantity
        }
    }
    
    var sku : String? = nil {
        didSet{
            skuLabel?.text = sku
        }
    }
    
    var price : String? = nil {
        didSet{
            priceLabel?.text = price
        }
    }
    
    var actions = [CellAction](){
        didSet{
            guard !actions.isEmpty else {
                stackViewHeightConstraint?.constant = 0
                stackView?.isHidden = true
                return
            }
            
            stackView!.isHidden = false
            stackViewHeightConstraint!.constant = 24

            for action in actions {
                let button = UIButton(type: .custom)
                button.setTitle(action.title, for: .normal)
                button.setBackgroundColor(action.backgroundColor, forState: .normal)
                button.setTitleColor(action.titleColor, for: .normal)
                button.addTapGesture(action: {_ in
                    action.handler()
                })
                
                stackView!.addArrangedSubview(button)
            }
        }
    }
    
}
