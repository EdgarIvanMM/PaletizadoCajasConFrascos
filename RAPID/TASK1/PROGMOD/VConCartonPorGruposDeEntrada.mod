MODULE MainModule
    
    !Wobj
    !En uso
    PERS wobjdata wobjPr; !Wobj utilizado en tarima. WobjPallet
    PERS wobjdata WobjOrientacionCamaImpar := [FALSE, TRUE, "", [[490, -1850, -670], [1,-5.99539E-06,-9.11397E-07,1.37035E-05]], [[0,0,0],[1,0,0,0]]]; !No gira, mantiene la orientacion normal.
    TASK PERS wobjdata IzquierdawobjCamaImpar:=[FALSE,TRUE,"",[[490,650,-670],[1, -5.99539E-06, -9.11397E-07, 1.37035E-05]],[[0, 0, 0],[1, 0, 0, 0]]];
    TASK PERS wobjdata wobjConveyor:=[FALSE,TRUE,"",[[710,-160,-330],[1, 0, 0, 0]],[[0, 0, 0],[1, 0, 0, 0]]];
    TASK PERS wobjdata wobjMesaCarton:=[FALSE,TRUE,"",[[-161,79,29],[1,0,0,0]],[[0,0,0],[1,0,0,0]]];
    
    !Para prueba
    PERS wobjdata WobjOrientacionCamaPar:= [FALSE, TRUE, "", [[0, 0, 0], [0,0,1,0]],[[0,0,0],[1,0,0,0]]];
    TASK PERS wobjdata wobjImpar:=[FALSE,TRUE,"",[[1051.05,-429.223,-565.796],[1,-5.99539E-06,-9.11397E-07,1.37035E-05]],[[0,0,0],[1,0,0,0]]];
    TASK PERS wobjdata wobjPar:=[FALSE,TRUE,"",[[1898.64,255.881,-602.644],[5.37631E-05,-3.57543E-05,-8.801E-05,-1]],[[0,0,0],[1,0,0,0]]];
    TASK PERS wobjdata IzquierdawobjCamaPar:=[FALSE,TRUE,"",[[-368,650,-825.93],[5.37631E-05,-3.57543E-05,-8.801E-05,-1]],[[0,0,0],[1,0,0,0]]];
    TASK PERS wobjdata wobj8:=[FALSE,TRUE,"",[[1654.04,193.38,-35.8395],[0.000138908,9.77668E-05,-0.0472031,0.998885]],[[0,0,0],[1,0,0,0]]];
    
    !TOOLDATA                                                                                                                                                                    
    PERS tooldata BoxUp:=[TRUE,[[0,0,150],[1,0,0,0]],[28.7,[6.3,-16.5,263.1],[1,0,0,0],3.887,2.517,1.945]];  
    PERS tooldata ToolActual;                                                                                                                                                    
     
    !ROBTARGETS
    !En uso                                                                                                                                                                                                         
    CONST robtarget home:=[[1329.53,-19.92,818.13],[0.0137739,-0.6962,0.717715,-0.000665094],[-1,0,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget agarrar:=[[0,0,0],[0.00688587,0.70031,-0.713771,-0.00702459],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    !CONST robtarget agarrar:=[[0,0,0],[0.0041449,0.711614,0.702521,0.00719542],[-1,0,-4,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    VAR robtarget dejar:=[[0,0,0],[0.000302394,0.00698494,-0.999976,-0.000184941],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    !VAR robtarget dejarVertical:=[[0,0,0],[0.000807693,0.7168,0.697143,0.013762],[0,0,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]; SE USARON PRIMERA VERSION 21-JULIO-25
    !VAR robtarget dejarHorizontal:=[[0,0,0],[0.0104383,0.00174317,0.999903,0.00903741],[0,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];  SE USARON PRIMERA VERSION 21-JULIO-25
    VAR robtarget dejarVertical:=[[0,0,0],[0.0137939,-0.703933,0.710132,-0.0007531],[-1,0,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    VAR robtarget dejarHorizontal:=[[0,0,0],[0.0104383,0.00174317,0.999903,0.00903741],[0,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget tomarCarton:=[[-715.84,1191.90,375.58],[0.0113336,0.703552,-0.710535,-0.00514168],[1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget llegadaCarton:=[[-715.83,1191.90,1140.24],[0.0113272,0.703552,-0.710535,-0.00514134],[1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget salidaCarton:=[[379.50,1191.86,1140.23],[0.0113336,0.703543,-0.710544,-0.0051211],[0,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    VAR robtarget robDejarCarton:=[[0,0,0],[0.0104383,0.00174317,0.999903,0.00903741],[0,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    
    !De prueba
    CONST robtarget prueba := [[218.94,159.17,193.84],[0.0137939,-0.703933,0.710132,-0.0007531],[-1,0,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget p20    := [[169.02,14.01,255.24],[0.000807693,0.7168,0.697143,0.013762],[0,0,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]; !DEJAR VERTICAL.
    CONST robtarget p10    := [[169.09,14.01,255.31],[0.0104383,0.00174317,0.999903,0.00903741],[0,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];  
    
    CONST robtarget p30:=[[1304.18,659.07,-37.16],[0.0219537,-0.706848,-0.706236,-0.0333851],[0,0,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget p40:=[[1305.67,106.84,686.43],[0.0219522,-0.706853,-0.706232,-0.0333645],[0,0,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget pruebaAgarrar:=[[607.17,135.00,222.91],[0.00688587,0.70031,-0.713771,-0.00702459],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
   !CONST robtarget pruebaAgarrar:=[[563.77,-205.06,267.95],[0.0041449,0.711614,0.702521,0.00719542],[-1,0,-4,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    
    !Variables para configuraciones de velocidad y z de los movimientos.
    VAR num velBase := 0;  !Velocidad tope maxima que hara el robot.
    VAR num velConPeso := 0;
    VAR speeddata VSC:=[1000, 500, 5000, 1000];   ! Velocidad sin caja.
    VAR speeddata VCC:=[1000, 500, 5000, 1000];   ! Velocidad con caja.
    VAR speeddata VIC:=[4000, 500, 5000, 1000];   ! Velocidad para ir por carton.
    VAR speeddata VBC:=[500, 500, 5000, 1000];   ! Velocidad para bajar por carton.
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
    VAR num zDejar := 0;
    !--------------------------
    VAR num alturaActual := 0;
    VAR num tercio1 := 0;
    VAR num tercio2 := 0;
    VAR num tercio3 := 0;

    !VARIABLES DE POSICION.
    VAR num posX := 0;
    VAR num posY := 0;
    VAR num giro := 0;
    
    !VARIABLES DE TEXTO
    VAR string txtCajaConPeso;
    VAR string txtCajaSinPeso;
    VAR string txtPesoCaja;
    VAR string txtToolSelec;
    
    VAR num pallet;
    VAR num TOMAR := 1;
    VAR num alturaTomar;
    VAR num xConveyor;
    VAR num yConveyor;
    
    VAR num camasConCarton{18};
    
    
!------------------------------------------------------------------------
                                                                         !------------------------------------------------------------------------
    PROC Main()
        ReiniciarVariables;
        LeerParametros;                                                           !Obtiene parametros desde PLC.
        !ActualizarParametros;                                                    !Actualiza parametros de velocidad y carga dependiendo dimensiones y peso de caja.
        MoveJ home, VSC, zSin, ToolActual, \WObj:= wobj0;
        WHILE contadorCama <= camaTotales DO
            PonerCarton;
            TomarCaja;
            Paletizar;
        ENDWHILE
        FinalizarPaletizado;                                                      !Reinicia variables y manda a home.
        <SMT>
	ENDPROC
    
    PROC LeerParametros()
        !Parametros de caja.                              
        altoCaja  := GInput (REM_ALTURA_PRODUCTO);!/10;
        pesoCaja  := GInput (REM_PESO_PRODUCTO);
        
        !Parametros de tarima.
        anchoTarima := GInput (REM_TARIMA_DIMENSION_Y)/10;                             
        largoTarima := GInput (REM_TARIMA_DIMENSION_X)/10;                       
        altoTarima  := GInput (REM_TARIMA_DIMENSION_Z)/10; 
        
        pallet := GInput (REM_PALLET);
            
        !490 = Distancia base de robot a tarima en X,      !650= distancia base de robot a tarima en Y,            -834=Distancia entre base del robot y piso.  
        !WobjOrientacionCamaImpar := [FALSE,TRUE,"",[[490 , -1850 , -670],[1,-5.99539E-06,-9.11397E-07,1.37035E-05]],[[0,0,0],[1,0,0,0]]];
        
        !Parametros de inicio
        !Camas
        contadorCama  := GInput (REM_CAMA_INICIAL);                              !Recibe cama por la cual iniciar el paletizado.
        SetGO ABB_CONTADOR_CAMAS, contadorCama;                                  !Enviar retroalimentacion a PLC.
        camaTotales  := GInput (REM_CAMA_TOTALES);                               !Total de camas.
        
        !Cajas
        contadorCaja  := GInput (REM_PRODUCTO_INICIAL);                          !Corresponde a la caja por la cual iniciara el paletizado. 
        SetGO ABB_CONTADOR_PRODUCTO, contadorCaja;                               !Enviar retroalimentacion a PLC.
        cajasTotales := GInput (REM_PRODUCTO_TOTALES_POR_CAMA);                  !Corresponde a las cajas totales por CAMA.
                                                            
        ToolActual := BoxUp;
        alturaTomar := altoCaja; 
         
        PosicionCarton{1} := GInput (REM_CAMA_CARTON_1);
        PosicionCarton{2} := GInput (REM_CAMA_CARTON_2);
        PosicionCarton{3} := GInput (REM_CAMA_CARTON_3);
        PosicionCarton{4} := GInput (REM_CAMA_CARTON_4);
        PosicionCarton{5} := GInput (REM_CAMA_CARTON_5);
        PosicionCarton{6} := GInput (REM_CAMA_CARTON_6);
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
        velConPeso := velBase * (cargaMax - (toolActual.tload.mass + pesoCaja)) / (cargaMax - toolActual.tload.mass);                 !Calcula la nueva velocidad a utilizar con peso, toma en cuenta peso de herramienta, peso de caja y capacidad del robot. -Principalmente para movimientos con caja-
        VSC := [velBase, 500, 5000, 1000];   ! Velocidad sin caja.                                                          !Actualiza velocidad sin caja
        VCC := [velConPeso, 500, 5000, 1000]; !Velocidad con caja.                                                          !Actualiza velocidad con caja
        
        !Mostrar en FlexPendant las nuevas velocidades.
        txtCajaConPeso := "Velocidad con caja actualizada= " + ValToStr(velConPeso) + " m/s";
        txtCajaSinPeso := "Velocidad sin caja actualizada= " + ValToStr(velBase) + " m/s";
        TPWrite txtCajaConPeso;
        TPWrite txtCajaSinPeso;
        !TPWrite "Velocidad con caja actualizada= "\Num:=velConPeso; QUITAR CUANDO SE PRUEBE ValToStr 
        !TPWrite "Velocidad sin caja actualizada= "\Num:=velBase; QUITAR CUANDO SE PRUEBE ValToStr 
    ENDPROC
    
    PROC PonerCarton()        
        IF contadorCama = PosicionCarton{contadorCama} THEN
            IF wobjPr = WobjOrientacionCamaImpar THEN
                PonerCartonIzquierda;
            ELSEIF wobjPr = IzquierdawobjCamaImpar THEN
                PonerCartonDerecha;
            ENDIF
        ELSEIF contadorCama <> PosicionCarton{contadorCama} THEN
            TPWrite "Cama sin carton";
        ENDIF
    ENDPROC
    
    PROC PonerCartonIzquierda()
        IF alturaActual < 818.13 THEN
            MoveJ Offs(home, 0, 0, 0), VIC, zSin, ToolActual, \WObj:= wobj0;
            MoveJ salidaCarton,  VIC, zSin, ToolActual, \WObj:=wobjMesaCarton;
            MoveL llegadaCarton, VIC, zSin, ToolActual, \WObj:=wobjMesaCarton;
            MoveL tomarCarton,   VBC, zSin, ToolActual, \WObj:=wobjMesaCarton;
            !(Hasta que sensor detecte que ya agarro carton)
            MoveL llegadaCarton,  VIC, zSin, ToolActual, \WObj:=wobjMesaCarton;
            MoveL salidaCarton,  VIC, zSin, ToolActual, \WObj:=wobjMesaCarton;
            MoveJ Offs(home, 0, 0, 0), VSC, zSin, ToolActual, \WObj:= wobj0;
            DejarCarton;
        ELSEIF alturaActual > 818.13 THEN
            MoveJ Offs(home, 0, 0, alturaActual + 400), VIC, zSin, ToolActual, \WObj:= wobj0;
            MoveJ Offs(salidaCarton, 0, 0, alturaActual + 400),  VIC, zSin, ToolActual, \WObj:= wobjMesaCarton;
            MoveL Offs(llegadaCarton, 0, 0, alturaActual + 400), VIC, zSin, ToolActual, \WObj:= wobjMesaCarton;
            MoveL tomarCarton, VBC, zSin, ToolActual, \WObj:=wobjMesaCarton;
            !(Hasta que sensor detecte que ya agarro carton)
            MoveL Offs(llegadaCarton, 0, 0, alturaActual + 400),  VIC, zSin, ToolActual, \WObj:= wobjMesaCarton;
            MoveJ Offs(salidaCarton, 0, 0, alturaActual + 400),  VIC, zSin, ToolActual, \WObj:= wobjMesaCarton;
            MoveJ Offs(home, 0, 0, alturaActual + 400), VIC, zSin, ToolActual, \WObj:= wobj0;
            DejarCarton;
        ENDIF          
    ENDPROC
    
    PROC PonerCartonDerecha()
         IF alturaActual < 818.13 THEN
            MoveJ Offs(home, 0, 0, 0), VSC, zSin, ToolActual, \WObj:= wobj0;
            MoveJ salidaCarton,  VSC, zSin, ToolActual, \WObj:=wobjMesaCarton;
            MoveL llegadaCarton, VSC, zSin, ToolActual, \WObj:=wobjMesaCarton;
            MoveL tomarCarton,   VSC, zSin, ToolActual, \WObj:=wobjMesaCarton;
            !(Hasta que sensor detecte que ya agarro carton)
            MoveL salidaCarton,  VSC, zSin, ToolActual, \WObj:=wobjMesaCarton;
            MoveL salidaCarton,  VSC, zSin, ToolActual, \WObj:=wobjMesaCarton;
            !MoveJ Offs(home, 0, 0, 0), VSC, zSin, ToolActual, \WObj:= wobj0;
            DejarCarton;
        ELSEIF alturaActual > 818.13 THEN
            MoveJ Offs(home, 0, 0, alturaActual + 400), VSC, zSin, ToolActual, \WObj:= wobj0;
            MoveJ Offs(salidaCarton, 0, 0, alturaActual + 400),  VSC, zSin, ToolActual, \WObj:= wobjMesaCarton;
            MoveL Offs(llegadaCarton, 0, 0, alturaActual + 400), VSC, zSin, ToolActual, \WObj:= wobjMesaCarton;
            MoveL tomarCarton, VSC, zSin, ToolActual, \WObj:=wobjMesaCarton;
            !(Hasta que sensor detecte que ya agarro carton)
            MoveL Offs(salidaCarton, 0, 0, alturaActual + 400),  VSC, zSin, ToolActual, \WObj:= wobjMesaCarton;
            MoveJ Offs(salidaCarton, 0, 0, alturaActual + 400),  VSC, zSin, ToolActual, \WObj:= wobjMesaCarton;
            DejarCarton;
            !MoveJ Offs(home, 0, 0, alturaActual + 400), VSC, zSin, ToolActual, \WObj:= wobj0;
        ENDIF         
    ENDPROC
    
    PROC DejarCarton()
        MoveL Offs(robDejarCarton, largoTarima/2, anchoTarima/2, alturaActual + 400), VSC, zSin, ToolActual, \WObj:= wobPr;
        MoveL Offs(robDejarCarton, largoTarima/2, anchoTarima/2, zDejar), VSC, zSin, ToolActual, \WObj:= wobPr;
        !Desactivar vacio
        MoveL Offs(robDejarCarton, largoTarima/2, anchoTarima/2, alturaActual + 400), VSC, zSin, ToolActual, \WObj:= wobPr;
    ENDPROC
      
    PROC TomarCaja()
        !Recibe coordenadas en "x" y "y" de PLC para tomar cajas.
        xConveyor := GInput(REM_X_BANDA); 
        yConveyor := GInput(REM_Y_BANDA); 
        
        !Movimientos de entrada y salida dependiendo alturas de paletizado.
        MoveJ Offs(agarrar, xConveyor, yConveyor, alturaTomar + 400), VSC, zSin, ToolActual, \WObj:= wobjConveyor; 
        MoveL Offs(agarrar, xConveyor, yConveyor, alturaTomar + alturaActual + 100), VSC, zSin, ToolActual, \WObj:= wobjConveyor;                                             
        MovimientosAgarrar;     
        MoveL Offs(agarrar, xConveyor, yConveyor, alturaTomar + alturaActual + 400), VSC, zSin, ToolActual, \WObj:= wobjConveyor;
        WaitRob\ZeroSpeed;
        !Mandar señal a PLC de tomado de caja
    ENDPROC
    
    PROC MovimientosAgarrar()                                                                                                            !Movimientos que corresponden a tomar las cajas y activacion de señales.
        MoveL Offs(agarrar, xConveyor, yConveyor, alturaTomar), VSC, zSin, ToolActual, \WObj:= wobjConveyor; 
        WaitRob \ZeroSpeed;
        !SetGO ABB_INT_ESTADO_VACIO, 3;
        WaitTime 2;
    ENDPROC
    
    PROC CalcularAlturas()
        alturaTotalPallet := (altoCaja*camaTotales) + altoTarima;                                                                                                           !Calcula la altura total del pallet, es decir, altura que tendra el pallet cuando termine las camas totales.
        !zDejar := (altoCaja*contadorCama) + altoTarima;                                                                                                                     !Calcula la Z del paletizado todo momento.                                                                                                                
        tercio1 := alturaTotalPallet / 3;                                                                                                                                   !Se divide el total del pallet en 3 para los calculos de salida
        tercio2 := tercio1 * 2;                                                                                                                                             !Tercio 1 corresponde a primera parte del pallet. Tercio 2 a la segunda y Tercio 3 a la parte mas alta del
        tercio3 := tercio1 * 3;                                                                                                                                             !..pallet                            
    ENDPROC
    
    PROC Paletizar()
        IF contadorCaja <= cajasTotales THEN                                                                                                                    !Siempre que la caja actual sea menor a la cajas totales por cama seguir paletizando.
            CalcularAlturas;                                                                                                                                    !Se calculan las alturas, principalmente zDejar para las posiciones de dejada.
            LeerPosiciones;                         !Lee las posiciones "x" y "y" para el dejado de la caja.
            SeleccionGiro;                          !Selecciona el giro de la posicion.
            SeleccionOrientacionCama;
            MovimientosDejar;                       !Hace movimientos para dejar la caja.
            WaitRob\inpos;                          !Espera que el robot este en la posicion antes de mandar cualquier retro a PLC, para evitar desincronizacion.
            IF contadorCaja >= cajasTotales THEN    !Si el contador de caja es igual a las cajas totales quiere decir que ya termino la cama.
                WaitRob\inpos;
                Incr contadorCama;                  !Se incrementa contador de cama.
                TOMAR := 1;
                contadorCaja  := GInput (REM_PRODUCTO_INICIAL); !Se da retro del incremento de cama.
                alturaActual := altoTarima + altoCaja * contadorCama; !Se calcula la altura actual 
            ELSE
                Incr contadorCaja;
            ENDIF
        ENDIF
    ENDPROC
    
    PROC LeerPosiciones()
        SetGO ABB_CONTADOR_CAMAS, contadorCama;
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
    
    PROC SeleccionOrientacionCama()
!        IF pallet = 0 THEN
!            wobjPr := WobjOrientacionCamaImpar;
!        ELSEIF pallet = 1 THEN
!            wobjPr := IzquierdawobjCamaImpar;
!        ENDIF
        
         wobjPr := IzquierdawobjCamaImpar;
    ENDPROC
    
    PROC MovimientosDejar()
       LeerPosiciones; !PROBANDO SIN LEER ANTES DE DEJAR
       MoveL Offs(dejar, posX, posY, 250 + zDejar), VCC, zCon, ToolActual, \WObj:= wobjPr;
       MoveL Offs(dejar, posX, posY, zDejar), VCC, zCon, ToolActual, \WObj:= wobjPr;
       WaitRob \ZeroSpeed;
       !SetGO ABB_INT_ESTADO_VACIO, 0;
       WaitTime 1.5;
       MoveL Offs(dejar, posX, posY, zDejar + 250), VSC, zSin, ToolActual, \WObj:= wobjPr;
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
        TOMAR := 1;
    ENDPROC
    
    PROC FinalizarPaletizado()
        MoveJ home, VSC, zSin, ToolActual, \WObj:= wobj0;
        !Avisar a PLC que termino proceso de paletizado (izquierda o derecha)
        ReiniciarVariables;
    ENDPROC
ENDMODULE