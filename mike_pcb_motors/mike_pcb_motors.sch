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
P 6500 1750
F 0 "J1" H 6608 2131 50  0000 C CNN
F 1 "Motor1" H 6608 2040 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x06_P2.54mm_Vertical" H 6500 1750 50  0001 C CNN
F 3 "~" H 6500 1750 50  0001 C CNN
	1    6500 1750
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0112
U 1 1 60EE8CFC
P 6700 1950
F 0 "#PWR0112" H 6700 1800 50  0001 C CNN
F 1 "+5V" V 6715 2078 50  0000 L CNN
F 2 "" H 6700 1950 50  0001 C CNN
F 3 "" H 6700 1950 50  0001 C CNN
	1    6700 1950
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0114
U 1 1 60EE9A32
P 6700 1650
F 0 "#PWR0114" H 6700 1400 50  0001 C CNN
F 1 "GND" V 6705 1522 50  0000 R CNN
F 2 "" H 6700 1650 50  0001 C CNN
F 3 "" H 6700 1650 50  0001 C CNN
	1    6700 1650
	0    -1   -1   0   
$EndComp
Text GLabel 6700 1550 2    50   Input ~ 0
Motor1_M1
Text GLabel 6700 2050 2    50   Input ~ 0
Motor1_M2
Text GLabel 6700 1850 2    50   Input ~ 0
Motor1_A
Text GLabel 6700 1750 2    50   Input ~ 0
Motor1_B
$Comp
L Connector:Conn_01x06_Male J2
U 1 1 60EED123
P 6500 2650
F 0 "J2" H 6608 3031 50  0000 C CNN
F 1 "Motor2" H 6608 2940 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x06_P2.54mm_Vertical" H 6500 2650 50  0001 C CNN
F 3 "~" H 6500 2650 50  0001 C CNN
	1    6500 2650
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0115
U 1 1 60EED129
P 6700 2850
F 0 "#PWR0115" H 6700 2700 50  0001 C CNN
F 1 "+5V" V 6715 2978 50  0000 L CNN
F 2 "" H 6700 2850 50  0001 C CNN
F 3 "" H 6700 2850 50  0001 C CNN
	1    6700 2850
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0116
U 1 1 60EED12F
P 6700 2550
F 0 "#PWR0116" H 6700 2300 50  0001 C CNN
F 1 "GND" V 6705 2422 50  0000 R CNN
F 2 "" H 6700 2550 50  0001 C CNN
F 3 "" H 6700 2550 50  0001 C CNN
	1    6700 2550
	0    -1   -1   0   
$EndComp
Text GLabel 6700 2450 2    50   Input ~ 0
Motor2_M1
Text GLabel 6700 2950 2    50   Input ~ 0
Motor2_M2
Text GLabel 6700 2750 2    50   Input ~ 0
Motor2_A
Text GLabel 6700 2650 2    50   Input ~ 0
Motor2_B
$Comp
L Connector:Conn_01x06_Male J3
U 1 1 60EEDD8F
P 6500 3550
F 0 "J3" H 6608 3931 50  0000 C CNN
F 1 "Motor3" H 6608 3840 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x06_P2.54mm_Vertical" H 6500 3550 50  0001 C CNN
F 3 "~" H 6500 3550 50  0001 C CNN
	1    6500 3550
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0117
U 1 1 60EEDD95
P 6700 3750
F 0 "#PWR0117" H 6700 3600 50  0001 C CNN
F 1 "+5V" V 6715 3878 50  0000 L CNN
F 2 "" H 6700 3750 50  0001 C CNN
F 3 "" H 6700 3750 50  0001 C CNN
	1    6700 3750
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0118
U 1 1 60EEDD9B
P 6700 3450
F 0 "#PWR0118" H 6700 3200 50  0001 C CNN
F 1 "GND" V 6705 3322 50  0000 R CNN
F 2 "" H 6700 3450 50  0001 C CNN
F 3 "" H 6700 3450 50  0001 C CNN
	1    6700 3450
	0    -1   -1   0   
