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
L MCU_Module:Arduino_Nano_v3.x A1
U 1 1 60EAEDFE
P 1950 2250
F 0 "A1" H 1950 1161 50  0000 C CNN
F 1 "Arduino_Nano_v3.x" H 1950 1070 50  0000 C CNN
F 2 "Module:Arduino_Nano" H 1950 2250 50  0001 C CIN
F 3 "http://www.mouser.com/pdfdocs/Gravitech_Arduino_Nano3_0.pdf" H 1950 2250 50  0001 C CNN
	1    1950 2250
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0103
U 1 1 60EC48BC
P 2450 3250
F 0 "#PWR0103" H 2450 3000 50  0001 C CNN
F 1 "GND" H 2455 3077 50  0000 C CNN
F 2 "" H 2450 3250 50  0001 C CNN
F 3 "" H 2450 3250 50  0001 C CNN
	1    2450 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	2450 3250 2050 3250
Connection ~ 2050 3250
Wire Wire Line
	2050 3250 1950 3250
$Comp
L power:+5V #PWR0109
U 1 1 60ECF2DD
P 1850 1250
F 0 "#PWR0109" H 1850 1100 50  0001 C CNN
F 1 "+5V" H 1865 1423 50  0000 C CNN
F 2 "" H 1850 1250 50  0001 C CNN
F 3 "" H 1850 1250 50  0001 C CNN
	1    1850 1250
	1    0    0    -1  
$EndComp
Text GLabel 2450 2750 2    50   Input ~ 0
SCL_5V
Text GLabel 2450 2650 2    50   Input ~ 0
SDA_5V
$Comp
L Connector:Conn_01x06_Male J1
U 1 1 60EE8352
P 6700 1850
F 0 "J1" H 6808 2231 50  0000 C CNN
F 1 "Motor1" H 6808 2140 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x06_P2.54mm_Vertical" H 6700 1850 50  0001 C CNN
F 3 "~" H 6700 1850 50  0001 C CNN
	1    6700 1850
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0112
U 1 1 60EE8CFC
P 6900 2050
F 0 "#PWR0112" H 6900 1900 50  0001 C CNN
F 1 "+5V" V 6915 2178 50  0000 L CNN
F 2 "" H 6900 2050 50  0001 C CNN
F 3 "" H 6900 2050 50  0001 C CNN
	1    6900 2050
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0114
U 1 1 60EE9A32
P 6900 1750
F 0 "#PWR0114" H 6900 1500 50  0001 C CNN
F 1 "GND" V 6905 1622 50  0000 R CNN
F 2 "" H 6900 1750 50  0001 C CNN
F 3 "" H 6900 1750 50  0001 C CNN
	1    6900 1750
	0    -1   -1   0   
$EndComp
Text GLabel 6900 1650 2    50   Input ~ 0
Motor1_M1
Text GLabel 6900 2150 2    50   Input ~ 0
Motor1_M2
Text GLabel 6900 1950 2    50   Input ~ 0
Motor1_A
Text GLabel 6900 1850 2    50   Input ~ 0
Motor1_B
$Comp
L Connector:Conn_01x06_Male J2
U 1 1 60EED123
P 6700 2650
F 0 "J2" H 6808 3031 50  0000 C CNN
F 1 "Motor2" H 6808 2940 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x06_P2.54mm_Vertical" H 6700 2650 50  0001 C CNN
F 3 "~" H 6700 2650 50  0001 C CNN
	1    6700 2650
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0115
U 1 1 60EED129
P 6900 2850
F 0 "#PWR0115" H 6900 2700 50  0001 C CNN
F 1 "+5V" V 6915 2978 50  0000 L CNN
F 2 "" H 6900 2850 50  0001 C CNN
F 3 "" H 6900 2850 50  0001 C CNN
	1    6900 2850
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0116
U 1 1 60EED12F
P 6900 2550
F 0 "#PWR0116" H 6900 2300 50  0001 C CNN
F 1 "GND" V 6905 2422 50  0000 R CNN
F 2 "" H 6900 2550 50  0001 C CNN
F 3 "" H 6900 2550 50  0001 C CNN
	1    6900 2550
	0    -1   -1   0   
