EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L MCU_Module:Arduino_UNO_R3 A101
U 1 1 61EB2F4F
P 4200 3000
F 0 "A101" H 4200 4181 50  0000 C CNN
F 1 "Arduino_UNO_R3" H 4200 4090 50  0000 C CNN
F 2 "Module:Arduino_UNO_R3" H 4200 3000 50  0001 C CIN
F 3 "https://www.arduino.cc/en/Main/arduinoBoardUno" H 4200 3000 50  0001 C CNN
	1    4200 3000
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x06_Female J101
U 1 1 61EB42FB
P 6200 2650
F 0 "J101" H 6228 2626 50  0000 L CNN
F 1 "Conn_01x06_Male" H 6228 2535 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x06_P2.54mm_Vertical" H 6200 2650 50  0001 C CNN
F 3 "~" H 6200 2650 50  0001 C CNN
	1    6200 2650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0101
U 1 1 61EB5662
P 4200 4150
F 0 "#PWR0101" H 4200 3900 50  0001 C CNN
F 1 "GND" H 4205 3977 50  0000 C CNN
F 2 "" H 4200 4150 50  0001 C CNN
F 3 "" H 4200 4150 50  0001 C CNN
	1    4200 4150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0102
U 1 1 61EB5DC5
P 5700 2800
F 0 "#PWR0102" H 5700 2550 50  0001 C CNN
F 1 "GND" H 5705 2627 50  0000 C CNN
F 2 "" H 5700 2800 50  0001 C CNN
F 3 "" H 5700 2800 50  0001 C CNN
	1    5700 2800
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0103
U 1 1 61EB6212
P 4400 1850
F 0 "#PWR0103" H 4400 1700 50  0001 C CNN
F 1 "+5V" H 4415 2023 50  0000 C CNN
F 2 "" H 4400 1850 50  0001 C CNN
F 3 "" H 4400 1850 50  0001 C CNN
	1    4400 1850
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0104
U 1 1 61EB643D
P 5700 2400
F 0 "#PWR0104" H 5700 2250 50  0001 C CNN
F 1 "+5V" H 5715 2573 50  0000 C CNN
F 2 "" H 5700 2400 50  0001 C CNN
F 3 "" H 5700 2400 50  0001 C CNN
	1    5700 2400
	1    0    0    -1  
$EndComp
Text GLabel 3700 2400 0    50   Input ~ 0
RX
Text GLabel 6000 2950 0    50   Input ~ 0
RX
Text GLabel 3700 2500 0    50   Input ~ 0
TX
Text GLabel 6000 2850 0    50   Input ~ 0
TX
Wire Wire Line
	4100 4100 4100 4150
Wire Wire Line
	4100 4150 4200 4150
Wire Wire Line
	4200 4150 4200 4100
Connection ~ 4200 4150
Wire Wire Line
	4200 4150 4300 4150
Wire Wire Line
	4300 4150 4300 4100
Wire Wire Line
	4400 1850 4400 2000
NoConn ~ 4700 2400
NoConn ~ 4700 2600
NoConn ~ 4700 2800
NoConn ~ 4700 3000
NoConn ~ 4700 3100
NoConn ~ 4700 3200
NoConn ~ 4700 3300
NoConn ~ 4700 3400
NoConn ~ 4700 3500
NoConn ~ 4700 3700
NoConn ~ 4700 3800
NoConn ~ 3700 3700
NoConn ~ 3700 3600
NoConn ~ 3700 3500
NoConn ~ 3700 3400
NoConn ~ 3700 3300
NoConn ~ 3700 3200
NoConn ~ 3700 3100
NoConn ~ 3700 3000
NoConn ~ 3700 2900
NoConn ~ 3700 2800
NoConn ~ 3700 2700
NoConn ~ 3700 2600
Wire Wire Line
	5700 2800 5700 2750
Wire Wire Line
	5700 2650 6000 2650
Wire Wire Line
	5700 2750 6000 2750
Connection ~ 5700 2750
Wire Wire Line
	5700 2750 5700 2650
Wire Wire Line
	5700 2450 5700 2550
Wire Wire Line
	5700 2550 6000 2550
Wire Wire Line
	5700 2400 5700 2450
Wire Wire Line
	5700 2450 6000 2450
Connection ~ 5700 2450
$EndSCHEMATC
