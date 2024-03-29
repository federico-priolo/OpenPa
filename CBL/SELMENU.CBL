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
000028
000029*
000030* SELECT PER IL FILE MENU
000040*
000050          SELECT ARKMENU ASSIGN TO  FILE-MENU
000060           ORGANIZATION IS INDEXED
000070           ACCESS MODE  IS DYNAMIC
000080           RECORD KEY   IS CHIAVE-MENU
000090           ALTERNATE RECORD KEY IS CHIAVE-SEC-MENU DUPLICATES
000090           ALTERNATE RECORD KEY IS CHIAVE-TER-MENU DUPLICATES
000100           ALTERNATE RECORD KEY IS DESC-MENU       DUPLICATES
000110           LOCK MODE    IS AUTOMATIC WITH LOCK ON RECORD
000120           FILE STATUS  IS STATUS-MENU.
000130*