$EndComp
Text GLabel 6900 2450 2    50   Input ~ 0
Motor2_M1
Text GLabel 6900 2950 2    50   Input ~ 0
Motor2_M2
Text GLabel 6900 2750 2    50   Input ~ 0
Motor2_A
Text GLabel 6900 2650 2    50   Input ~ 0
Motor2_B
$Comp
L Connector:Conn_01x06_Male J3
U 1 1 60EEDD8F
P 6700 3450
F 0 "J3" H 6808 3831 50  0000 C CNN
F 1 "Motor3" H 6808 3740 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x06_P2.54mm_Vertical" H 6700 3450 50  0001 C CNN
F 3 "~" H 6700 3450 50  0001 C CNN
	1    6700 3450
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0117
U 1 1 60EEDD95
P 6900 3650
F 0 "#PWR0117" H 6900 3500 50  0001 C CNN
F 1 "+5V" V 6915 3778 50  0000 L CNN
F 2 "" H 6900 3650 50  0001 C CNN
F 3 "" H 6900 3650 50  0001 C CNN
	1    6900 3650
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0118
U 1 1 60EEDD9B
P 6900 3350
F 0 "#PWR0118" H 6900 3100 50  0001 C CNN
F 1 "GND" V 6905 3222 50  0000 R CNN
F 2 "" H 6900 3350 50  0001 C CNN
F 3 "" H 6900 3350 50  0001 C CNN
	1    6900 3350
	0    -1   -1   0   
$EndComp
Text GLabel 6900 3250 2    50   Input ~ 0
Motor3_M1
Text GLabel 6900 3750 2    50   Input ~ 0
Motor3_M2
Text GLabel 6900 3550 2    50   Input ~ 0
Motor3_A
Text GLabel 6900 3450 2    50   Input ~ 0
Motor3_B
Text GLabel 1450 1850 0    50   Input ~ 0
Motor1_A
Text GLabel 1450 2050 0    50   Input ~ 0
Motor2_A
Text GLabel 1450 2350 0    50   Input ~ 0
Motor3_A
Text GLabel 1450 2450 0    50   Input ~ 0
Motor1_B
Text GLabel 1450 2850 0    50   Input ~ 0
Motor2_B
Text GLabel 1450 2950 0    50   Input ~ 0
Motor3_B
$Comp
L mike_pcb_motors-rescue:MDD3A-3ADCMD-LMR U2
U 1 1 60EFFE66
P 8950 1600
F 0 "U2" H 8850 2165 50  0000 C CNN
F 1 "MDD3A-3ADCMD" H 8850 2074 50  0000 C CNN
F 2 "mike_pcb_motors:mdd3a" H 8850 2100 50  0001 C CNN
F 3 "" H 8850 2100 50  0001 C CNN
	1    8950 1600
	1    0    0    -1  
$EndComp
Text GLabel 8400 1300 0    50   Input ~ 0
Motor1_M1
Text GLabel 8400 1500 0    50   Input ~ 0
Motor1_M2
Text GLabel 8400 2100 0    50   Input ~ 0
Motor2_M1
Text GLabel 8400 2300 0    50   Input ~ 0
Motor2_M2
Text GLabel 8450 3150 0    50   Input ~ 0
Motor3_M1
Text GLabel 8450 3350 0    50   Input ~ 0
Motor3_M2
$Comp
L power:VCC #PWR0119
U 1 1 60F02041
P 8400 1700
F 0 "#PWR0119" H 8400 1550 50  0001 C CNN
F 1 "VCC" V 8415 1827 50  0000 L CNN
F 2 "" H 8400 1700 50  0001 C CNN
F 3 "" H 8400 1700 50  0001 C CNN
	1    8400 1700
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR0120
U 1 1 60F03F83
P 8450 3550
F 0 "#PWR0120" H 8450 3400 50  0001 C CNN
F 1 "VCC" V 8465 3677 50  0000 L CNN
F 2 "" H 8450 3550 50  0001 C CNN
F 3 "" H 8450 3550 50  0001 C CNN
	1    8450 3550
	0    -1   -1   0   