$EndComp
Text GLabel 6700 3350 2    50   Input ~ 0
Motor3_M1
Text GLabel 6700 3850 2    50   Input ~ 0
Motor3_M2
Text GLabel 6700 3650 2    50   Input ~ 0
Motor3_A
Text GLabel 6700 3550 2    50   Input ~ 0
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
P 8750 1600
F 0 "U2" H 8650 2165 50  0000 C CNN
F 1 "MDD3A-3ADCMD" H 8650 2074 50  0000 C CNN
F 2 "mike_pcb_motors:mdd3a" H 8650 2100 50  0001 C CNN
F 3 "" H 8650 2100 50  0001 C CNN
	1    8750 1600
	1    0    0    -1  
$EndComp
Text GLabel 8200 1300 0    50   Input ~ 0
Motor1_M1
Text GLabel 8200 1500 0    50   Input ~ 0
Motor1_M2
Text GLabel 8200 2100 0    50   Input ~ 0
Motor2_M1
Text GLabel 8200 2300 0    50   Input ~ 0
Motor2_M2
Text GLabel 8250 3150 0    50   Input ~ 0
Motor3_M1
Text GLabel 8250 3350 0    50   Input ~ 0
Motor3_M2
$Comp
L power:VCC #PWR0119
U 1 1 60F02041
P 8200 1700
F 0 "#PWR0119" H 8200 1550 50  0001 C CNN
F 1 "VCC" V 8215 1827 50  0000 L CNN
F 2 "" H 8200 1700 50  0001 C CNN
F 3 "" H 8200 1700 50  0001 C CNN
	1    8200 1700
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR0120
U 1 1 60F03F83
P 8250 3550
F 0 "#PWR0120" H 8250 3400 50  0001 C CNN
F 1 "VCC" V 8265 3677 50  0000 L CNN
F 2 "" H 8250 3550 50  0001 C CNN
F 3 "" H 8250 3550 50  0001 C CNN
	1    8250 3550
	0    -1   -1   0   
$EndComp
Text GLabel 9100 1300 2    50   Input ~ 0
Motor1_PWM1
Text GLabel 9100 1500 2    50   Input ~ 0
Motor1_PWM2
Text GLabel 9100 2100 2    50   Input ~ 0
Motor2_PWM1
Text GLabel 9100 2300 2    50   Input ~ 0
Motor2_PWM2
Text GLabel 9150 3150 2    50   Input ~ 0
Motor3_PWM1
Text GLabel 9150 3350 2    50   Input ~ 0
Motor3_PWM2
$Comp
L power:GND #PWR0123
U 1 1 60F06B53
P 9100 1900
F 0 "#PWR0123" H 9100 1650 50  0001 C CNN
F 1 "GND" V 9105 1772 50  0000 R CNN
F 2 "" H 9100 1900 50  0001 C CNN
F 3 "" H 9100 1900 50  0001 C CNN
	1    9100 1900
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0124
U 1 1 60F078EF
P 9150 3750
F 0 "#PWR0124" H 9150 3500 50  0001 C CNN
F 1 "GND" V 9155 3622 50  0000 R CNN
F 2 "" H 9150 3750 50  0001 C CNN
F 3 "" H 9150 3750 50  0001 C CNN
	1    9150 3750
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
P 6350 4850
F 0 "U5" H 6375 5115 50  0000 C CNN
F 1 "DF_buck-converter_8-28to5V" H 6375 5024 50  0000 C CNN
F 2 "mike_pcb_motors:DF_buck-converter_8-28to5" H 6350 5050 50  0001 C CNN
F 3 "" H 6350 5050 50  0001 C CNN
	1    6350 4850
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0127
U 1 1 60F45E24
P 5650 4850
F 0 "#PWR0127" H 5650 4700 50  0001 C CNN
F 1 "+5V" H 5665 5023 50  0000 C CNN
F 2 "" H 5650 4850 50  0001 C CNN
F 3 "" H 5650 4850 50  0001 C CNN
	1    5650 4850
	1    0    0    -1  
$EndComp
Wire Wire Line
	5650 4850 5850 4850
Wire Wire Line
	5850 4850 5850 4950
Connection ~ 5850 4850
$Comp
L power:GND #PWR0128
U 1 1 60F47E56
P 5650 5150
F 0 "#PWR0128" H 5650 4900 50  0001 C CNN
F 1 "GND" V 5655 5022 50  0000 R CNN
F 2 "" H 5650 5150 50  0001 C CNN
F 3 "" H 5650 5150 50  0001 C CNN
	1    5650 5150
	1    0    0    -1  
$EndComp
Wire Wire Line
	5650 5150 5850 5150
Wire Wire Line
	5850 5150 5850 5050
