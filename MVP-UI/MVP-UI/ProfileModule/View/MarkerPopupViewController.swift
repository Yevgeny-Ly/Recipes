// MarkerPopupViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// всплывашка
class MarkerPopupViewController: UIViewController {
    // Можно добавить свойства для хранения данных о маркере, например:
    var markerTitle: String?
    var markerDescription: String?

    // Можно добавить IBOutlet'ы для элементов пользовательского интерфейса в модальном окне
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        // Настройка пользовательского интерфейса модального окна при загрузке

        // Установка данных маркера в соответствующие элементы пользовательского интерфейса
//        titleLabel.text = markerTitle
//        descriptionLabel.text = markerDescription
    }

    // Можно добавить методы для обработки событий или пользовательских действий
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        // Обработка нажатия кнопки закрытия модального окна
        dismiss(animated: true, completion: nil)
    }
}