$EndComp
Text GLabel 9300 1300 2    50   Input ~ 0
Motor1_PWM1
Text GLabel 9300 1500 2    50   Input ~ 0
Motor1_PWM2
Text GLabel 9300 2100 2    50   Input ~ 0
Motor2_PWM1
Text GLabel 9300 2300 2    50   Input ~ 0
Motor2_PWM2
Text GLabel 9350 3150 2    50   Input ~ 0
Motor3_PWM1
Text GLabel 9350 3350 2    50   Input ~ 0
Motor3_PWM2
$Comp
L power:GND #PWR0123
U 1 1 60F06B53
P 9300 1900
F 0 "#PWR0123" H 9300 1650 50  0001 C CNN
F 1 "GND" V 9305 1772 50  0000 R CNN
F 2 "" H 9300 1900 50  0001 C CNN
F 3 "" H 9300 1900 50  0001 C CNN
	1    9300 1900
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0124
U 1 1 60F078EF
P 9350 3750
F 0 "#PWR0124" H 9350 3500 50  0001 C CNN
F 1 "GND" V 9355 3622 50  0000 R CNN
F 2 "" H 9350 3750 50  0001 C CNN
F 3 "" H 9350 3750 50  0001 C CNN
	1    9350 3750
	0    -1   -1   0   
$EndComp
Text GLabel 1450 2650 0    50   Input ~ 0
Motor1_PWM1
Text GLabel 1450 2750 0    50   Input ~ 0
Motor1_PWM2
Text GLabel 1450 2250 0    50   Input ~ 0
Motor2_PWM1
Text GLabel 1450 2550 0    50   Input ~ 0
Motor2_PWM2
Text GLabel 1450 1950 0    50   Input ~ 0
Motor3_PWM1
Text GLabel 1450 2150 0    50   Input ~ 0
Motor3_PWM2
$Comp
L mike_pcb_motors-rescue:DF_buck-converter_8-28to5V-LMR U5
U 1 1 60F44CFC
P 6450 5300
F 0 "U5" H 6475 5565 50  0000 C CNN
F 1 "DF_buck-converter_8-28to5V" H 6475 5474 50  0000 C CNN
F 2 "mike_pcb_motors:DF_buck-converter_8-28to5" H 6450 5500 50  0001 C CNN
F 3 "" H 6450 5500 50  0001 C CNN
	1    6450 5300
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0127
U 1 1 60F45E24
P 5750 5300
F 0 "#PWR0127" H 5750 5150 50  0001 C CNN
F 1 "+5V" H 5765 5473 50  0000 C CNN
F 2 "" H 5750 5300 50  0001 C CNN
F 3 "" H 5750 5300 50  0001 C CNN
	1    5750 5300
	1    0    0    -1  
$EndComp
Wire Wire Line
	5750 5300 5950 5300
Wire Wire Line
	5950 5300 5950 5400
Connection ~ 5950 5300
$Comp
L power:GND #PWR0128
U 1 1 60F47E56
P 5750 5600
F 0 "#PWR0128" H 5750 5350 50  0001 C CNN
F 1 "GND" V 5755 5472 50  0000 R CNN
F 2 "" H 5750 5600 50  0001 C CNN
F 3 "" H 5750 5600 50  0001 C CNN
	1    5750 5600
	1    0    0    -1  
$EndComp
Wire Wire Line
	5750 5600 5950 5600
Wire Wire Line
	5950 5600 5950 5500
Connection ~ 5950 5600
$Comp
L power:VCC #PWR0129
U 1 1 60F496F6
P 7200 5300
F 0 "#PWR0129" H 7200 5150 50  0001 C CNN
F 1 "VCC" V 7215 5427 50  0000 L CNN
F 2 "" H 7200 5300 50  0001 C CNN
F 3 "" H 7200 5300 50  0001 C CNN
	1    7200 5300
	1    0    0    -1  
$EndComp
Wire Wire Line
	7000 5400 7000 5300
Wire Wire Line
	7000 5300 7200 5300
