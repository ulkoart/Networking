//
//  WebSiteDescription.swift
//  Networking
//
//  Created by user on 15/09/2020.
//  Copyright © 2020 Alexey Efimov. All rights reserved.
//

import Foundation

struct WebSiteDescription: Decodable {
    let websiteDescription: String?
    let websiteName: String?
    let courses: [Course]
}
