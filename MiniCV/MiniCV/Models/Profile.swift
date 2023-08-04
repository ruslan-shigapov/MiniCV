//
//  Profile.swift
//  MiniCV
//
//  Created by Руслан Шигапов on 04.08.2023.
//

struct Profile {
    let title: String
    let photo: String
    let fullName: String
    let info: String
    let location: String
    let about: String
    
    static func getProfile() -> Profile {
        Profile(
            title: "Профиль",
            photo: "Photo",
            fullName: "Шигапов Руслан Ильгамович",
            info: "Junior iOS-разработчик, опыт более 1-го года",
            location: "Казань",
            about: "Желаю развиваться как инженер в команде единомышленников, которые ставят целью разработку сверхкачественного продукта, участвовать в решении сложных и интересных задач. Меня мотивирует и заряжает технологический прогресс, быть в тренде передовых технологий и применять их в проектах."
        )
    }
}
