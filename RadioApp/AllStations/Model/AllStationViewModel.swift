//
//  AllStationViewModel.swift
//  RadioApp
//
//  Created by Дмитрий Лубов on 29.07.2024.
//

import Foundation

/// Структура, описывающая экран AllStations.
struct AllStationViewModel {
    /// Идентификатор
    let id: UUID
    /// Название радиостанции.
    let title: String
    /// Жанр.
    let subtitle: String
    /// Количество голосов.
    let votes: Int
    /// Предпочтение.
    let isFavorite: Bool
    /// Ссылка
    let url: String
    /// Ссылка на изображение 
    let imageURL: String
}
