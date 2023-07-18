//
//  Toast.swift
//  walleeDemo
//
//  Created by Ira Paliy on 09.06.23.
//

import Foundation
import AlertToast

struct Toast: Equatable {
    var shouldShow: Bool
    var type: AlertToast.AlertType
    var title: String?
}
