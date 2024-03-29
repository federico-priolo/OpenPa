000010  INIZIO-WEB.
000020
000030		 PERFORM START-WEB		THRU EX-START-WEB.
000040
000050		 COPY "INIZIALI.CBL".
000060
000070  EX-INIZIO-WEB.
000080         EXIT.
000090
000100  START-WEB.
000110
000120
000130		 MOVE LOW-VALUE			 TO COBW3.
000140		
000150       CALL  "COBW3_INIT"      USING  COBW3 .
000160
000170* SET the CONTENT-TYPE to HTML
000180        SET COBW3-CONTENT-TYPE-HTML TO TRUE .
000190
000200* COMMENTARE PER DISATTIVARE IL DEBUG NATIVO
000210*       MOVE "1"             TO COBW3-DMODE.
000230
000240  EX-START-WEB.
000250		   EXIT.
000260
000270
000280  FINE-WEB.
000290
000300         CALL  "COBW3_FREE"       USING  COBW3 .
000310
000320  EX-FINE-WEB.
000330         EXIT.
000340
000350
000360  VIS-MESS.
000370
000380          MOVE MESSAGGIO      TO VALUE-WEB.
000390          MOVE "MK-MESSAGE"   TO FIELD-WEB.
000400          PERFORM METTI-WEB   THRU EX-METTI-WEB.
000410
000420          MOVE "SEGNALAZIONE" TO VALUE-WEB.
000430          MOVE "MK-TITLE"     TO FIELD-WEB.
000440          PERFORM METTI-WEB   THRU EX-METTI-WEB.
000450
000460          MOVE SECTION-WEB    TO VALUE-WEB.
000470          MOVE "MK-KEY"       TO FIELD-WEB.
000480          PERFORM METTI-WEB   THRU EX-METTI-WEB.
000490
000500
000510			MOVE "GOBACK"		TO NOME-VIEW.
000520			PERFORM LEGGO-VIEW	THRU EX-LEGGO-VIEW.
000530			IF ESITO-NOK MOVE SPACES TO STRINGA-VIEW.
000540
000550          MOVE STRINGA-VIEW   TO VALUE-WEB.
000560          MOVE "MK-BACK"      TO FIELD-WEB.
000570          PERFORM METTI-WEB   THRU EX-METTI-WEB.
000580
000590          MOVE "TEMPLATE/MESSAGE.HTM"  TO PAGE-WEB.
000600          PERFORM SHOW-WEB    THRU EX-SHOW-WEB.
000610          MOVE SPACES         TO MESSAGGIO.
000620
000630  EX-VIS-MESS.
000640          EXIT.
000650

000550  VIS-MENU.
000560
000570          MOVE MESSAGGIO      TO VALUE-WEB.
000580          MOVE "MK-MESSAGE"   TO FIELD-WEB.
000590          PERFORM METTI-WEB   THRU EX-METTI-WEB.
000600
000610          MOVE "SEGNALAZIONE" TO VALUE-WEB.
000620          MOVE "MK-TITLE"     TO FIELD-WEB.
000630          PERFORM METTI-WEB   THRU EX-METTI-WEB.
000640
000650          MOVE SECTION-WEB    TO VALUE-WEB.
000660          MOVE "MK-KEY"       TO FIELD-WEB.
000670          PERFORM METTI-WEB   THRU EX-METTI-WEB.

000870          MOVE PATH-WEB       TO VALUE-WEB.
000880          MOVE "MK-PATH"      TO FIELD-WEB.
000890          PERFORM METTI-WEB   THRU EX-METTI-WEB.

