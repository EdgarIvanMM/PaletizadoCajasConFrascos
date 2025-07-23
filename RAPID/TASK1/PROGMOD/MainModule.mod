MODULE MainModule
    PERS wobjdata wobjPr; !Wobj utilizado en tarima. WobjPallet
    PERS wobjdata WobjOrientacionCamaPar:= [FALSE, TRUE, "", [[612, -650, -825.93], [5.37631E-05,-3.57543E-05,-8.801E-05,-1]],[[0,0,0],[1,0,0,0]]];
    PERS wobjdata WobjOrientacionCamaImpar := [FALSE, TRUE, "", [[490, -1850, -670], [1,-5.99539E-06,-9.11397E-07,1.37035E-05]], [[0,0,0],[1,0,0,0]]]; !No gira, mantiene la orientacion normal.

    !TOOLDATA                                                                                                                                                                    
    PERS tooldata BoxUp:=[TRUE,[[0,0,630],[1,0,0,0]],[28.7,[6.3,-16.5,263.1],[1,0,0,0],3.887,2.517,1.945]];
    TASK PERS tooldata BoxUpVentosas:=[TRUE,[[0,0,630],[1,0,0,0]],[29.9,[4.9,-16.3,301.3],[1,0,0,0],6.163,4.176,2.427]];

    PERS tooldata BoxUpPar := [TRUE, [[0,0,630],[0,0,1,0]], [28.7, [6.3,-16.5,263.1], [0,0,1,0], 3.887, 2.517, 1.945]];
    TASK PERS tooldata BoxUpVentosasPar:=[TRUE,[[0,0,630],[1,0,0,0]],[29.9,[4.9,-16.3,301.3],[1,0,0,0],6.163,4.176,2.427]];
    
    PERS tooldata ToolActual;                                                                                                                                                    
                                                                                                                                                                                                                                                                                                                                           
    !en uso                                                                                                                                                                      
	CONST robtarget home:=[[767.82,13.97,1095.99],[0.010881,0.00170795,0.999899,0.00902226],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];                                    
    CONST robtarget home1:=[[1329.53,-19.92,818.13],[0.0137739,-0.6962,0.717715,-0.000665094],[-1,0,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    !CONST robtarget home1:=[[1329.53,-19.92,818.13],[0.00105563,0.713772,0.700238,0.0139541],[-1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]; 18 JULIO 2025
    CONST robtarget acercarAgarrar:=[[1231.28,-19.91,53.41],[0.00109975,0.713763,0.700247,0.0139874],[-1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];                          
    CONST robtarget agarrar:=[[1092.98,7.46,-97.49],[0.000384615,0.704569,-0.709632,-0.00226901],[0,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    !CONST robtarget agarrar:=[[1329.57,-19.92,-233.52],[0.0010381,0.713778,0.700233,0.0139392],[-1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]; 18 JULIO 2025
    
    
    VAR robtarget dejar:=[[0,0,0],[0.000302394,0.00698494,-0.999976,-0.000184941],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    !VAR robtarget dejarVertical:=[[0,0,0],[0.000807693,0.7168,0.697143,0.013762],[0,0,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]; SE USARON PRIMERA VERSION 21-JULIO-25
    !VAR robtarget dejarHorizontal:=[[0,0,0],[0.0104383,0.00174317,0.999903,0.00903741],[0,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];  SE USARON PRIMERA VERSION 21-JULIO-25
    
    VAR robtarget dejarVertical:=[[0,0,0],[0.0137939,-0.703933,0.710132,-0.0007531],[-1,0,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    VAR robtarget dejarHorizontal:=[[0,0,0],[0.0104383,0.00174317,0.999903,0.00903741],[0,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]; 
    
    !prueba
    CONST robtarget prueba := [[218.94,159.17,193.84],[0.0137939,-0.703933,0.710132,-0.0007531],[-1,0,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget p20    := [[169.02,14.01,255.24],[0.000807693,0.7168,0.697143,0.013762],[0,0,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]; !DEJAR VERTICAL.
    CONST robtarget p10    := [[169.09,14.01,255.31],[0.0104383,0.00174317,0.999903,0.00903741],[0,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];  
    
    !Configuraciones de velocidad y z de los movimientos.
    VAR num velBase := 0;  !Velocidad tope maxima que hara el robot.
    VAR num velConPeso := 0;
    VAR speeddata VSC:=[1000, 500, 5000, 1000];   ! Velocidad sin caja.
    VAR speeddata VCC:=[1000, 500, 5000, 1000];   ! Velocidad con caja.
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
    
    TASK PERS wobjdata wobjImpar:=[FALSE,TRUE,"",[[1051.05,-429.223,-565.796],[1,-5.99539E-06,-9.11397E-07,1.37035E-05]],[[0,0,0],[1,0,0,0]]];
    TASK PERS wobjdata wobjPar:=[FALSE,TRUE,"",[[1898.64,255.881,-602.644],[5.37631E-05,-3.57543E-05,-8.801E-05,-1]],[[0,0,0],[1,0,0,0]]];
    
    TASK PERS wobjdata IzquierdawobjCamaImpar:=[FALSE,TRUE,"",[[-490,1852,-825.93],[1, -5.99539E-06, -9.11397E-07, 1.37035E-05]],[[0, 0, 0],[1, 0, 0, 0]]];
    TASK PERS wobjdata IzquierdawobjCamaPar:=[FALSE,TRUE,"",[[-368,650,-825.93],[5.37631E-05,-3.57543E-05,-8.801E-05,-1]],[[0,0,0],[1,0,0,0]]];
    CONST robtarget p30:=[[1304.18,659.07,-37.16],[0.0219537,-0.706848,-0.706236,-0.0333851],[0,0,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget p40:=[[1305.67,106.84,686.43],[0.0219522,-0.706853,-0.706232,-0.0333645],[0,0,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    
!------------------------------------------------------------------------
                                                                         !------------------------------------------------------------------------
    PROC Main()
        ReiniciarVariables;
        LeerParametros;                                                           !Obtiene parametros desde PLC.
        !ActualizarParametros;                                                    !Actualiza parametros de velocidad y carga dependiendo dimensiones y peso de caja.
        MoveJ Home1, VSC, zSin, ToolActual, \WObj:= wobj0;
        WHILE contadorCama <= camaTotales DO
            IF TOMAR = 1 THEN
            TomarCaja;
            ENDIF
            Paletizar;
        ENDWHILE
        FinalizarPaletizado;                                                     !Reinicia variables y manda a home.
        <SMT>
	ENDPROC
    
    PROC LeerParametros()
        !Parametros de caja.
        anchoCaja := GInput (REM_PRODUCTO_DIMENSION_Y);!/10;                               
        largoCaja := GInput (REM_PRODUCTO_DIMENSION_X);!/10;                               
        altoCaja  := GInput (REM_PRODUCTO_DIMENSION_Z);!/10;
        pesoCaja  := GInput (REM_PRODUCTO_PESO);
        
        !Parametros de tarima.
        anchoTarima := GInput (REM_TARIMA_DIMENSION_Y)/10;                             
        largoTarima := GInput (REM_TARIMA_DIMENSION_X)/10;                       
        altoTarima  := GInput (REM_TARIMA_DIMENSION_Z)/10; 
        
        !490 = Distancia base de robot a tarima en X,      !650= distancia base de robot a tarima en Y,            -834=Distancia entre base del robot y piso.
        WobjOrientacionCamaPar   := [FALSE, TRUE, "", [[490 + largoTarima, -650, altoTarima - 834.93], [5.37631E-05,-3.57543E-05,-8.801E-05,-1]],[[0,0,0],[1,0,0,0]]];  
        WobjOrientacionCamaImpar := [FALSE,TRUE,"",[[490 , -1850 , -670],[1,-5.99539E-06,-9.11397E-07,1.37035E-05]],[[0,0,0],[1,0,0,0]]];
        
        IzquierdawobjCamaPar   := [FALSE, TRUE, "", [[-490 + largoTarima, 650, altoTarima - 834.93], [5.37631E-05,-3.57543E-05,-8.801E-05,-1]],[[0,0,0],[1,0,0,0]]];
        IzquierdawobjCamaImpar := [FALSE,TRUE,"",[[-490 , 1750 + anchoTarima , altoTarima  - 834.93],[1,-5.99539E-06,-9.11397E-07,1.37035E-05]],[[0,0,0],[1,0,0,0]]];
        
        !Parametros de inicio
        contadorCama  := GInput (REM_CAMA_INICIAL);                              !Recibe cama por la cual iniciar el paletizado.
        SetGO ABB_CONTADOR_CAMAS, contadorCama;                                  !Enviar retroalimentacion a PLC.
        camaTotales  := GInput (REM_CAMA_TOTALES);                               !Total de camas.
        
        contadorCaja  := GInput (REM_PRODUCTO_INICIAL);                          !Corresponde a la caja por la cual iniciara el paletizado. 
        SetGO ABB_CONTADOR_PRODUCTO, contadorCaja;                               !Enviar retroalimentacion a PLC.
        cajasTotales := GInput (REM_PRODUCTO_TOTALES_POR_CAMA);                  !Corresponde a las cajas totales por CAMA.
        
        !tool := GInput (REM_TOOL);                                               !Obtenemos la herramienta en uso (con ventosas o sin ventosas)
        IF REM_TOOL = 0 THEN                                                     !Cuando recibimos 0, se activara la herramienta SIN ventosas
            ToolActual := BoxUp;
        ELSEIF REM_TOOL = 1 THEN                                                 !Cuando recibimos 1, se activara la herramienta CON ventosas
            ToolActual := BoxUpVentosas;
        ENDIF
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
      
    PROC TomarCaja()                                                                                                           
        TEST alturaActual <= alturaTotalPallet                                                                                       
            CASE alturaActual <= tercio1:                                                                                                 !--TEST que evalua la altura actual, dependiendo la altura, sube al tercio correspondiente
            MoveJ Offs(agarrar, 0, 0, tercio1 + 200), VSC, zSin, ToolActual, \WObj:= wobj0;                                             !..del pallet completo. Se cambia la Z del offset con la variable del tercio correspondiente.
            MoveL Offs(agarrar, 0, 0, tercio1 + 100), VSC, zSin, ToolActual, \WObj:= wobj0; 
            !WaitDI REM_BOOL_GARRA_ABIERTA, 1; !Esperar confirmacion que garra este abierta
            MovimientosAgarrar;                                                                                                           !IMPORTANTE, no se estan evaluando rangos de tamaño del pallet, se evaluan solo los booleanos
            !WaitDI REM_BOOL_GARRA_CERRADA, 1; !Esperar confirmacion que garra esta cerrada
            MoveL Offs(agarrar, 0, 0, tercio1 + 400), VCC, zCon, ToolActual, \WObj:= wobj0;                                             !.. de cada caso.--            
            
            CASE alturaActual <= tercio2:
            MoveJ Offs(agarrar, 0, 0, tercio2 + 200), VSC, zSin, ToolActual, \WObj:= wobj0;
            MoveL Offs(agarrar, 0, 0, tercio1 + 100), VSC, zSin, ToolActual, \WObj:= wobj0;
            !WaitDI REM_BOOL_GARRA_ABIERTA, 1; !Esperar confirmacion que garra este abierta
            MovimientosAgarrar;                                                                                                           !IMPORTANTE, no se estan evaluando rangos de tamaño del pallet, se evaluan solo los booleanos
            !WaitDI REM_BOOL_GARRA_CERRADA, 1; !Esperar confirmacion que garra esta cerrada
            MoveL Offs(agarrar, 0, 0, tercio2 + 200), VCC, zCon, ToolActual, \WObj:= wobj0;
            
            CASE alturaActual <=tercio3:
            MoveJ Offs(agarrar, 0, 0, tercio3 + 200), VSC, zSin, ToolActual, \WObj:= wobj0;
            MoveL Offs(agarrar, 0, 0, tercio1 + 100), VSC, zSin, ToolActual, \WObj:= wobj0;
            !WaitDI REM_BOOL_GARRA_ABIERTA, 1; !Esperar confirmacion que garra este abierta
            MovimientosAgarrar;                                                                                                           !IMPORTANTE, no se estan evaluando rangos de tamaño del pallet, se evaluan solo los booleanos
            !WaitDI REM_BOOL_GARRA_CERRADA, 1; !Esperar confirmacion que garra esta cerrada
            MoveL Offs(agarrar, 0, 0, tercio3 + 200), VCC, zCon, ToolActual, \WObj:= wobj0;
        ENDTEST
    ENDPROC
    
    PROC MovimientosAgarrar()                                                                                                            !Movimientos que corresponden a tomar las cajas y activacion de señales.
        MoveL agarrar, VSC, zSin, ToolActual, \WObj:= wobj0;
        WaitRob \ZeroSpeed;
        SetGO ABB_INT_ESTADO_VACIO, 3;
        WaitTime 2;
    ENDPROC
    
    PROC CalcularAlturas()
        alturaTotalPallet := (altoCaja*camaTotales) + altoTarima;                                                                                                           !Calcula la altura total del pallet, es decir, altura que tendra el pallet cuando termine las camas totales.
        zDejar := (altoCaja*contadorCama) + altoTarima;                                                                                                                     !Calcula la Z del paletizado todo momento.                                                                                                                
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
            Moverse;                                !Hace movimientos para dejar la caja.
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
!        IF contadorCama MOD 2 = 0 THEN !Cuando la cama es par
!            wobjPr := WobjOrientacionCamaPar;
!           !ToolActual := BoxUpPar;
!        ELSEIF contadorCama MOD 2 > 0 THEN !Cuando la cama es impar
            wobjPr := WobjOrientacionCamaImpar;
!        ENDIF 
        
!       TEST pallet 
!        CASE 1: IF contadorCama MOD 2 = 0 THEN !Cuando la cama es par
!                wobjPr := WobjOrientacionCamaPar;
!                ELSEIF contadorCama MOD 2 > 0 THEN !Cuando la cama es impar
!                wobjPr := WobjOrientacionCamaImpar;
!                ENDIF
!        CASE 0: IF contadorCama MOD 2 = 0 THEN !Cuando la cama es par
!                wobjPr := IzquierdawobjCamaPar;
!                ELSEIF contadorCama MOD 2 > 0 THEN !Cuando la cama es impar
!                wobjPr := IzquierdawobjCamaImpar;
!                ENDIF
!        ENDTEST
    ENDPROC
    
    PROC Moverse()
       LeerPosiciones; !PROBANDO SIN LEER ANTES DE DEJAR
       MoveL Offs(dejar, posX, posY, zDejar + 250), VCC, zCon, ToolActual, \WObj:= wobjPr;
       MoveL Offs(dejar, posX, posY, zDejar), VCC, zCon, ToolActual, \WObj:= wobjPr;
       WaitRob \ZeroSpeed;
       !WaitDI REM_BOOL_GARRA_CERRADA, 1; !Esperar confirmacion que garra esta cerrada
       IF giro = 1 THEN 
       SetGO ABB_INT_ESTADO_VACIO, 0;
       ELSEIF giro = 0 THEN
           SetGO ABB_INT_ESTADO_VACIO, 1;
       ENDIF
       WaitTime 1.5;
       !WaitDI REM_BOOL_GARRA_ABIERTA, 1; !Esperar confirmacion que garra esta abierta
       MoveL Offs(dejar, posX, posY, zDejar + 250), VSC, zSin, ToolActual, \WObj:= wobjPr;
       IF ABB_INT_ESTADO_VACIO <> 0 THEN
           TOMAR := 0;
       ELSE
           TOMAR := 1;
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
        SetGO ABB_INT_ESTADO_VACIO, 0;
        TOMAR := 1;
        
        
        !Reinicio de Wobj
        WobjOrientacionCamaPar   := [FALSE, TRUE, "", [[0, 0, 0], [0,0,1,0]], [[0,0,0],[1,0,0,0]]];
        WobjOrientacionCamaImpar := [FALSE,TRUE,"",[[0 , 0, 0],[1,0,0,0]],[[0,0,0],[1,0,0,0]]];
    ENDPROC
    
    PROC FinalizarPaletizado()
        MoveJ Home1, VSC, zSin, ToolActual, \WObj:= wobj0;
        ReiniciarVariables;
    ENDPROC
    
    PROC pruebaing()
        MoveL p30, V2000, fine, BoxUp, \WObj:= wobj0;
        MoveL p40, V2000, fine, BoxUp, \WObj:= wobj0;
    ENDPROC
    
    
ENDMODULE