Connection ~ 5850 5150
$Comp
L power:VCC #PWR0129
U 1 1 60F496F6
P 7100 4850
F 0 "#PWR0129" H 7100 4700 50  0001 C CNN
F 1 "VCC" V 7115 4977 50  0000 L CNN
F 2 "" H 7100 4850 50  0001 C CNN
F 3 "" H 7100 4850 50  0001 C CNN
	1    7100 4850
	1    0    0    -1  
$EndComp
Wire Wire Line
	6900 4950 6900 4850
Wire Wire Line
	6900 4850 7100 4850
Connection ~ 6900 4850
$Comp
L power:GND #PWR0130
U 1 1 60F4B8C3
P 7100 5150
F 0 "#PWR0130" H 7100 4900 50  0001 C CNN
F 1 "GND" V 7105 5022 50  0000 R CNN
F 2 "" H 7100 5150 50  0001 C CNN
F 3 "" H 7100 5150 50  0001 C CNN
	1    7100 5150
	1    0    0    -1  
$EndComp
Wire Wire Line
	7100 5150 6900 5150
Wire Wire Line
	6900 5050 6900 5150
Connection ~ 6900 5150
$Comp
L power:GND #PWR0121
U 1 1 6124EA17
P 8200 1900
F 0 "#PWR0121" H 8200 1650 50  0001 C CNN
F 1 "GND" V 8205 1772 50  0000 R CNN
F 2 "" H 8200 1900 50  0001 C CNN
F 3 "" H 8200 1900 50  0001 C CNN
	1    8200 1900
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0122
U 1 1 6124F365
P 8250 3750
F 0 "#PWR0122" H 8250 3500 50  0001 C CNN
F 1 "GND" V 8255 3622 50  0000 R CNN
F 2 "" H 8250 3750 50  0001 C CNN
F 3 "" H 8250 3750 50  0001 C CNN
	1    8250 3750
	0    1    1    0   
$EndComp
$Comp
L Connector:Screw_Terminal_01x02 J5
U 1 1 61251F54
P 9750 5050
F 0 "J5" H 9830 5042 50  0000 L CNN
F 1 "Screw_Terminal_01x02" H 9830 4951 50  0000 L CNN
F 2 "TerminalBlock:TerminalBlock_bornier-2_P5.08mm" H 9750 5050 50  0001 C CNN
F 3 "~" H 9750 5050 50  0001 C CNN
	1    9750 5050
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0131
U 1 1 61255305
P 9550 5050
F 0 "#PWR0131" H 9550 4900 50  0001 C CNN
F 1 "VCC" V 9565 5177 50  0000 L CNN
F 2 "" H 9550 5050 50  0001 C CNN
F 3 "" H 9550 5050 50  0001 C CNN
	1    9550 5050
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0132
U 1 1 61255AC0
P 9550 5150
F 0 "#PWR0132" H 9550 4900 50  0001 C CNN
F 1 "GND" V 9555 5022 50  0000 R CNN
F 2 "" H 9550 5150 50  0001 C CNN
F 3 "" H 9550 5150 50  0001 C CNN
	1    9550 5150
	0    1    1    0   
$EndComp
$Comp
L MCU_Module:Arduino_Nano_v3.x A2
U 1 1 61C25545
P 4600 2250
F 0 "A2" H 4600 1161 50  0000 C CNN
F 1 "Arduino_Nano_v3.x" H 4600 1070 50  0000 C CNN
F 2 "Module:Arduino_Nano" H 4600 2250 50  0001 C CIN
F 3 "http://www.mouser.com/pdfdocs/Gravitech_Arduino_Nano3_0.pdf" H 4600 2250 50  0001 C CNN
	1    4600 2250
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0101
U 1 1 61C2554B
P 5100 3250
F 0 "#PWR0101" H 5100 3000 50  0001 C CNN
F 1 "GND" H 5105 3077 50  0000 C CNN
F 2 "" H 5100 3250 50  0001 C CNN
F 3 "" H 5100 3250 50  0001 C CNN
	1    5100 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	5100 3250 4700 3250
Connection ~ 4700 3250
Wire Wire Line
	4700 3250 4600 3250
$Comp
L power:+5V #PWR0102
U 1 1 61C25554
P 4500 1250
F 0 "#PWR0102" H 4500 1100 50  0001 C CNN
F 1 "+5V" H 4515 1423 50  0000 C CNN
F 2 "" H 4500 1250 50  0001 C CNN
F 3 "" H 4500 1250 50  0001 C CNN
	1    4500 1250
	1    0    0    -1  
