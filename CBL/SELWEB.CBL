000010*
000011* Copyright (C) 2010-2021 Federico Priolo TP ONE SRL federico.priolo@tp-one.it
000012*
000013* This program is free software; you can redistribute it and/or modify
000014* it under the terms of the GNU General Public License as published by
000015* the Free Software Foundation; either version 2, or (at your option)
000016* any later version.
000017*
000018* This program is distributed in the hope that it will be useful,
000019* but WITHOUT ANY WARRANTY; without even the implied warranty of
000020* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
000021* GNU General Public License for more details.
000022*
000023* You should have received a copy of the GNU General Public License
000024* along with this software; see the file COPYING.  If not, write to
000025* the Free Software Foundation, 51 Franklin Street, Fifth Floor
000026* Boston, MA 02110-1301 USA
000027*
000028*
000029** flusso di elaborazione template foglio html
000030*
000040           SELECT ARKWEB ASSIGN FILE-WEB
000050           ORGANIZATION IS LINE SEQUENTIAL
000060           FILE STATUS  IS STATUS-WEB.
000070
000080
000090
000100*
000110** flusso di elaborazione libreria  campi 
000120*
000130           SELECT ARKLIB ASSIGN FILE-LIB
000140           ORGANIZATION IS LINE SEQUENTIAL
000150           FILE STATUS  IS STATUS-LIB.


000090
000100*
000110** flusso di elaborazione LOG   campi 
000120*
000130           SELECT ARKLOG ASSIGN FILE-LOG
000140           ORGANIZATION IS LINE SEQUENTIAL
000150           FILE STATUS  IS STATUS-LOG.
