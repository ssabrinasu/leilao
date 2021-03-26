//
//  AvaliadorTests.swift
//  LeilaoTests
//
//  Created by Tabata Sabrina Sutili on 23/03/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import XCTest
@testable import Leilao


class AvaliadorTests: XCTestCase {
    
    var leiloeiro = Avaliador()
    private var joao:Usuario!
    private var jose:Usuario!
    private var maria:Usuario!
    

    override func setUp() {
        joao = Usuario(nome: "Joao")
        jose = Usuario(nome: "Jose")
        maria = Usuario(nome: "Maria")
        
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testDeveEntenderLancesEmOrdemCrescente() {
        // Cenario
        
        let leilao = Leilao(descricao: "Playstation 4")
        leilao.propoe(lance: Lance(maria, 250.0))
        leilao.propoe(lance: Lance(joao, 300.0))
        leilao.propoe(lance: Lance(jose, 400.0))
        
        // Acao
        
        let leiloeiro = Avaliador()
        try? leiloeiro.avalia(leilao: leilao)
        
        // Validacao
        
        XCTAssertEqual(250.0, leiloeiro.menorLance())
        XCTAssertEqual(400.0, leiloeiro.maiorLance())
    }
    
    func testDeveEntenderLeilaoComApenasUmLance() {
        let leilao = Leilao(descricao: "Playstatin 4")
        leilao.propoe(lance: Lance(joao, 1000.0))
        
        let leiloeiro = Avaliador()
        try? leiloeiro.avalia(leilao: leilao)
        
        XCTAssertEqual(1000.0, leiloeiro.menorLance())
        XCTAssertEqual(1000.0, leiloeiro.maiorLance())
        
    }
    
    func testDeveEncontrarOsTresMaioresLances() {
        let leilao = CriadorDeLeilao().para(descricao: "Playstation 4")
                                    .lance(joao, 300.0)
                                    .lance(joao, 300.0)
                                    .lance(maria, 400.0)
                                    .lance(joao, 500.0)
                                    .lance(maria, 600.0).constroi()

        
        
        try? leiloeiro.avalia(leilao: leilao)
        
        let listaLances = leiloeiro.tresMaiores()
        
        XCTAssertEqual(3, listaLances.count)
        XCTAssertEqual(600.0, listaLances[0].valor)
        XCTAssertEqual(500.0, listaLances[1].valor)
        XCTAssertEqual(400.0, listaLances[2].valor)
        
    }
    
    func testDeveIgnorarLeilaoNenhumlance() {
        let leilao = CriadorDeLeilao().para(descricao: "Playstation 4").constroi()
        XCTAssertThrowsError(try leiloeiro.avalia(leilao: leilao), "Não é possivel avaliar leilão sem lances") {
            (error) in print(error.localizedDescription)
        }
    }
    
    
}
