//
//  MultipartFormDataRequest.swift
//  cheers
//
//  Created by Dong on 2024/4/2.
//

import Foundation

struct MultipartFormDataRequest {
    private let boundary = UUID().uuidString.lowercased()
    private var httpBody = NSMutableData()
    
    let URL: URL
    
    init(URL: URL) {
        self.URL = URL
    }
    
    func addTextField(_ name: String, value: String) {
        httpBody.append(textField(name, value: value))
    }
    
    func addDataField(_ name: String, data: Data) {
        httpBody.append(dataField(name, data: data))
    }
    
    func createURLRequest() -> URLRequest {
        var request = URLRequest(url: URL)
        
        request.httpMethod = "POST"
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        httpBody.append("--\(boundary)--")
        request.httpBody = httpBody as Data
        return request
    }
    
    
    private func textField(_ name: String, value: String) -> String {
        var fieldString = "--\(boundary)\r\n"
        fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
        fieldString += "Content-Type: text/plain\r\n"
        fieldString += "Content-Transfer-Encoding: 8bit\r\n"
        fieldString += "\r\n\(value)\r\n"
        
        return fieldString
    }
    
    private func dataField(_ name: String, data: Data) -> Data {
        let fieldData = NSMutableData()
        
        fieldData.append("""
            --\(boundary)\r\n
            Content-Disposition: form-data; name=\"\(name)\"\r\n
            Content-Type: \"content-type header\"\r\n\r\n
        """)
        fieldData.append(data)
        fieldData.append("\r\n")
        
        return fieldData as Data
    }
}
