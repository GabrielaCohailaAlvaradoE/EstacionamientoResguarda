/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.resguarda.estacionamiento_web.modelo;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "tb_sede")
public class TbSede {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_sede")
    private int idSede;

    @Column(name = "nombre")
    private String nombre;

    @Column(name = "tarifa_base", columnDefinition = "decimal(8,2)")
    private BigDecimal tarifaBase;

    // --- Getters y Setters ---
    public int getIdSede() { return idSede; }
    public void setIdSede(int idSede) { this.idSede = idSede; }
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public BigDecimal getTarifaBase() { return tarifaBase; }
    public void setTarifaBase(BigDecimal tarifaBase) { this.tarifaBase = tarifaBase; }
}