MODULE MainModule
    
! Proyecto: Sistema de Paletizado CATOEX | TIA ROBOTICS.

! Historial de modificaciones:
! Fecha       | Ingeniero          | Descripción
! ------------|--------------------|-------------------------------------------------------------------------------------
! 2025-08-08  | Ivan Martinez      | Se quito rutina TRAP, en su lugar se agrego instruccion SearchL (para tomar carton)
! 0000-00-00  | ?????????          | 
! 0000-00-00  | ?????????          | 
! 0000-00-00  | ?????????          | 
! -----------------------------------------------------------------------------------------------------------------------    
!
! Proyecto en GitGub: https://github.com/EdgarIvanMM/PaletizadoCajasConFrascos
!
! NOTA: REGISTRAR TODO CAMBIO REALIZADO PARA MANTENER TRAZABILIDAD.

    !WOBJ
    PERS wobjdata wobjPr; !Variable de wobj que guara el wobj a utilizar (izquierda o derecha)
    PERS wobjdata WobjOrientacionCamaImpar := [FALSE, TRUE, "", [[490, -1850, -670], [1,-5.99539E-06,-9.11397E-07,1.37035E-05]], [[0,0,0],[1,0,0,0]]]; !Corresponde a tarima IZQUIERDA. (Viendo el robot desde la vista frontal)
    TASK PERS wobjdata IzquierdawobjCamaImpar:=[FALSE,TRUE,"",[[490,650,-670],[1, -5.99539E-06, -9.11397E-07, 1.37035E-05]],[[0, 0, 0],[1, 0, 0, 0]]]; !Corresponde a tarima DERECHA. (Viendo el robot desde la vista frontal)
    TASK PERS wobjdata wobjConveyor:=[FALSE,TRUE,"",[[1596.12,148.134,-300],[0.00364168,9.64088E-05,2.07697E-06,0.999993]],[[0,0,0],[1,0,0,0]]];                                          !Wobj de conveyor
    !TASK PERS wobjdata wobjConveyor:=[FALSE,TRUE,"",[[650,-170,-300],[1, 0, 0, 0]],[[0, 0, 0],[1, 0, 0, 0]]];
    
    TASK PERS wobjdata wobjMesaCarton:=[FALSE,TRUE,"",[[-161,79,29],[1,0,0,0]],[[0,0,0],[1,0,0,0]]];                                                   !Wobj de mesa donde se toma el carton.
    TASK PERS wobjdata wobbanda:=[FALSE,TRUE,"",[[1596.12,148.134,55.2362],[0.00364168,9.64088E-05,2.07697E-06,0.999993]],[[0,0,0],[1,0,0,0]]];
    
    !TOOLDATA                                                                                                                                                                    
    PERS tooldata BoxUp := [TRUE,[[0,0,150],[1,0,0,0]],[28.7,[6.3,-16.5,263.1],[1,0,0,0],3.887,2.517,1.945]]; !HACER DE NUEVO RUTINA DE PAYLOAD, NO APLICAN ESTOS DATOS.   28-07-25
    PERS tooldata ToolActual;  !Variable tooldata para la herramienta que esta siendo utilizada en el proceso                                                                                                                                        
     
    !ROBTARGETS
    !En uso                                                                                                                                                                                                         
    CONST robtarget home := [[1329.53,-19.92,818.13],[0.0137739,-0.6962,0.717715,-0.000665094],[-1,0,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget agarrar := [[0,0,0],[0.00688587,0.70031,-0.713771,-0.00702459],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];                     !Girada de manera vertical (posicion en la que se agarran las cajas).
    VAR   robtarget dejar := [[0,0,0],[0.000302394,0.00698494,-0.999976,-0.000184941],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];                      !Variable robtarget que almacena la posicion para dejar (de manera vertical u horizontal).
    VAR   robtarget dejarVertical := [[0,0,0],[0.0137939,-0.703933,0.710132,-0.0007531],[-1,0,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];                  !Corresponde a herramienta dejando de manera VERTICAL (Viendo el robot en la vista frontal) (De la misma manera que llegan en el conveyor)
    VAR   robtarget dejarHorizontal:=[[0,0,0],[0.0104383,0.00174317,0.999903,0.00903741],[0,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];                  !Corresponde a herramienta dejando de manera HORIZONTAL (Viendo el robot en la vista frontal) (Girada 180 grados a diferencia de como llegan en conveyor)
    VAR   robtarget robDejarCarton:=[[0,0,0],[0.0104383,0.00174317,0.999903,0.00903741],[0,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];                   !Robtarget para dejar carton en tarima. (Hereda X, Y, Z de PLC).
    CONST robtarget tomarCarton:=[[-715.84,1191.90,375.58],[0.0113336,0.703552,-0.710535,-0.00514168],[1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];    !Robtarget para tomar carton, siempre misma posion en el centro de la mesa de tomado de carton.
    CONST robtarget llegadaCarton:=[[-715.83,1191.90,1140.24],[0.0113272,0.703552,-0.710535,-0.00514134],[1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]; !Robtarget arriba de la tomada de carton.
    CONST robtarget salidaCarton:=[[379.50,1191.86,1140.23],[0.0113336,0.703543,-0.710544,-0.0051211],[0,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];   !Robtarget que se acerca a la mesa de carton pero sigue estan afuera.
    
    !De prueba
    CONST robtarget prueba := [[218.94,159.17,193.84],[0.0137939,-0.703933,0.710132,-0.0007531],[-1,0,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget p20    := [[169.02,14.01,255.24],[0.000807693,0.7168,0.697143,0.013762],[0,0,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]; !DEJAR VERTICAL.
    CONST robtarget p10    := [[169.09,14.01,255.31],[0.0104383,0.00174317,0.999903,0.00903741],[0,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];  
    
    CONST robtarget p30:=[[1304.18,659.07,-37.16],[0.0137939,-0.703933,0.710132,-0.0007531],[-1,0,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget p40:=[[1305.67,106.84,686.43],[0.0219522,-0.706853,-0.706232,-0.0333645],[0,0,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget pruebaAgarrar:=[[607.17,135.00,222.91],[0.00688587,0.70031,-0.713771,-0.00702459],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    
    CONST robtarget pruebaTRAParriba:=[[1505.14,956.27,1284.52],[0.0105809,-0.701041,0.713043,0.000173269],[0,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget pruebaTRAPabajo:=[[1504.92,956.06,-223.84],[0.0104377,-0.701054,0.713032,0.000192582],[0,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    
    !Variables para configuraciones de velocidad y z de los movimientos.
    VAR num velBase := 0;  !Velocidad tope maxima que hara el robot.
    VAR num velConPeso := 0;
    VAR speeddata VSC:=[1000, 500, 5000, 1000];   ! Velocidad sin caja.
    VAR speeddata VCC:=[1000, 500, 5000, 1000];   ! Velocidad con caja.
    VAR speeddata VIC:=[4000, 500, 5000, 1000];   ! Velocidad para ir por carton.
    VAR speeddata VBC:=[500, 500, 5000, 1000];    ! Velocidad para bajar por carton.
    VAR zonedata zSin :=z60; !Z SIN caja.
    VAR zonedata zCon :=z50; !Z CON caja.
    
    !Variables para configuracion de carga
    PERS loaddata cargaDinamica := [0,[0,0,0],[0,0,0,1],0,0,0];
    VAR num cargaMax := 40;

    !Dimensiones cajas.
    VAR num anchoCaja := 0;
    VAR num largoCaja := 0;
    VAR num altoCaja  := 0;
    VAR num pesoCaja  := 0;
    
    !Dimensiones tarima.
    VAR num anchoTarima := 0;
    VAR num largoTarima := 0;
    VAR num altoTarima := 0;
    VAR num pallet; !Para guardar en que tarima se paletizara.
    VAR num carton;
    
    !VARIABLES DE SEGUIMIENTO.
    VAR num cajaInicial  := 0;
    VAR num cajasTotales := 0;
    VAR num cajaActual   := 0;
    VAR num cajasTotal   := 0;
    !---------------------------
    VAR num camaInicial  := 0;
    VAR num camaTotales  := 0;
    !---------------------------
    VAR num contadorCaja := 0;
    VAR num contadorCama := 0;
    VAR num alturaTotalPallet := 0;
    !--------------------------
    VAR num alturaActual := 0;
    VAR num tercio1 := 0;
    VAR num tercio2 := 0;
    VAR num tercio3 := 0;

    !VARIABLES DE POSICION.
    !Posiciones en pallet
    VAR num posX := 0;
    VAR num posY := 0;
    VAR num giro := 0;
    VAR num zDejar := 0;
    
    !Posiciones en conveyor
    VAR num xConveyor;
    VAR num yConveyor;
    VAR num alturaTomar;
    
    !VARIABLES DE TEXTO
    VAR string txtCajaConPeso;
    VAR string txtCajaSinPeso;
    VAR string txtPesoCaja;
    VAR string txtToolSelec;

!------------------------------------------------------------------------
                                                                         !------------------------------------------------------------------------
    PROC Main()
        ReiniciarVariables;
        LeerParametros;                                                           !Obtiene parametros desde PLC.
        !ActualizarParametros;                                                    !Actualiza parametros de velocidad y carga dependiendo dimensiones y peso de caja.
        MoveJ home, VSC, zSin, ToolActual, \WObj:= wobj0;
        WHILE contadorCama <= camaTotales DO                                      !Correr proceso siempre que no se hayan completado las camas totales indicadas. 
            PonerCarton;                                                          
            TomarCaja;
            Paletizar;
        ENDWHILE
        FinalizarPaletizado;                                                      !Reinicia variables y mandar a home.
        <SMT>
	ENDPROC
    
    PROC LeerParametros()
        !Parametros de caja.                              
        altoCaja  := GInput (REM_ALTURA_PRODUCTO);   !Recibe la altura de la caja desde PLC.
        pesoCaja  := GInput (REM_PESO_PRODUCTO);     !Recibe el peso de la caja desde el PLC.
        
        !Parametros de tarima.
        anchoTarima := GInput (REM_TARIMA_DIMENSION_Y)/10;    !Recibe el ancho de la tarima desde PLC.  Se divide /10 porque necesitamos el valor en mm.                         
        largoTarima := GInput (REM_TARIMA_DIMENSION_X)/10;    !Recibe el largo de la tarima desde PLC.  Se divide /10 porque necesitamos el valor en mm.                 
        altoTarima  := GInput (REM_TARIMA_DIMENSION_Z)/10;    !Recibe el alto de la tarima desde PLC.   Se divide /10 porque necesitamos el valor en mm. 
        
        pallet := REM_PALLET; !Para decision si va por carton en la cama actual o no.    1 = Ir por carton | 0 = NO ir por carton.
        carton := REM_CARTON;
        
        !Parametros para el proceso de paletizado.
        !Camas
        contadorCama  := GInput (REM_CAMA_INICIAL);                              !Recibe cama por la cual iniciar el paletizado.
        SetGO ABB_CONTADOR_CAMAS, contadorCama;                                  !Enviar retroalimentacion a PLC.
        camaTotales  := GInput (REM_CAMA_TOTALES);                               !Total de camas.
        
        !Cajas
        contadorCaja  := GInput (REM_PRODUCTO_INICIAL);                          !Corresponde a la caja por la cual iniciara el paletizado. 
        SetGO ABB_CONTADOR_PRODUCTO, contadorCaja;                               !Enviar retroalimentacion a PLC.
        cajasTotales := GInput (REM_PRODUCTO_TOTALES_POR_CAMA);                  !Corresponde a las cajas totales por CAMA.
                                                            
        ToolActual := BoxUp;                                                     !Herramienta activa con la cual se realizara el paletizado.
        alturaTomar := altoCaja;                                                 !Variable recibida por PLC igualamos a nuestro alturaTomar para offset en Z al tomar. 
        SeleccionPallet;                                                         !Se selecciona el pallet en el cual estara realizando el paletizado, izquierda o derecha.
    ENDPROC
    
    PROC ActualizarParametros()
        ActualizarCarga;
        ActualizarVelocidad;
    ENDPROC
    
    PROC ActualizarCarga()
        cargaDinamica := [pesoCaja, [0, 0, altoCaja / 2000], [0, 0, 0, 1], 0.01, 0.01, 0.01];      !Calcula la nueva carga, tomando en cuenta el peso de la caja.
        GripLoad cargaDinamica;                                                                    !Se carga la nueva configuracion de carga.
        
        !Mostrar en FlexPendant la herramienta a utilizar.
        txtToolSelec := "Herramienta cargada= " + ValToStr(toolActual);
        TPWrite txtToolSelec;
        
        !Mostrar en FlexPendant la carga.
        txtPesoCaja := "Carga actualizada= " + ValToStr(pesoCaja) + "Kg";
        TPWrite txtPesoCaja;
    ENDPROC
    
    PROC ActualizarVelocidad ()
        velBase := 5000 * (cargaMax - toolActual.tload.mass) / cargaMax;                                                         !Calcula la velocidad base, solo toma en cuenta la capacidad de robot y peso herramienta -Principalmente para movimientos sin peso extra a herramienta-.
        velConPeso := velBase * (cargaMax - (toolActual.tload.mass + pesoCaja)) / (cargaMax - toolActual.tload.mass);            !Calcula la nueva velocidad a utilizar con peso, toma en cuenta peso de herramienta, peso de caja y capacidad del robot. -Principalmente para movimientos con caja-
        VSC := [velBase, 500, 5000, 1000];   ! Velocidad sin caja.                                                               !Actualiza velocidad sin caja
        VCC := [velConPeso, 500, 5000, 1000]; !Velocidad con caja.                                                               !Actualiza velocidad con caja
        
        !Mostrar en FlexPendant las nuevas velocidades.
        txtCajaConPeso := "Velocidad con caja actualizada= " + ValToStr(velConPeso) + " m/s";
        txtCajaSinPeso := "Velocidad sin caja actualizada= " + ValToStr(velBase) + " m/s";
        TPWrite txtCajaConPeso;
        TPWrite txtCajaSinPeso;
    ENDPROC
    
     PROC PonerCarton()        
        TPWrite "Si entre";
        IF REM_CARTON = 1  THEN                                         !1 = Ir por carton al iniciar cama | 0 = NO ir por carton.
            IF wobjPr = WobjOrientacionCamaImpar THEN                   !Si WOBJ actiuvo corresponde a wobj de tarima izquierda (desde vista frontal del robot).
                PonerCartonIzquierda;
            ELSEIF wobjPr = IzquierdawobjCamaImpar THEN                 !Si WOBJ actiuvo corresponde a wobj de tarima DERECHA (desde vista frontal del robot).
                PonerCartonDerecha;
            ENDIF
        ELSEIF REM_CARTON  = 0  THEN
            TPWrite "Cama sin carton";                                  !Mostrar en TeachPendant que esa cama no lleva carton.
        ENDIF
    ENDPROC
    
    PROC PonerCartonIzquierda()                                                    !PROC encargado de poner carton en el pallet IZQUIERDO (vista frontal del robot).
        IF alturaActual < 818.13 THEN                                              !Si la altura actual del paletizado es menor que la altura de Z de home, tomar en consideracion alturas normales de los puntos.
            MoveJ Offs(home, 0, 0, 0), VIC, zSin, ToolActual, \WObj:= wobj0;    
            MoveJ salidaCarton,  VIC, zSin, ToolActual, \WObj:=wobjMesaCarton;
            MoveL llegadaCarton, VIC, zSin, ToolActual, \WObj:=wobjMesaCarton;
            SearchCarton;
            MoveL salidaCarton,  VIC, zSin, ToolActual, \WObj:=wobjMesaCarton;
            MoveJ Offs(home, 0, 0, 0), VSC, zSin, ToolActual, \WObj:= wobj0;
            DejarCarton;
        ELSEIF alturaActual > 818.13 THEN                                          !Si la altura actual del paletizado es mayor que la altura de Z del punto de home, tomar en consideracion las alturas sigueintes:
            MoveJ Offs(home, 0, 0, alturaActual + 400), VIC, zSin, ToolActual, \WObj:= wobj0;   !Se considera altura actual del paletizado + 400mm (40cm) para evitar colision con paletizado.
            MoveJ Offs(salidaCarton, 0, 0, alturaActual + 400),  VIC, zSin, ToolActual, \WObj:= wobjMesaCarton;
            MoveL Offs(llegadaCarton, 0, 0, alturaActual + 400), VIC, zSin, ToolActual, \WObj:= wobjMesaCarton;
            SearchCarton;
            MoveJ Offs(salidaCarton, 0, 0, alturaActual + 400),  VIC, zSin, ToolActual, \WObj:= wobjMesaCarton;
            MoveJ Offs(home, 0, 0, alturaActual + 400), VIC, zSin, ToolActual, \WObj:= wobj0;
            DejarCarton;
        ENDIF          
    ENDPROC
    
    PROC PonerCartonDerecha()                                                      !PROC encargado de poner carton en el pallet DERECHO (vista frontal del robot).
         IF alturaActual < 1140 THEN                                               !Si la altura actual del paletizado es MENOR que la altura de Z de salidaCarton, tomar en consideracion alturas normales de los puntos.
            MoveJ salidaCarton,  VSC, zSin, ToolActual, \WObj:=wobjMesaCarton;
            MoveL llegadaCarton, VSC, zSin, ToolActual, \WObj:=wobjMesaCarton;
            SearchCarton;
            MoveL salidaCarton,  VSC, zSin, ToolActual, \WObj:=wobjMesaCarton;
            DejarCarton;
        ELSEIF alturaActual > 818.13 THEN                                          !Si la altura actual del paletizado es MAYOR que la altura de Z de salidaCarton, tomar en consideracion alturas normales de los puntos.
            !MoveJ Offs(home, 0, 0, alturaActual + 400), VSC, zSin, ToolActual, \WObj:= wobj0; !Se considera altura actual del paletizado + 400mm (40cm) para evitar colision con paletizado.
            MoveJ Offs(salidaCarton, 0, 0, alturaActual + 400),  VSC, zSin, ToolActual, \WObj:= wobjMesaCarton;
            MoveL Offs(llegadaCarton, 0, 0, alturaActual + 400), VSC, zSin, ToolActual, \WObj:= wobjMesaCarton;
            SearchCarton;
            MoveL Offs(salidaCarton, 0, 0, alturaActual + 400),  VSC, zSin, ToolActual, \WObj:= wobjMesaCarton;
            DejarCarton;
        ENDIF         
    ENDPROC
    
    PROC DejarCarton()
        MoveL Offs(robDejarCarton, largoTarima/2, anchoTarima/2, alturaActual + 400), VSC, zSin, ToolActual, \WObj:= wobjPr; !Se busca centro de la tarima en base a las dimensiones de la tarima. | 400mm arriba del punto de dejada (40cm) 
        MoveL Offs(robDejarCarton, largoTarima/2, anchoTarima/2, zDejar), VSC, zSin, ToolActual, \WObj:= wobjPr;             !Deja el carton.
        WaitRob \ZeroSpeed;
        PulseDO ABB_APAGAR_VACIO;
        WaitTime 0.5;
        MoveL Offs(robDejarCarton, largoTarima/2, anchoTarima/2, alturaActual + 400), VSC, zSin, ToolActual, \WObj:= wobjPr;
    ENDPROC
      
    PROC TomarCaja()
        !Recibe coordenadas en "x" y "y" de PLC para tomar cajas.
        xConveyor := GInput(REM_X_BANDA); 
        yConveyor := GInput(REM_Y_BANDA); 
        
        !Movimientos de entrada y salida dependiendo alturas de paletizado.
        MoveL Offs(agarrar, xConveyor, yConveyor, alturaTomar + 400), VSC, zSin, ToolActual, \WObj:= wobjConveyor;
        WaitRob\inpos;
        WaitRob \ZeroSpeed;
        PonerCarton;
        MoveL Offs(agarrar, xConveyor, yConveyor, alturaTomar + 100), VSC, zSin, ToolActual, \WObj:= wobjConveyor;                                             
        WaitDI REM_AVISO_CAJAS_EN_CONVEYOR, 1; !Esperar señal de PLC que estan en posicion las cajas para ser tomadas.
        MovimientosAgarrar;     
        MoveL Offs(agarrar, xConveyor, yConveyor, alturaActual + 400), VSC, zSin, ToolActual, \WObj:= wobjConveyor; !Salida despues de tomar caja.
        WaitRob\ZeroSpeed;
        PulseDO ABB_AVISO_CAJA_TOMADA; !Mandar señal a PLC de tomado de caja
    ENDPROC
    
    PROC MovimientosAgarrar() !Movimientos que corresponden a tomar las cajas y activacion de señales.
        PulseDO ABB_ENCENDER_VACIO;
        MoveL Offs(agarrar, xConveyor, yConveyor, alturaTomar), VSC, zSin, ToolActual, \WObj:= wobjConveyor; 
        WaitRob \ZeroSpeed;
        WaitTime 1.5;
    ENDPROC
    
    PROC CalcularAlturas()
        alturaTotalPallet := (altoCaja*camaTotales) + altoTarima;                                                                                                           !Calcula la altura total del pallet, es decir, altura que tendra el pallet cuando termine las camas totales.                                                                                                                    !Calcula la Z del paletizado todo momento.                                                                                                                
        tercio1 := alturaTotalPallet / 3;                                                                                                                                   !Se divide el total del pallet en 3 para los calculos de salida
        tercio2 := tercio1 * 2;                                                                                                                                             !Tercio 1 corresponde a primera parte del pallet. Tercio 2 a la segunda y Tercio 3 a la parte mas alta del
        tercio3 := tercio1 * 3;                                                                                                                                             !..pallet                            
    ENDPROC
    
    PROC Paletizar()
        IF contadorCaja <= cajasTotales THEN                                                                                                                    !Siempre que la caja actual sea menor a la cajas totales por cama seguir paletizando.
            CalcularAlturas;                                                                                                                                    !Se calculan las alturas, principalmente zDejar para las posiciones de dejada.
            LeerPosiciones;                         !Lee las posiciones "x" y "y" para el dejado de la caja.
            SeleccionGiro;                          !Selecciona el giro de la posicion.
            MovimientosDejar;                       !Hace movimientos para dejar la caja.
        ENDIF
    ENDPROC
    
    PROC LeerPosiciones()
        !SetGO ABB_CONTADOR_CAMAS, contadorCama;
        SetGO ABB_CONTADOR_PRODUCTO, contadorCaja;
        WaitRob\inpos;
        posX := GInput (REM_POSICION_X);                              
        posY := GInput (REM_POSICION_Y);
        giro := GInput (REM_POSICION_GIRO);
        zDejar := GInput (REM_ALTURA_ZDEJAR);
    ENDPROC
    
    PROC SeleccionGiro()
        TEST giro
            CASE 0: !CORRESPONDE A VERTICAL
                    dejar := dejarHorizontal;
            CASE 1: !CORRESPONDE A HORIZONTAL
                    dejar := dejarVertical;
        ENDTEST
    ENDPROC
    
    PROC SeleccionPallet()
        IF pallet = 0 THEN
            wobjPr := WobjOrientacionCamaImpar;
        ELSEIF pallet = 1 THEN
            wobjPr := IzquierdawobjCamaImpar;
        ENDIF
    ENDPROC
    
    PROC MovimientosDejar()
       LeerPosiciones; !PROBANDO SIN LEER ANTES DE DEJAR
       MoveL Offs(dejar, posX, posY, 250 + zDejar), VCC, zCon, ToolActual, \WObj:= wobjPr;
       MoveL Offs(dejar, posX, posY, zDejar), VCC, zCon, ToolActual, \WObj:= wobjPr;
       WaitRob \ZeroSpeed;
       PulseDO ABB_APAGAR_VACIO;
       WaitTime 1.5;
       MoveL Offs(dejar, posX, posY, zDejar + 250), VSC, zSin, ToolActual, \WObj:= wobjPr;
       Incr contadorCaja;
       IF contadorCaja > cajasTotales THEN
           Incr contadorCama;
           SetGO ABB_CONTADOR_CAMAS, contadorCama;
           PulseDO ABB_AVISO_CAMBIO_CAMA;
           alturaActual := altoTarima + altoCaja * contadorCama;
           carton := REM_CARTON;
           contadorCaja  := GInput (REM_PRODUCTO_INICIAL);
           SetGO ABB_CONTADOR_PRODUCTO, contadorCaja;
           RETURN;
       ENDIF
    ENDPROC
        
    PROC ReiniciarVariables()
        anchoCaja := 0;
        largoCaja := 0;
        altoCaja := 0;
        anchoTarima := 0;
        largoTarima := 0;
        altoTarima := 0;
        cajaInicial  := 0;
        cajasTotales    := 0;
        cajaActual   := 0;
        cajasTotal   := 0;
        camaInicial := 0;
        camaTotales   := 0;
        alturaTotalPallet := 0;
        zDejar := 0;
        posX := 0;
        posY := 0;
        giro := 0;
        contadorCama  := GInput (REM_CAMA_INICIAL); 
        SetGO ABB_CONTADOR_CAMAS, contadorCama;
        contadorCaja  := GInput (REM_PRODUCTO_INICIAL);
        SetGO ABB_CONTADOR_PRODUCTO, contadorCaja;
        !SetGO ABB_INT_ESTADO_VACIO, 0;
        !TOMAR := 1;
    ENDPROC
    
    PROC FinalizarPaletizado()                           
        MoveJ home, VSC, zSin, ToolActual, \WObj:= wobj0;
        !Avisar a PLC que termino proceso de paletizado (izquierda o derecha)
        ReiniciarVariables;
    ENDPROC
       
    !PROC encargado de la logica para tomar carton, baja con la instruccion SearchL, para que se detenga en cunto reciba la señal de que ya agarro el carton.
    PROC SearchCarton()
        VAR string mensaje;
        VAR robtarget puntoInterrupcion;

        !Ir al inicio de la trayectoria de búsqueda
        MoveL llegadaCarton, v500, fine, BoxUp \WObj:=wobjMesaCarton;

        SearchL \Stop, REM_SENSOR_TOMO_CARTON, puntoInterrupcion, tomarCarton, v100, BoxUp\WObj:=wobjMesaCarton; !Instruccion para bajar a tomarCarton hasta que se active REM_SENSOR_TOMO_CARTON.
    
        ERROR
            !mensaje := "Código de error: " + ValToStr(ERRNO);
            !TPWrite mensaje;

            IF ERRNO = 1072 THEN  ! ERR_WHLSEARCH
                TPWrite "No se detectó el cartón. Reposicionando.";
                MoveL Offs(llegadaCarton, 0, 0, 0), v500, fine, BoxUp \WObj:=wobjMesaCarton;
                TPWrite "Coloque cartón en la mesa y presione START para reintentar la búsqueda.";
                STOP;  !Pausa el programa.
                RETRY; !Espera que operador reanude el programa.
            ELSE
                TPWrite "Error inesperado: "; !Ocurrio un error no conocido
                STOP;                         !Parar el programa y revisar que sucedio.
            ENDIF
            
        TPWrite "Cartón detectado.";
        MoveL llegadaCarton, v500, fine, tool0 \WObj:=wobj0;
    ENDPROC 

ENDMODULE

!                                                                   © 2025 TIA ROBOTICS S.A. de C.V. 
!                                                                    Todos los derechos reservados.
!                                                     Este código es confidencial y de uso exclusivo de TIA ROBOTICS S.A. de C.V.
!                                              Queda prohibida su copia, distribución o modificación sin autorización expresa por escrito.
!                                                           https://tiasa.org.mx | @tia-robotics.com |