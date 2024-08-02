//
//  AllStations.swift
//  RadioApp
//
//  Created by Дмитрий Лубов on 29.07.2024.
//

import Foundation

/// AllStations является NameSpace для отделения модели различных экранов друг от друга.
enum AllStations {

	/// Структура, описывающая экран AllStations.
	struct Model {

		/// Содержит в себе список всех радиостанций.
		let stations: [Station]

		/// Структура, описывающая радиостанцию
		struct Station {

			/// Жанр.
			let tag: String
			/// Название радиостанции.
			let title: String
			/// Количество голосов.
			let votes: Int
			/// Статус проигрывания.
			let isPlayingNow: Bool
		}
	}
}
