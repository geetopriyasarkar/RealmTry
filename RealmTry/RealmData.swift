//
//  RealmData.swift
//  RealmTry
//
//  Created by Manmohan on 14/11/19.
//  Copyright © 2019 Geet. All rights reserved.
//

import Foundation
import RealmSwift

class CityLib: Object {
    @objc dynamic var CityName = ""
    @objc dynamic var ProvinceName = ""
    @objc dynamic var CountryName = ""
}