$EndComp
Text GLabel 5100 2750 2    50   Input ~ 0
SCL_5V
Text GLabel 5100 2650 2    50   Input ~ 0
SDA_5V
Text GLabel 4100 1850 0    50   Input ~ 0
CraneMotor1_A
Text GLabel 4100 2050 0    50   Input ~ 0
CraneMotor2_A
Text GLabel 4100 2450 0    50   Input ~ 0
CraneMotor1_B
Text GLabel 4100 2850 0    50   Input ~ 0
CraneMotor2_B
Text GLabel 4100 2650 0    50   Input ~ 0
CraneMotor1_PWM1
Text GLabel 4100 2750 0    50   Input ~ 0
CraneMotor1_PWM2
Text GLabel 4100 2250 0    50   Input ~ 0
CraneMotor2_PWM1
Text GLabel 4100 2550 0    50   Input ~ 0
CraneMotor2_PWM2
$Comp
L Connector:Conn_01x06_Male J4
U 1 1 61C28ED1
P 1200 4200
F 0 "J4" H 1308 4581 50  0000 C CNN
F 1 "CraneMotorGear1" H 1308 4490 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x06_P2.54mm_Vertical" H 1200 4200 50  0001 C CNN
F 3 "~" H 1200 4200 50  0001 C CNN
	1    1200 4200
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0104
U 1 1 61C28ED7
P 1400 4400
F 0 "#PWR0104" H 1400 4250 50  0001 C CNN
F 1 "+5V" V 1415 4528 50  0000 L CNN
F 2 "" H 1400 4400 50  0001 C CNN
F 3 "" H 1400 4400 50  0001 C CNN
	1    1400 4400
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0105
U 1 1 61C28EDD
P 1400 4100
F 0 "#PWR0105" H 1400 3850 50  0001 C CNN
F 1 "GND" V 1405 3972 50  0000 R CNN
F 2 "" H 1400 4100 50  0001 C CNN
F 3 "" H 1400 4100 50  0001 C CNN
	1    1400 4100
	0    -1   -1   0   
$EndComp
Text GLabel 1400 4000 2    50   Input ~ 0
CraneMotor1_M1
Text GLabel 1400 4500 2    50   Input ~ 0
CraneMotor1_M2
Text GLabel 1400 4300 2    50   Input ~ 0
CraneMotor1_A
Text GLabel 1400 4200 2    50   Input ~ 0
CraneMotor1_B
$Comp
L Connector:Conn_01x06_Male J6
U 1 1 61C28EE7
P 1250 5150
F 0 "J6" H 1358 5531 50  0000 C CNN
F 1 "CraneMotorHook1" H 1358 5440 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x06_P2.54mm_Vertical" H 1250 5150 50  0001 C CNN
F 3 "~" H 1250 5150 50  0001 C CNN
	1    1250 5150
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0106
U 1 1 61C28EED
P 1450 5350
F 0 "#PWR0106" H 1450 5200 50  0001 C CNN
F 1 "+5V" V 1465 5478 50  0000 L CNN
F 2 "" H 1450 5350 50  0001 C CNN
F 3 "" H 1450 5350 50  0001 C CNN
	1    1450 5350
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0107
U 1 1 61C28EF3
P 1450 5050
F 0 "#PWR0107" H 1450 4800 50  0001 C CNN
F 1 "GND" V 1455 4922 50  0000 R CNN
F 2 "" H 1450 5050 50  0001 C CNN
F 3 "" H 1450 5050 50  0001 C CNN
	1    1450 5050
	0    -1   -1   0   
