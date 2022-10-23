000010*
000020* Copyright (C) 2010-2022 Federico Priolo TP ONE SRL federico.priolo@tp-one.it
000030*
000040* This program is free software; you can redistribute it and/or modify
000050* it under the terms of the GNU General Public License as published by
000060* the Free Software Foundation; either version 2, or (at your option)
000070* any later version.
000080*
000090* This program is distributed in the hope that it will be useful,
000100* but WITHOUT ANY WARRANTY; without even the implied warranty of
000110* MERCHANUTENILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
000120* GNU General Public License for more details.
000130*
000140* You should have received a copy of the GNU General Public License
000150* along with this software; see the file COPYING.  If not, write to
000160* the Free Software Foundation, 51 Franklin Street, Fifth Floor
000170* Boston, MA 02110-1301 USA
000180*
000190 IDENTIFICATION   DIVISION.
000200 PROGRAM-ID       OPENUTEN.
000210 ENVIRONMENT      DIVISION.
000220 CONFIGURATION    SECTION.
000230			COPY "SPECIAL.CBL".
000240 INPUT-OUTPUT     SECTION.
000250 FILE-CONTROL.
000260
000270          COPY "SELWEB.CBL".
000280          COPY "SELVIEW.CBL".
000290          COPY "SELUTEN.CBL".
000300			COPY "SELJSON.CBL".
000310      	COPY "SELTAB.CBL".
000320		
000330
000340
000350 DATA             DIVISION.
000360 FILE SECTION.
000370
000380			COPY "FDETAB.CBL".
000390          COPY "FDEWEB.CBL".
000400          COPY "FDEVIEW.CBL".
000410          COPY "FDEUTEN.CBL".
000420			COPY "FDEJSON.CBL".
000430
000440
000450 WORKING-STORAGE  SECTION.
000460
000470          COPY "COBW3.CBL".
000480          COPY "GLOBALS.CBL".
000490          COPY "IMAGES.CBL".
000500*
000510 PROCEDURE  DIVISION.
000520*
000530          PERFORM INIZIO-WEB   THRU EX-INIZIO-WEB.
000540
000550
000560                                             
000570
000580          PERFORM OPEN-I-UTEN  THRU EX-OPEN-I-UTEN.
000590
000600
000610			MOVE "abil"			to SIGLA-WEB.
000620			MOVE "03"			TO TIPO-WEB.
000630		    PERFORM GENERA-TAB  THRU EX-GENERA-TAB.
000640
000650          PERFORM LOAD-VIEW    THRU EX-LOAD-VIEW
000660
000670			STRING "UTENTI" ".HTM"
000680			DELIMITED BY SIZE  INTO PAGE-WEB.
000690
000700          PERFORM MAKE-WEB     THRU EX-MAKE-WEB.
000710
000720
000730 FINE.
000740          PERFORM CLOSE-VIEW   THRU EX-CLOSE-VIEW.
000750          PERFORM CLOSE-UTEN    THRU EX-CLOSE-UTEN.
000760
000770
000780
000790          PERFORM FINE-WEB     THRU EX-FINE-WEB.
000800
000810          GOBACK.
000820
000830			COPY "GENERATA.CBL".
000840          COPY "PIOWEB1.CBL".
000850          COPY "PIOVIEW.CBL".
000860			COPY "PIOJSON.CBL".
000870			COPY "PIOUTEN.CBL".
000880			COPY "PIOTAB.CBL".
000890 LOAD-VIEW.
000900
000910
000920		    INITIALIZE VIEW.
000930
000940
000950          MOVE SPACES              TO STRINGA-VIEW.
000960
000970			STRING 
000980
000990			'<a href="openuten.exe?MK-KEY='
001000			 SECTION-WEB DELIMITED BY SIZE
001010			"&MK-ENTITA=" ENTITA-WEB  DELIMITED BY SIZE
001020			"&MK-FUNZIONE=" FUNZIONE-WEB  DELIMITED BY SIZE
001030			'" class="easyui-linkbutton" data-options="iconCls:'
001040			"'icon-back'"
001050			'" style="padding:5px 0px;width:25%; margin-left:20px">'
001060			' <span style="font-size:14px;">Indietro</span></a>'  
001070			DELIMITED BY SIZE INTO STRINGA-VIEW.
001080            
001090
001100          MOVE "GOBACK"           TO NOME-VIEW
001110          PERFORM SCRITTURA-VIEW  THRU EX-SCRITTURA-VIEW.
001120
001130
001140			MOVE SPACES				TO NOME-JSON.
001150
001160			STRING "UTENTI" FUNZIONE-WEB 				
001170			DELIMITED BY SIZE INTO  NOME-JSON.
001180
001181          MOVE "FILE-JSON"        TO NOME-VIEW
001182
001190			PERFORM OPEN-O-JSON		THRU EX-OPEN-O-JSON.
001200
001260
001270			MOVE ZEROS				TO CONTA.
001280
001290			PERFORM CONTA-RECORD	THRU EX-CONTA-RECORD.
001300
001310			PERFORM VARYING IND FROM 1 BY 1 UNTIL IND > LENGTH OF CONTA
001320			 OR CONTA(IND:1) > "0"
001330			 CONTINUE
001340			END-PERFORM.
001350
001360			STRING '{"total":' CONTA(IND:) ',"rows":['		
001370			DELIMITED BY SIZE INTO DATI-JSON.
001380			PERFORM SCRITTURA-JSON  THRU EX-SCRITTURA-JSON.
001390
001400			MOVE SPACES				TO DATI-JSON.
001410
001420          MOVE LOW-VALUE          TO CHIAVE-UTEN.
001430          PERFORM STARTO-UTEN      THRU EX-STARTO-UTEN.
001440
001450          if ESITO-NOK GO TO FINE-UTENTE.
001460
001470
001480 CICLO-UTENTE.
001490
001500			PERFORM LEGGO-NEXT-UTEN	THRU EX-LEGGO-NEXT-UTEN.
001510
001520			IF FINE-FILE = "S" GO TO FINE-UTENTE.
001530
001540			IF DATI-JSON > SPACES
001550			PERFORM SCRITTURA-JSON		THRU EX-SCRITTURA-JSON.
001560
001570***** ELIMINA EVENTUALI ELEMENTI NOCIVI PER LA JSON
001580
001590			INSPECT UTENTE REPLACING ALL "\" BY " ".			
001600
001610				
001620**** ITEM
001630		
001640			STRING 
001650
001660			'   {"ELEMENTO":"'	DELIMITED BY SIZE
001670			CHIAVE-UTEN      DELIMITED BY "   "
001680			'",'			DELIMITED BY SIZE
001690			INTO DATI-JSON  PERFORM SCRITTURA-JSON THRU EX-SCRITTURA-JSON.
001700
001710**** ITEM
001720			STRING "        "
001730			'"DESC":"'	DELIMITED BY SIZE
001740			NOME-UTEN        DELIMITED BY "     "
001750			'",'			DELIMITED BY SIZE
001760			INTO DATI-JSON  PERFORM SCRITTURA-JSON THRU EX-SCRITTURA-JSON.
001770**** ITEM
001780			STRING "        "
001790			'"DESC1":"'	DELIMITED BY SIZE
001800			GRUPPO-UTEN     DELIMITED BY "     "
001810			'",'			DELIMITED BY SIZE
001820			INTO DATI-JSON  PERFORM SCRITTURA-JSON THRU EX-SCRITTURA-JSON.
001830**** ITEM
001840			STRING "        "
001850			'"DESC2":"'	DELIMITED BY SIZE
001860			DESC-UTEN       DELIMITED BY "     "
001870			'",'			DELIMITED BY SIZE
001880			INTO DATI-JSON  PERFORM SCRITTURA-JSON THRU EX-SCRITTURA-JSON.
001890
001900**** ITEM
001910			STRING "        "
001920			'"' 		
001930			'CANCELLA":"'	DELIMITED BY SIZE
001940			'<a href=opencanc.exe?MK-KEY='
001950			 SECTION-WEB DELIMITED BY SIZE
001960			"&MK-ITEM=" DELIMITED BY SIZE
001970			CHIAVE-UTEN  DELIMITED BY SIZE
001980			"&MK-FILE=UT" DELIMITED BY SIZE
001990			'>' delimited by size 
002000			"<img src='/openpa/images/cancella.gif' BORDER='0'></a>",
002010				delimited by size 
002020			'",'			DELIMITED BY SIZE
002030			INTO DATI-JSON  PERFORM SCRITTURA-JSON THRU EX-SCRITTURA-JSON.
002040**** ITEM
002050			STRING "        "
002060			'"' 		
002070			'MODIFICA":"'	DELIMITED BY SIZE
002080			'<a href=openmout.exe?MK-KEY='
002090			 SECTION-WEB DELIMITED BY SIZE
002100			"&MK-ITEM=" DELIMITED BY SIZE
002110			CHIAVE-UTEN
002120			'>' delimited by size 
002130			"<img src='/openpa/images/ok.png' BORDER='0'></a>"
002140				delimited by size 
002150          '"},' DELIMITED BY SIZE 
002160			into dati-JSON.
002170
002180			GO TO CICLO-UTENTE.
002190
002200
002210 FINE-UTENTE.
002220
002230			INSPECT DATI-JSON REPLACING all "}, " BY
002240										    "}  ".
002250
002260			PERFORM SCRITTURA-JSON		THRU EX-SCRITTURA-JSON.
002270
002280
002290			MOVE "]}"					TO DATI-JSON.
002300			PERFORM SCRITTURA-JSON  	THRU EX-SCRITTURA-JSON.
002310
002320			CLOSE ARKJSON.
002330
002340
002350 EX-LOAD-VIEW.
002360          EXIT.
002370
002380 CONTA-RECORD.
002390
002400          MOVE LOW-VALUE          TO CHIAVE-UTEN.
002410          PERFORM STARTO-UTEN      THRU EX-STARTO-UTEN.
002420			
002430			IF ESITO-NOK GO TO EX-CONTA-RECORD.
002440
002450 CICLO-CONTA-RECORD.
002460
002470			PERFORM LEGGO-NEXT-UTEN	THRU EX-LEGGO-NEXT-UTEN.
002480
002490			IF FINE-FILE = "S" GO TO EX-CONTA-RECORD.
002500
002510			ADD 1					TO CONTA.
002520
002530			GO TO CICLO-CONTA-RECORD.
002540
002550 EX-CONTA-RECORD.
002560			EXIT.
002570