Connection ~ 7000 5300
$Comp
L power:GND #PWR0130
U 1 1 60F4B8C3
P 7200 5600
F 0 "#PWR0130" H 7200 5350 50  0001 C CNN
F 1 "GND" V 7205 5472 50  0000 R CNN
F 2 "" H 7200 5600 50  0001 C CNN
F 3 "" H 7200 5600 50  0001 C CNN
	1    7200 5600
	1    0    0    -1  
$EndComp
Wire Wire Line
	7200 5600 7000 5600
Wire Wire Line
	7000 5500 7000 5600
Connection ~ 7000 5600
$Comp
L power:GND #PWR0121
U 1 1 6124EA17
P 8400 1900
F 0 "#PWR0121" H 8400 1650 50  0001 C CNN
F 1 "GND" V 8405 1772 50  0000 R CNN
F 2 "" H 8400 1900 50  0001 C CNN
F 3 "" H 8400 1900 50  0001 C CNN
	1    8400 1900
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0122
U 1 1 6124F365
P 8450 3750
F 0 "#PWR0122" H 8450 3500 50  0001 C CNN
F 1 "GND" V 8455 3622 50  0000 R CNN
F 2 "" H 8450 3750 50  0001 C CNN
F 3 "" H 8450 3750 50  0001 C CNN
	1    8450 3750
	0    1    1    0   
$EndComp
$Comp
L Connector:Screw_Terminal_01x02 J5
U 1 1 61251F54
P 9850 5500
F 0 "J5" H 9930 5492 50  0000 L CNN
F 1 "Screw_Terminal_01x02" H 9930 5401 50  0000 L CNN
F 2 "TerminalBlock:TerminalBlock_bornier-2_P5.08mm" H 9850 5500 50  0001 C CNN
F 3 "~" H 9850 5500 50  0001 C CNN
	1    9850 5500
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0131
U 1 1 61255305
P 9650 5500
F 0 "#PWR0131" H 9650 5350 50  0001 C CNN
F 1 "VCC" V 9665 5627 50  0000 L CNN
F 2 "" H 9650 5500 50  0001 C CNN
F 3 "" H 9650 5500 50  0001 C CNN
	1    9650 5500
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0132
U 1 1 61255AC0
P 9650 5600
F 0 "#PWR0132" H 9650 5350 50  0001 C CNN
F 1 "GND" V 9655 5472 50  0000 R CNN
F 2 "" H 9650 5600 50  0001 C CNN
F 3 "" H 9650 5600 50  0001 C CNN
	1    9650 5600
	0    1    1    0   
$EndComp
$Comp
L MCU_Module:Arduino_Nano_v3.x A2
U 1 1 61C25545
P 4600 2300
F 0 "A2" H 4600 1211 50  0000 C CNN
F 1 "Arduino_Nano_v3.x" H 4600 1120 50  0000 C CNN
F 2 "Module:Arduino_Nano" H 4600 2300 50  0001 C CIN
F 3 "http://www.mouser.com/pdfdocs/Gravitech_Arduino_Nano3_0.pdf" H 4600 2300 50  0001 C CNN
	1    4600 2300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0101
U 1 1 61C2554B
P 5100 3300
F 0 "#PWR0101" H 5100 3050 50  0001 C CNN
F 1 "GND" H 5105 3127 50  0000 C CNN
F 2 "" H 5100 3300 50  0001 C CNN
F 3 "" H 5100 3300 50  0001 C CNN
	1    5100 3300
	1    0    0    -1  
$EndComp
Wire Wire Line
	5100 3300 4700 3300
Connection ~ 4700 3300
Wire Wire Line
	4700 3300 4600 3300
$Comp
L power:+5V #PWR0102
U 1 1 61C25554
P 4500 1300
F 0 "#PWR0102" H 4500 1150 50  0001 C CNN
F 1 "+5V" H 4515 1473 50  0000 C CNN
F 2 "" H 4500 1300 50  0001 C CNN
F 3 "" H 4500 1300 50  0001 C CNN
	1    4500 1300
	1    0    0    -1  
