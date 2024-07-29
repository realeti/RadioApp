//
//  AllStationsModel.swift
//  RadioApp
//
//  Created by Дмитрий Лубов on 29.07.2024.
//

import Foundation

/// AllStationsModel является NameSpace для отделения ViewData различных экранов друг от друга.
enum AllStationsModel {

	/// Структура, описывающая экран AllStations.
	struct ViewData {

		/// Содержит в себе список всех радиостанций.
		let stations: [Station]
		/// Данные аватарки пользователя.
		let avatar: Data
		/// Уровень громкости.
		let volume: Double

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
