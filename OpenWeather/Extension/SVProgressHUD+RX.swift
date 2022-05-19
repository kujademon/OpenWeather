//
//  SVProgressHUD+RX.swift
//  Mini Github
//
//  Created by Pitchaorn on 20/4/2565 BE.
//

import Foundation
import RxSwift
import RxCocoa
import SVProgressHUD

extension Reactive where Base: SVProgressHUD {

   public static var isAnimating: Binder<Bool> {
      return Binder(UIApplication.shared) {progressHUD, isVisible in
         if isVisible {
            SVProgressHUD.show()
         } else {
            SVProgressHUD.dismiss()
         }
      }
   }

}