000680
000690
000700          MOVE "TEMPLATE/GOMENU.HTM"  TO PAGE-WEB.
000710          PERFORM SHOW-WEB    THRU EX-SHOW-WEB.
000720
000730  EX-VIS-MENU.
000740          EXIT.
000860
00087   VIS-LOGIN.
000770
000780          move spaces to messaggio
000790
000800          string "Utente non presente o sessione di lavoro"
000810           " scaduta  - e' necessario effettuare "
000820           " la login" DELIMITED BY SIZE INTO messaggio
000830          MOVE MESSAGGIO      TO VALUE-WEB.
000840          MOVE "MK-MESSAGE"   TO FIELD-WEB.
000850          PERFORM METTI-WEB   THRU EX-METTI-WEB.
000860
000870          MOVE "SEGNALAZIONE" TO VALUE-WEB.
000880          MOVE "MK-TITLE"     TO FIELD-WEB.
000890          PERFORM METTI-WEB   THRU EX-METTI-WEB.
000900
000870          MOVE PATH-WEB       TO VALUE-WEB.
000880          MOVE "MK-PATH"      TO FIELD-WEB.
000890          PERFORM METTI-WEB   THRU EX-METTI-WEB.
000900	
000930          MOVE "TEMPLATE/GOLOGIN.HTM"    TO PAGE-WEB.
000940          PERFORM SHOW-WEB    THRU EX-SHOW-WEB.
000950
000960  EX-VIS-LOGIN.
000970
001080          EXIT.
001090
001100
001110  METTI-WEB.
001120
001130          MOVE FIELD-WEB    TO COBW3-CNV-NAME.
001140          MOVE VALUE-WEB    TO COBW3-CNV-VALUE.
001150          MOVE ZEROS        TO COBW3-CNV-NAME-LENGTH.
001160          MOVE ZEROS        TO COBW3-CNV-VALUE-LENGTH.
001170          CALL "COBW3_CNV_SET" USING COBW3.
001180          MOVE SPACES       TO COBW3-CNV-VALUE.
001190
001200  EX-METTI-WEB.
001210          EXIT.
001220
001230
001240  SHOW-WEB.
001250
001260          MOVE PAGE-WEB     TO COBW3-HTML-FILENAME.
001270          CALL "COBW3_PUT_HTML" USING COBW3.
001280
001290  EX-SHOW-WEB.
001300          EXIT.
001310
001320  LINE-WEB.
001330
001340          IF DATI-WEB > SPACES
001350          MOVE DATI-WEB       TO     COBW3-PUT-STRING
001360          MOVE ZEROS          TO     COBW3-PUT-STRING-LENGTH
001370          CALL  "COBW3_PUT_TEXT"   USING  COBW3
001380
001390          MOVE SPACES             TO DATI-WEB.
001400
001410  EX-LINE-WEB.
001420          EXIT.
001430
001440
001450  READ-WEB.
001460
001470        IF INDEX-WEB NOT > 1
001480          MOVE 1          TO  COBW3-NUMBER
001490         ELSE
001500          MOVE INDEX-WEB TO  COBW3-NUMBER.
001510
001520        move SPACES      TO VALUE-WEB.
001530
001540        MOVE FIELD-WEB   TO  COBW3-SEARCH-DATA
001550        CALL "COBW3_NAME" USING COBW3
001560
001570        IF  COBW3-SEARCH-FLAG-EXIST
001580		   AND COBW3-GET-LENGTH  > zeros
001590         MOVE COBW3-GET-DATA (1:COBW3-GET-LENGTH) TO VALUE-WEB.
001600
001610        IF  COBW3-SEARCH-FLAG-EXIST
001620         SET ON-WEB TO TRUE
001630         ELSE
001640         SET OFF-WEB TO TRUE.
001650
001660         IF VALUE-WEB(1:2) NUMERIC
001670          AND VALUE-WEB(3:1) = "/"
001680           AND VALUE-WEB(4:2) NUMERIC
001690            AND VALUE-WEB(6:1) = "/"
001700             AND VALUE-WEB(7:4) NUMERIC
001710
001720             MOVE VALUE-WEB(1:2) TO GG-WEB
001730             MOVE VALUE-WEB(4:2) TO MM-WEB
001740             MOVE VALUE-WEB(7:4) TO AA-WEB
001750              ELSE
001760              INITIALIZE DATA-WEB.
001770
001780
001790          PERFORM ALFA-TO-NUM-WEB THRU EX-ALFA-TO-NUM-WEB.
001800
001810
001820  EX-READ-WEB.
001830          EXIT.
001840
001850  MAKE-WEB.
001860
001870
001880          CALL "MAKEFORM" USING COBW3
001890          CANCEL "MAKEFORM".
001900
001910
001920			MOVE FILE-WEB			TO STRINGA-VIEW
001930			MOVE SPACES				TO NOME-VIEW
001940			STRING MODULO-WEB ENTITA-WEB FUNZIONE-WEB
001950				DELIMITED BY SIZE INTO NOME-VIEW
001960		 
001970			PERFORM SCRITTURA-VIEW  THRU EX-SCRITTURA-VIEW .
001980
001990			MOVE PAGE-WEB			TO STRINGA-VIEW.
002000			MOVE "MODULO"			TO NOME-VIEW.
002010			PERFORM LEGGO-VIEW		THRU EX-LEGGO-VIEW
002020			
002030			IF ESITO-NOK
002040			MOVE  MODULO-WEB 		TO STRINGA-VIEW
002050			PERFORM SCRITTURA-VIEW  THRU EX-SCRITTURA-VIEW .
002060
002070
002080
002090  EX-MAKE-WEB.
002100          EXIT.
002110
002120
002130  ESEGUI-WEB.
002140*
002150**** mettere il comando in COBW3-SYSTEMINFO.
002160*
002170          CALL "COBW3_SYSTEM" USING COBW3.
002180          MOVE SPACES       TO COBW3-SYSTEMINFO.
002190
002200			IF COBW3-STATUS = 1
002210			STRING "Errore esecuzione " COBW3-SYSTEMINFO
002220			 DELIMITED BY SIZE INTO MESSAGGIO
002230			  PERFORM VIS-MESS THRU EX-VIS-MESS.
002240
002250  EX-ESEGUI-WEB.
002260          EXIT.
002270
002280
002290  SHA-WEB.
002300
002310			MOVE SPACES TO COBW3-SYSTEMINFO.
002320
002330          STRING 'openSSL passwd -salt x ' DELIMITED BY SIZE
002340          FIELD-WEB DELIMITED BY "   "
002350          " > /temp/SHA" DELIMITED BY SIZE 
002360           SECTION-WEB ".log" 
002370            DELIMITED BY SIZE INTO COBW3-SYSTEMINFO.
002380			 
002390          PERFORM ESEGUI-WEB 	  THRU EX-ESEGUI-WEB.
002400
002410			CALL "SAVESHA3" USING SECTION-WEB
002420			 RETURNING VALUE-WEB.
002430
002440			CANCEL "SAVESHA3".
002450
002460
002470  EX-SHA-WEB.
002480			EXIT.
002490
002500  CALL-WEB.
002510
002520          CALL "POWEROPENSHEET" USING PROGRAMMA-WEB
002530                                      LIBRERIA-WEB
002540                          RETURNING RITORNO-WEB.
002550
002560
002570  EX-CALL-WEB.
002580          EXIT.
002590
002600
002610  ALFA-TO-NUM-WEB.
002620
002630          IF VALUE-WEB = SPACES 
002640            MOVE ZERO             TO NUMERO-WEB
002650             GO TO EX-ALFA-TO-NUM-WEB.
002660
002670          MOVE ALL ZEROS          TO TAB-NUMERO-WEB.
002680
002690          MOVE 18                 TO IND3-WEB
002700          PERFORM VARYING IND2-WEB FROM 18 BY -1 UNTIL IND2-WEB = ZERO
002710
002720          IF VALUE-WEB(IND2-WEB:1) NUMERIC
002730          MOVE  VALUE-WEB(IND2-WEB:1)   TO TAB-NUMERO-WEB(IND3-WEB:1)
002740          SUBTRACT 1 FROM IND3-WEB
002750          END-IF
002760
002770          END-PERFORM.
002780
002790          MOVE TAB-NUMERO-WEB     TO NUMERO-WEB.
002800
002810
002820  EX-ALFA-TO-NUM-WEB.
002830          EXIT.
002840
002850  FAI-NOME.
002860
002870          IF PATH-WEB = SPACE
002880          MOVE "FILES/FILES.TXT"  TO WDOVE
002890           ELSE
002900          MOVE SPACES             TO WDOVE                
002910          
002920          STRING PATH-WEB DELIMITED BY "  "
002930            "FILES.TXT" DELIMITED BY SIZE INTO WDOVE.
002940
002950          CALL "NOMIFILE" USING WDOVE WNOME
002960  	      RETURNING WFILE.
002970
002980	EX-FAI-NOME.
002990          EXIT.
