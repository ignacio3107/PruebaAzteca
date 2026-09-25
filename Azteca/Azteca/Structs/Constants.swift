//
//  Constants.swift
//  Azteca
//
//  Created by Ignacio Hernández on 24/09/26.
//

import Foundation

struct Constant {
    struct Home {
        static var camera: String {
            return "Cámara"
        }
        static var photo: String {
            return "Foto"
        }
        static var fullName: String {
            return "Nombre completo"
        }
        static var phone: String {
            return "Número telefónico"
        }
        static var birthdate: String {
            return "Fecha de nacimiento"
        }
        static var gender: String {
            return "Sexo"
        }
        static var favoriteColor: String {
            return "Color favorito"
        }
    }
    
    struct Detail {
        static var linkImage: String {
            return "https://http2.mlstatic.com/vegeto-tamano-real-para-armar-en-papercraft-D_NQ_NP_892880-MLA26232224460_102017-F.jpg"
        }
    }
    
    struct Color {
        static var rojo: String {
            return "Rojo"
        }
        static var verde: String {
            return "Verde"
        }
        static var azul: String {
            return "Azul"
        }
        static var amarillo: String {
            return "Amarillo"
        }
        static var cafe: String {
            return "Cafe"
        }
    }
    
    struct Gender {
        static var femenino: String {
            return "Femenino"
        }
        static var masculino: String {
            return "Masculino"
        }
    }
    
    struct Alert {
        static var titleError: String {
            return "Error"
        }
        static var messageErrorCamera: String {
            return "Tu dispositivo no cuenta con cámara para fotografías"
        }
        static var messageIncompleteSection: String {
            return "Esta sección no se terminó por falta de tiempo 😅"
        }
        static var btnAcept: String {
            return "Aceptar"
        }
    }
    
    struct Celdas {
        static var heightHeaderGral: CGFloat {
            return 30
        }
        static var heightPhoto: CGFloat {
            return 200
        }
        static var heightImage: CGFloat {
            return 150
        }
        static var heightTextField: CGFloat {
            return 60
        }
        static var heightDefault: CGFloat {
            return 80
        }
    }
    
    struct Regex {
        static var characteres: String {
            return "^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]+$"
        }
    }
    
    struct MaxDigits {
        static var name: Int {
            return 30
        }
        static var phone: Int {
            return 10
        }
    }
}