$EndComp
Text GLabel 5100 2800 2    50   Input ~ 0
SCL_5V
Text GLabel 5100 2700 2    50   Input ~ 0
SDA_5V
Text GLabel 4100 1900 0    50   Input ~ 0
CraneMotor1_A
Text GLabel 4100 2100 0    50   Input ~ 0
CraneMotor2_A
Text GLabel 4100 2500 0    50   Input ~ 0
CraneMotor1_B
Text GLabel 4100 2900 0    50   Input ~ 0
CraneMotor2_B
Text GLabel 4100 2700 0    50   Input ~ 0
CraneMotor1_PWM1
Text GLabel 4100 2800 0    50   Input ~ 0
CraneMotor1_PWM2
Text GLabel 4100 2300 0    50   Input ~ 0
CraneMotor2_PWM1
Text GLabel 4100 2600 0    50   Input ~ 0
CraneMotor2_PWM2
$Comp
L Connector:Conn_01x06_Male J4
U 1 1 61C28ED1
P 1300 5200
F 0 "J4" H 1408 5581 50  0000 C CNN
F 1 "Motor1" H 1408 5490 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x06_P2.54mm_Vertical" H 1300 5200 50  0001 C CNN
F 3 "~" H 1300 5200 50  0001 C CNN
	1    1300 5200
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0104
U 1 1 61C28ED7
P 1500 5400
F 0 "#PWR0104" H 1500 5250 50  0001 C CNN
F 1 "+5V" V 1515 5528 50  0000 L CNN
F 2 "" H 1500 5400 50  0001 C CNN
F 3 "" H 1500 5400 50  0001 C CNN
	1    1500 5400
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0105
U 1 1 61C28EDD
P 1500 5100
F 0 "#PWR0105" H 1500 4850 50  0001 C CNN
F 1 "GND" V 1505 4972 50  0000 R CNN
F 2 "" H 1500 5100 50  0001 C CNN
F 3 "" H 1500 5100 50  0001 C CNN
	1    1500 5100
	0    -1   -1   0   
$EndComp
Text GLabel 1500 5000 2    50   Input ~ 0
CraneMotor1_M1
Text GLabel 1500 5500 2    50   Input ~ 0
CraneMotor1_M2
Text GLabel 1500 5300 2    50   Input ~ 0
CraneMotor1_A
Text GLabel 1500 5200 2    50   Input ~ 0
CraneMotor1_B
$Comp
L Connector:Conn_01x06_Male J6
U 1 1 61C28EE7
P 1300 6000
F 0 "J6" H 1408 6381 50  0000 C CNN
F 1 "Motor2" H 1408 6290 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x06_P2.54mm_Vertical" H 1300 6000 50  0001 C CNN
F 3 "~" H 1300 6000 50  0001 C CNN
	1    1300 6000
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0106
U 1 1 61C28EED
P 1500 6200
F 0 "#PWR0106" H 1500 6050 50  0001 C CNN
F 1 "+5V" V 1515 6328 50  0000 L CNN
F 2 "" H 1500 6200 50  0001 C CNN
F 3 "" H 1500 6200 50  0001 C CNN
	1    1500 6200
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0107
U 1 1 61C28EF3
P 1500 5900
F 0 "#PWR0107" H 1500 5650 50  0001 C CNN
F 1 "GND" V 1505 5772 50  0000 R CNN
F 2 "" H 1500 5900 50  0001 C CNN
F 3 "" H 1500 5900 50  0001 C CNN
	1    1500 5900
	0    -1   -1   0   
$EndComp
Text GLabel 1500 5800 2    50   Input ~ 0
CraneMotor2_M1
Text GLabel 1500 6300 2    50   Input ~ 0
CraneMotor2_M2
Text GLabel 1500 6100 2    50   Input ~ 0
CraneMotor2_A
Text GLabel 1500 6000 2    50   Input ~ 0
CraneMotor2_B
$Comp
L Connector:Conn_01x06_Male J7
U 1 1 61C4BD88
P 8300 5550
F 0 "J7" H 8408 5931 50  0000 C CNN
F 1 "PCB_connector" H 8350 5850 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x06_P2.54mm_Vertical" H 8300 5550 50  0001 C CNN
F 3 "~" H 8300 5550 50  0001 C CNN
	1    8300 5550
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0108
U 1 1 61C4BD8E
P 8500 5750
F 0 "#PWR0108" H 8500 5600 50  0001 C CNN
F 1 "+5V" V 8515 5878 50  0000 L CNN
F 2 "" H 8500 5750 50  0001 C CNN
F 3 "" H 8500 5750 50  0001 C CNN
	1    8500 5750
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0110
U 1 1 61C4BD94
P 8500 5650
F 0 "#PWR0110" H 8500 5400 50  0001 C CNN
F 1 "GND" V 8505 5522 50  0000 R CNN
F 2 "" H 8500 5650 50  0001 C CNN
F 3 "" H 8500 5650 50  0001 C CNN
	1    8500 5650
	0    -1   -1   0   
