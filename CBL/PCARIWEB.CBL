000010
000020   CARICA-DATO-WEB.
000030
000040          MOVE SPACES             TO ARGUMENT.
000050          MOVE "N"                TO USE-ARGUMENT.
000060
000070          MOVE NOME-COBOL-DATO    TO FIELD-WEB.
000080
000090          PERFORM READ-WEB        THRU EX-READ-WEB.
000091
000092
000093
000100
000110          IF COBW3-SEARCH-FLAG-EXIST
000120
000122
000123			IF SIZE-DATO = 1
000124			 AND FUNCTION UPPER-CASE(VALUE-WEB) (1:1) = "O"
000125			 MOVE "S"				TO VALUE-WEB 
000126			END-IF
000127
000128
000129			IF SIZE-DATO = 8
000130			 AND TIPO-DATO = "D"
000131			 MOVE  VALUE-WEB(1:2)	TO GG-VIEW
000132			 MOVE  VALUE-WEB(4:2)	TO MM-VIEW
000133			 MOVE  VALUE-WEB(7:4)	TO AA-VIEW

                 IF DATA-VIEW NOT NUMERIC
                  INITIALIZE DATA-VIEW
                 END-IF
                 
000134			 MOVE DATA-VIEW			TO VALUE-WEB
000135			END-IF
000136
000137          MOVE VALUE-WEB          TO ARGUMENT
000145          MOVE "S"                TO USE-ARGUMENT
000146
000147			ELSE
000150			MOVE NOME-COBOL-DATO	TO NOME-VIEW
000160			PERFORM LEGGO-VIEW		THRU EX-LEGGO-VIEW
000170
000180			IF ESITO-OK
000190			 AND USA-DEFAULT-VIEW = "S"
000200           MOVE "S"               TO USE-ARGUMENT
000210           MOVE DEFAULT-VIEW		TO ARGUMENT.
000220           
000230           
000240          IF USE-ARGUMENT = "S"
000250          MOVE ALL "!"            TO LOGGATO
000260          
000270           MOVE SPACES            TO NUMERO-LOG
000280           
000290           IF TIPO-DATO = "9"
000300            MOVE ARGUMENT         TO TAB-STRINGA
000310            MOVE TAB-STRINGA      TO NUMERO-LOG
				  MOVE SIZE-DATO        TO SIZE-STRINGA
			
000320            CALL "ALFATONU" USING TAB-STRINGA SIZE-STRINGA
000330            MOVE TAB-STRINGA      TO ARGUMENT
000340           END-IF
000350          
000360           ACCEPT DATA-LOG       FROM DATE
000370            ACCEPT ORARIO-LOG     FROM TIME
000380            
000390           MOVE NOME-COBOL-DATO   TO NOME-COBOL-LOG
000400            MOVE TIPO-DATO        TO TIPO-LOG
000410            MOVE SIZE-DATO        TO SIZE-LOG
000420            MOVE ARGUMENT         TO VALORE-LOG
000430            WRITE LOGGATO
000440            MOVE SPACES           TO LOGGATO.
000450
000460
000470	 EX-CARICA-DATO-WEB.
000480			EXIT.