$EndComp
Text GLabel 1450 4950 2    50   Input ~ 0
CraneMotor2_M1
Text GLabel 1450 5450 2    50   Input ~ 0
CraneMotor2_M2
Text GLabel 1450 5250 2    50   Input ~ 0
CraneMotor2_A
Text GLabel 1450 5150 2    50   Input ~ 0
CraneMotor2_B
$Comp
L Connector:Conn_01x06_Male J7
U 1 1 61C4BD88
P 8200 5100
F 0 "J7" H 8308 5481 50  0000 C CNN
F 1 "PCB_connector" H 8250 5400 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x06_P2.54mm_Vertical" H 8200 5100 50  0001 C CNN
F 3 "~" H 8200 5100 50  0001 C CNN
	1    8200 5100
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0108
U 1 1 61C4BD8E
P 8400 5300
F 0 "#PWR0108" H 8400 5150 50  0001 C CNN
F 1 "+5V" V 8415 5428 50  0000 L CNN
F 2 "" H 8400 5300 50  0001 C CNN
F 3 "" H 8400 5300 50  0001 C CNN
	1    8400 5300
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0110
U 1 1 61C4BD94
P 8400 5200
F 0 "#PWR0110" H 8400 4950 50  0001 C CNN
F 1 "GND" V 8405 5072 50  0000 R CNN
F 2 "" H 8400 5200 50  0001 C CNN
F 3 "" H 8400 5200 50  0001 C CNN
	1    8400 5200
	0    -1   -1   0   
$EndComp
$Comp
L power:+5V #PWR0111
U 1 1 61C4BF50
P 8400 5400
F 0 "#PWR0111" H 8400 5250 50  0001 C CNN
F 1 "+5V" V 8415 5573 50  0000 C CNN
F 2 "" H 8400 5400 50  0001 C CNN
F 3 "" H 8400 5400 50  0001 C CNN
	1    8400 5400
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0113
U 1 1 61C4E7A6
P 8400 5100
F 0 "#PWR0113" H 8400 4850 50  0001 C CNN
F 1 "GND" V 8405 4972 50  0000 R CNN
F 2 "" H 8400 5100 50  0001 C CNN
F 3 "" H 8400 5100 50  0001 C CNN
	1    8400 5100
	0    -1   -1   0   
$EndComp
Text GLabel 8400 4900 2    50   Input ~ 0
SCL_5V
Text GLabel 8400 5000 2    50   Input ~ 0
SDA_5V
$Comp
L mike_pcb_motors:SBX-DRIVER U3
U 1 1 61C5DFC2
P 3900 4700
F 0 "U3" H 3800 5265 50  0000 C CNN
F 1 "SBX-DRIVER" H 3800 5174 50  0000 C CNN
F 2 "mike_pcb_motors:SBX-DRIVER" H 3800 5200 50  0001 C CNN
F 3 "" H 3800 5200 50  0001 C CNN
	1    3900 4700
	1    0    0    -1  
$EndComp
Text GLabel 4250 4750 2    50   Input ~ 0
CraneMotor1_PWM1
Text GLabel 4250 4650 2    50   Input ~ 0
CraneMotor1_PWM2
Text GLabel 4250 5150 2    50   Input ~ 0
CraneMotor2_PWM1
Text GLabel 4250 5050 2    50   Input ~ 0
CraneMotor2_PWM2
Text GLabel 3350 4850 0    50   Input ~ 0
CraneMotor1_M1
Text GLabel 3350 4750 0    50   Input ~ 0
CraneMotor1_M2
Text GLabel 3350 5050 0    50   Input ~ 0
CraneMotor2_M1
Text GLabel 3350 4950 0    50   Input ~ 0
CraneMotor2_M2
$Comp
L power:VCC #PWR0125
U 1 1 61C612A3
P 4250 4850
F 0 "#PWR0125" H 4250 4700 50  0001 C CNN
F 1 "VCC" V 4265 4977 50  0000 L CNN
F 2 "" H 4250 4850 50  0001 C CNN
F 3 "" H 4250 4850 50  0001 C CNN
	1    4250 4850
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0126
U 1 1 61C612A9
P 4250 4950
F 0 "#PWR0126" H 4250 4700 50  0001 C CNN
F 1 "GND" V 4255 4822 50  0000 R CNN
F 2 "" H 4250 4950 50  0001 C CNN
F 3 "" H 4250 4950 50  0001 C CNN
	1    4250 4950
	0    -1   -1   0   
$EndComp
$Comp
L mike_pcb_motors-rescue:MDD3A-3ADCMD-LMR U1
U 1 1 61C0A520
P 8800 3450
F 0 "U1" H 8700 4015 50  0000 C CNN
F 1 "MDD3A-3ADCMD" H 8700 3924 50  0000 C CNN
F 2 "mike_pcb_motors:mdd3a" H 8700 3950 50  0001 C CNN
F 3 "" H 8700 3950 50  0001 C CNN
	1    8800 3450
	1    0    0    -1  
$EndComp
$EndSCHEMATC
