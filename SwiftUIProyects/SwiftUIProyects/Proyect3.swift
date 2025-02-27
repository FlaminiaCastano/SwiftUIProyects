//
//  Proyect3.swift
//  SwiftUIProyects
//
//  Created by Flaminia Castaño on 27/02/2025.
//

import SwiftUI

/* Un ViewModifier en SwiftUI es una forma de encapsular y reutilizar modificaciones de vista. En lugar de aplicar múltiples modificadores a cada vista manualmente, puedes definir un ViewModifier personalizado y aplicarlo en cualquier parte de tu código.
 ¿Para qué sirven?
 - Reutilización: Evitan repetir los mismos estilos en varias vistas.
 - Modularidad: Separan la lógica de presentación en componentes reutilizables.
 - Mantenimiento fácil: Si necesitas cambiar un estilo, lo haces en un solo lugar. */

struct TitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundColor(.blue)
    }
}

extension View {
   func titleStyle() -> some View {
       self.modifier(TitleStyle())
    }
}

struct Proyect3: View {
    var body: some View {
        VStack {
            Text("Primary Title")
                .titleStyle()
        }
    }
}

#Preview {
    Proyect3()
}
