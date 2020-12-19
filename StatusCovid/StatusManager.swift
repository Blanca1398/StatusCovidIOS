//
//  StatusManager.swift
//  StatusCovid
//
//  Created by Blanca Cordova on 18/12/20.
//  Copyright © 2020 Blanca Cordova. All rights reserved.
//

import Foundation

//Quien adopte ese protocolo tendra que implementar el metodo actualizar 
protocol StatusManagerDelegate {
    func actualizarStatus(status: StatusModel)
    func huboError(cualError: Error)
}

struct StatusManager {
    var delegado: StatusManagerDelegate?
    let statusURL = "https://corona.lmao.ninja/v3/covid-19/countries/"
    
    //Para una busqueda por pais
    func fetchStatus(nombrePais: String) {
        let urlString = "\(statusURL)\(nombrePais)"
        print(urlString)
        realizarSolicitud(urlString: urlString)
    }
    //Para el GPS
    func fetchStatus(lat:Double, lon:Double) {
        let urlString = "\(statusURL)&lat=\(lat)&lon=\(lon)"
        realizarSolicitud(urlString: urlString)
    }
    
    func realizarSolicitud(urlString: String) {
        //Crear la URL
        if let url = URL(string: urlString){
            //Crear obj URLSession
            let session = URLSession(configuration: .default)
            //Asignar una tarea a la sesion
            //let tarea = session.dataTask(with: url, completionHandler: handle(data:respuesta:error:))
            let tarea = session.dataTask(with: url) { (data, respuesta, error) in
                if error != nil {
                    print(error!)
                    self.delegado?.huboError(cualError: error!)
                    return
                }
                
                if let datosSeguros = data {
                    if let status = self.parseJSON(statusData: datosSeguros) {
                        self.delegado?.actualizarStatus(status: status)
                    }
                }
            }
            //Empezar la tarea
            tarea.resume()
        }
    }

    func parseJSON(statusData: Data) -> StatusModel? {
        let decoder = JSONDecoder()
        do {
            let dataDecodificada = try decoder.decode(StatusData.self, from: statusData)
            
            let p = dataDecodificada.country
            let c = dataDecodificada.cases
            let d = dataDecodificada.deaths
            let r = dataDecodificada.recovered
            let ct = dataDecodificada.todayCases
            let dt = dataDecodificada.todayDeaths
            let rt = dataDecodificada.todayRecovered
            let f = dataDecodificada.countryInfo.flag
            let continent = dataDecodificada.continent
            
            //Crear obj personalizado
            let ObjStatus =  StatusModel(pais: p, casos: c, muertes: d, recuperados: r, casosHoy: ct, muertesHoy: dt, recuperadosHoy: rt, bandera: f, continente: continent)
            
            return ObjStatus
        } catch {
            print(error)
            delegado?.huboError(cualError: error)
            return nil
        }
    }
}
