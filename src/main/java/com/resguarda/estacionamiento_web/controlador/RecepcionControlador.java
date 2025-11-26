/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.resguarda.estacionamiento_web.controlador;

import com.resguarda.estacionamiento_web.interfaces.*;
import com.resguarda.estacionamiento_web.modelo.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class RecepcionControlador {

    @Autowired
    private PisoDAO pisoDAO;
    @Autowired
    private VehiculoDAO vehiculoDAO;
    @Autowired
    private UsuariosWebDAO usuariosWebDAO;
    @Autowired
    private EspacioDAO espacioDAO;
    @Autowired
    private RegistroDAO registroDAO;
    @Autowired
    private PagosDAO pagosDAO;

    @GetMapping("/recepcion/dashboard")
    public String verDashboardRecepcion(HttpSession session, Model model) {
        TbEmpleado empleado = (TbEmpleado) session.getAttribute("empleadoLogueado");
        if (empleado == null || empleado.getIdRol() != 3) {
            return "redirect:/";
        }
        
        List<TbPiso> pisos = pisoDAO.findAllWithEspacios();
        model.addAttribute("pisos", pisos);
        return "recepcion_dashboard";
    }

    @PostMapping("/recepcion/registrarEntrada")
    public String registrarEntrada(@RequestParam String placa,
                                 @RequestParam(required = false) String dni,
                                 @RequestParam Integer idEspacio,
                                 HttpServletRequest request,
                                 RedirectAttributes redirectAttributes) {

        HttpSession session = request.getSession();
        TbEmpleado recepcionista = (TbEmpleado) session.getAttribute("empleadoLogueado");
        if (recepcionista == null) { return "redirect:/"; }

        Optional<TbVehiculo> optVehiculo = vehiculoDAO.findByPlaca(placa);
        if (optVehiculo.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Placa '" + placa + "' no encontrada. El vehículo debe estar registrado.");
            return "redirect:/recepcion/dashboard";
        }
        TbVehiculo vehiculo = optVehiculo.get();

        TbUsuariosWeb conductor;
        if (dni != null && !dni.isBlank()) {
            Optional<TbUsuariosWeb> optConductor = usuariosWebDAO.findByDni(dni);
            if (optConductor.isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "DNI de conductor '" + dni + "' no encontrado. Registrelo como temporal.");
                return "redirect:/recepcion/dashboard";
            }
            conductor = optConductor.get();
        } else {
            conductor = vehiculo.getPropietario();
        }

        Optional<TbEspacio> optEspacio = espacioDAO.findById(idEspacio);
        if (optEspacio.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Espacio no válido.");
            return "redirect:/recepcion/dashboard";
        }
        TbEspacio espacio = optEspacio.get();
        if (!"LIBRE".equals(espacio.getEstado())) {
            redirectAttributes.addFlashAttribute("error", "El espacio '" + espacio.getNumeroEspacio() + "' ya está OCUPADO.");
            return "redirect:/recepcion/dashboard";
        }

        String pinTemp = String.valueOf(100000 + (int) (Math.random() * 900000));

        espacio.setEstado("OCUPADO");
        espacioDAO.save(espacio);

        TbRegistroEstacionamiento registro = new TbRegistroEstacionamiento();
        registro.setVehiculo(vehiculo);
        registro.setConductor(conductor);
        registro.setEspacio(espacio);
        registro.setRecepcionista(recepcionista);
        registro.setHoraEntrada(LocalDateTime.now());
        registro.setPinTemp(pinTemp);
        registro.setEstado("ESTACIONADO");
        registro.setMontoTotal(BigDecimal.ZERO); // Se pone 0 al inicio
        
        registroDAO.save(registro);

        redirectAttributes.addFlashAttribute("exito", "¡Entrada Registrada! Placa: " + placa + ". PIN de Salida: " + pinTemp);
        return "redirect:/recepcion/dashboard";
    }

    
    @PostMapping("/recepcion/buscarSalida")
    public String buscarRegistroParaSalida(@RequestParam String placaOpin,
                                         RedirectAttributes redirectAttributes) {

        Optional<TbRegistroEstacionamiento> optRegistro = registroDAO.findActiveRegistroByPlacaOrPin(placaOpin);

        if (optRegistro.isEmpty()) {
            redirectAttributes.addFlashAttribute("errorSalida", "No se encontró ningún registro activo con esa placa o PIN.");
            return "redirect:/recepcion/dashboard";
        }

        TbRegistroEstacionamiento registro = optRegistro.get();

        LocalDateTime ahora = LocalDateTime.now();
        Duration duracion = Duration.between(registro.getHoraEntrada(), ahora);
        long minutosTranscurridos = duracion.toMinutes();
        long horasACobrar = (long) Math.ceil(minutosTranscurridos / 60.0);
        if (horasACobrar == 0) horasACobrar = 1;

        // TODO: Cargar tarifa base de la sede real
        BigDecimal tarifaBase = new BigDecimal("5.00");
        BigDecimal montoTotal = tarifaBase.multiply(new BigDecimal(horasACobrar));
        
        // --- AQUÍ ESTABA EL ERROR 1 ---
        registro.setMontoTotal(montoTotal); // <-- CORREGIDO (sin .doubleValue())

        redirectAttributes.addFlashAttribute("registroEncontrado", registro);
        redirectAttributes.addFlashAttribute("minutosTranscurridos", minutosTranscurridos);
        redirectAttributes.addFlashAttribute("horasACobrar", horasACobrar);

        return "redirect:/recepcion/dashboard";
    }

    
    @PostMapping("/recepcion/registrarPago")
    public String registrarPago(@RequestParam Integer idRegistro,
                                @RequestParam String montoTotal,
                                @RequestParam String montoRecibido,
                                @RequestParam String metodoPago,
                                RedirectAttributes redirectAttributes) {

        BigDecimal bdMontoTotal = new BigDecimal(montoTotal);
        BigDecimal bdMontoRecibido = new BigDecimal(montoRecibido);

        if (bdMontoRecibido.compareTo(bdMontoTotal) < 0) {
            redirectAttributes.addFlashAttribute("errorSalida", "El monto recibido es menor al monto total a pagar.");
            return "redirect:/recepcion/dashboard";
        }

        BigDecimal vuelto = bdMontoRecibido.subtract(bdMontoTotal);

        Optional<TbRegistroEstacionamiento> optRegistro = registroDAO.findById(idRegistro);
        if (optRegistro.isEmpty()) {
            redirectAttributes.addFlashAttribute("errorSalida", "Error: No se encontró el registro para pagar.");
            return "redirect:/recepcion/dashboard";
        }
        TbRegistroEstacionamiento registro = optRegistro.get();

        registro.setEstado("FINALIZADO");
        registro.setHoraSalida(LocalDateTime.now());
        registro.setMontoTotal(bdMontoTotal); 
        registroDAO.save(registro);

        TbEspacio espacio = registro.getEspacio();
        espacio.setEstado("LIBRE");
        espacioDAO.save(espacio);

        TbPagos pago = new TbPagos();
        pago.setRegistro(registro);
        pago.setMontoTotal(bdMontoTotal);
        pago.setMontoRecibido(bdMontoRecibido);
        pago.setVuelto(vuelto);
        pago.setMetodoPago(metodoPago);
        pago.setFechaPago(LocalDateTime.now());
        pagosDAO.save(pago);

        redirectAttributes.addFlashAttribute("exito", "¡Salida registrada! Vehículo: " + registro.getVehiculo().getPlaca() + ". Vuelto: S/ " + vuelto);
        return "redirect:/recepcion/dashboard";
    }
}