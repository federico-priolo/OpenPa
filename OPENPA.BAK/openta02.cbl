000010*
000020* Copyright (C) 2010-2021 Federico Priolo TP ONE SRL federico.priolo@tp-one.it
000030*
000040* This program is free software; you can redistribute it and/or modify
000050* it under the terms of the GNU General Public License as published by
000060* the Free Software Foundation; either version 2, or (at your option)
000070* any later version.
000080*
000090* This program is distributed in the hope that it will be useful,
000100* but WITHOUT ANY WARRANTY; without even the implied warranty of
000110* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
000120* GNU General Public License for more details.
000130*
000140* You should have received a copy of the GNU General Public License
000150* along with this software; see the file COPYING.  If not, write to
000160* the Free Software Foundation, 51 Franklin Street, Fifth Floor
000170* Boston, MA 02110-1301 USA
000180*
000190 IDENTIFICATION   DIVISION.
000200 PROGRAM-ID       OPENTA02.
000210 ENVIRONMENT      DIVISION.
000220 CONFIGURATION    SECTION.
000250			COPY "SPECIAL.CBL".
000251 INPUT-OUTPUT     SECTION.
000260 FILE-CONTROL.
000270
000280          COPY "SELWEB.CBL".
000290          COPY "SELVIEW.CBL".
000300          COPY "SELTAB.CBL".
000310			COPY "SELDATO.CBL".
000320
000330
000340
000350 DATA             DIVISION.
000360 FILE SECTION.
000370
000380          COPY "FDEWEB.CBL".
000390          COPY "FDEVIEW.CBL".
000400          COPY "FDETAB.CBL".
000410			COPY "FDEDATO.CBL".
000420
000430 WORKING-STORAGE  SECTION.
000440
000450          COPY "COBW3.CBL".
000460          COPY "GLOBALS.CBL".
000470          COPY "IMAGES.CBL".
000480*
000490 PROCEDURE  DIVISION.
000500*
000510          PERFORM INIZIO-WEB   THRU EX-INIZIO-WEB.
000520
000530          PERFORM OPEN-I-TAB   THRU EX-OPEN-I-TAB.
000540			PERFORM OPEN-I-DATO  THRU EX-OPEN-I-DATO.
000550
000560			COPY "INIZIALI.CBL".
000570
000580
000590          PERFORM LOAD-VIEW    THRU EX-LOAD-VIEW
000600
000610          MOVE "TEMPLATE/TABELL02.HTM"    TO PAGE-WEB
000620          PERFORM MAKE-WEB     THRU EX-MAKE-WEB.
000630
000640
000650 FINE.
000660          PERFORM CLOSE-VIEW   THRU EX-CLOSE-VIEW.
000670          PERFORM CLOSE-TAB    THRU EX-CLOSE-TAB.
000680			PERFORM CLOSE-DATO   THRU EX-CLOSE-DATO.
000690
000700          PERFORM FINE-WEB     THRU EX-FINE-WEB.
000710
000720          GOBACK.
000730
000740          COPY "PIOWEB.CBL".
000750          COPY "PIOVIEW.CBL".
000760          COPY "PIOTAB.CBL".
000770			COPY "PIODATO.CBL".
000780
000790
000800 LOAD-VIEW.
000810
000820     
000870          MOVE SPACES              TO STRINGA-VIEW.
000880
000890
000900			STRING 
000910
000920			'<a href="openta02.exe?MK-KEY='
000930			 SECTION-WEB DELIMITED BY SIZE
000940			'" class="easyui-linkbutton" data-options="iconCls:'
000950			"'icon-undo'"
000960			'" style="padding:5px 0px;width:45%; margin-left:20px">'
000970			' <span style="font-size:14px;">Indietro</span></a>'  
000980			DELIMITED BY SIZE INTO STRINGA-VIEW.
000990
000991          MOVE "GOBACK"           TO NOME-VIEW
000992          PERFORM SCRITTURA-VIEW  THRU EX-SCRITTURA-VIEW.
000993
000994
001000			INITIALIZE TABELLA-002.
001010
001020          MOVE "02"               TO TIPO-TAB.
001030          MOVE 1                  TO PROG-TAB.
001040          MOVE 01                 TO ENTE-TAB.
001050          PERFORM LEGGO-TAB       THRU EX-LEGGO-TAB.
001060
001070          if esito-NOK INITIALIZE TABELLA-002
001080
001090          MOVE "INSERIMENTO"      TO STRINGA-VIEW
001100          MOVE "LAVORO"           TO NOME-VIEW
001110          PERFORM SCRITTURA-VIEW  THRU EX-SCRITTURA-VIEW
001120			ELSE
001130          MOVE "VARIAZIONE"       TO STRINGA-VIEW
001140          MOVE "LAVORO"           TO NOME-VIEW
001150          PERFORM SCRITTURA-VIEW  THRU EX-SCRITTURA-VIEW.
001160
001170          MOVE TIPO-TAB           TO STRINGA-VIEW
001180          MOVE "TIPO-TAB"         TO NOME-VIEW
001190          PERFORM SCRITTURA-VIEW  THRU EX-SCRITTURA-VIEW .
001200
001210          MOVE CHIAVE-TAB 	    TO STRINGA-VIEW
001220          MOVE "CHIAVE-TAB"       TO NOME-VIEW
001230          PERFORM SCRITTURA-VIEW  THRU EX-SCRITTURA-VIEW.
001240
001250
001260
001270***** LETTURA VARIABILI DA MASCHERA HTML : NB. IL NOME DEVE COINCIDERE CON IL NOME RECORD
001280
001290
001300			MOVE "TA"				TO CHIAVE-DATO.
001310
001320			PERFORM STARTO-DATO		THRU EX-STARTO-DATO.
001330
001340			IF ESITO-NOK GO TO EX-LOAD-VIEW.
001350
001360******* SI POSIZIONA SULLA TABELLA IN FASE DI GESTIONE  TABELLA-0XX XX=TIPO-TAB
001370
001380 CICLO-VIEW.
001390
001400			PERFORM LEGGO-NEXT-DATO THRU EX-LEGGO-NEXT-DATO.
001410
001420      	IF FINE-FILE = "S" GO TO EX-LOAD-VIEW.
001430		
001440			IF NOME-COBOL-DATO(1:9) NOT = "TABELLA-0" GO TO CICLO-VIEW.
001450			 
001460			IF NOME-COBOL-DATO(10:2) NOT = TIPO-TAB GO TO CICLO-VIEW.
001470*
001480*** IL PRIMO CAMPO  E' TABELLA-0XX  LEGGE SUBITO IL PROSSIMO CHE IDENTIFICA IL PRIMO CAMPO RECORD
001490*
001500	
001510
001520 CICLO-DATI-VIEW.
001530
001540			PERFORM LEGGO-NEXT-DATO THRU EX-LEGGO-NEXT-DATO.
001550
001560**** HA RAGGIUNTO UN ALTRA TABELLA: FINE
001570
001580			IF NOME-COBOL-DATO(1:9) = "TABELLA-0" MOVE "S" TO FINE-FILE.
001590
001600			IF FINE-FILE = "S" GO TO EX-LOAD-VIEW.
001610
001620
001630***** TODO: GESTIRE IMPORTO O VALORI NUMERICI STANDARD
001640
001650			MOVE TABELLA(POS-DATO:SIZE-DATO) TO STRINGA-VIEW.
001660
001670          MOVE NOME-COBOL-DATO    TO NOME-VIEW.
001680
001690          PERFORM SCRITTURA-VIEW  THRU EX-SCRITTURA-VIEW.
001700
001710			GO TO CICLO-DATI-VIEW.
001720		 
001730
001740 EX-LOAD-VIEW.
001750          EXIT.
001760
001770
001780 REPLACE-WEB.
001790
001800          PERFORM REPLACE-STANDARD-WEB THRU EX-REPLACE-STANDARD-WEB.
001810
001820
001830 EX-REPLACE-WEB.
001840          EXIT.
001850