$EndComp
$Comp
L power:+5V #PWR0111
U 1 1 61C4BF50
P 8500 5850
F 0 "#PWR0111" H 8500 5700 50  0001 C CNN
F 1 "+5V" V 8515 6023 50  0000 C CNN
F 2 "" H 8500 5850 50  0001 C CNN
F 3 "" H 8500 5850 50  0001 C CNN
	1    8500 5850
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0113
U 1 1 61C4E7A6
P 8500 5550
F 0 "#PWR0113" H 8500 5300 50  0001 C CNN
F 1 "GND" V 8505 5422 50  0000 R CNN
F 2 "" H 8500 5550 50  0001 C CNN
F 3 "" H 8500 5550 50  0001 C CNN
	1    8500 5550
	0    -1   -1   0   
$EndComp
Text GLabel 8500 5350 2    50   Input ~ 0
SCL_5V
Text GLabel 8500 5450 2    50   Input ~ 0
SDA_5V
$Comp
L mike_pcb_motors:SBX-DRIVER U3
U 1 1 61C5DFC2
P 4000 5300
F 0 "U3" H 3900 5865 50  0000 C CNN
F 1 "SBX-DRIVER" H 3900 5774 50  0000 C CNN
F 2 "mike_pcb_motors:SBX-DRIVER" H 3900 5800 50  0001 C CNN
F 3 "" H 3900 5800 50  0001 C CNN
	1    4000 5300
	1    0    0    -1  
$EndComp
Text GLabel 4350 5350 2    50   Input ~ 0
CraneMotor1_PWM1
Text GLabel 4350 5250 2    50   Input ~ 0
CraneMotor1_PWM2
Text GLabel 4350 5750 2    50   Input ~ 0
CraneMotor2_PWM1
Text GLabel 4350 5650 2    50   Input ~ 0
CraneMotor2_PWM2
Text GLabel 3450 5450 0    50   Input ~ 0
CraneMotor1_M1
Text GLabel 3450 5350 0    50   Input ~ 0
CraneMotor1_M2
Text GLabel 3450 5650 0    50   Input ~ 0
CraneMotor2_M1
Text GLabel 3450 5550 0    50   Input ~ 0
CraneMotor2_M2
$Comp
L power:VCC #PWR0125
U 1 1 61C612A3
P 4350 5450
F 0 "#PWR0125" H 4350 5300 50  0001 C CNN
F 1 "VCC" V 4365 5577 50  0000 L CNN
F 2 "" H 4350 5450 50  0001 C CNN
F 3 "" H 4350 5450 50  0001 C CNN
	1    4350 5450
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0126
U 1 1 61C612A9
P 4350 5550
F 0 "#PWR0126" H 4350 5300 50  0001 C CNN
F 1 "GND" V 4355 5422 50  0000 R CNN
F 2 "" H 4350 5550 50  0001 C CNN
F 3 "" H 4350 5550 50  0001 C CNN
	1    4350 5550
	0    -1   -1   0   
$EndComp
$Comp
L mike_pcb_motors-rescue:MDD3A-3ADCMD-LMR U1
U 1 1 61C0A520
P 9000 3450
F 0 "U1" H 8900 4015 50  0000 C CNN
F 1 "MDD3A-3ADCMD" H 8900 3924 50  0000 C CNN
F 2 "mike_pcb_motors:mdd3a" H 8900 3950 50  0001 C CNN
F 3 "" H 8900 3950 50  0001 C CNN
	1    9000 3450
	1    0    0    -1  
$EndComp
$EndSCHEMATC
