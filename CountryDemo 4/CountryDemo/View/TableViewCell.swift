//
//  TableViewCell.swift
//  CountryDemo
//

import UIKit

class TableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var lblNameRegion:UILabel!
    @IBOutlet weak var lblCode:UILabel!
    @IBOutlet weak var lblCapital:UILabel!
    
    //MARK: - Variables
    static var identifier: String {return String(describing: self)}

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    //MARK: - Other methods
    func setCellView(model:CountryBaseModel){
        lblNameRegion.text = "\(model.name ?? ""), \(model.region ?? "")"
        lblCode.text       = "\(model.code ?? "")"
        lblCapital.text    = "\(model.capital ?? "")"
    }

}
