//
//  TouchIdSettingView.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/4/13.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import UIKit

class TouchIdSettingView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var touchIdSwitch: UISwitch!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @IBAction func didChangedValue(_ sender: UISwitch) {
        DefaultsValues.enableTouchIdLogin = touchIdSwitch.isOn
    }

    private func initView() {
        Bundle.main.loadNibNamed("TouchIdSettingView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]

        touchIdSwitch.isEnabled = BiometricsAuthentication().canEvaluatePolicy

        let notificationName = Notification.Name(rawValue: "TouchIdSetting")
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(changeSwitchStatus(notification:)),
                                               name: notificationName, object: nil)
    }

    @objc private func changeSwitchStatus(notification: Notification) {
        guard let status = notification.object as? Bool else {
            return
        }
        touchIdSwitch.isOn = status
    }
}
