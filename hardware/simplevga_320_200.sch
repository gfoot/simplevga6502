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
L 74xx:74HC74 U7
U 1 1 5FEBBAF3
P 8450 1650
F 0 "U7" H 8300 1900 50  0000 C CNN
F 1 "74HCT74" H 8650 1900 50  0000 C CNN
F 2 "" H 8450 1650 50  0001 C CNN
F 3 "74xx/74hc_hct74.pdf" H 8450 1650 50  0001 C CNN
	1    8450 1650
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC590 U3
U 1 1 5FEB5B4F
P 1700 5450
F 0 "U3" H 1550 6100 50  0000 C CNN
F 1 "74HC590" H 1900 6100 50  0000 C CNN
F 2 "" H 1700 5500 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC590.pdf" H 1700 5500 50  0001 C CNN
	1    1700 5450
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC590 U2
U 1 1 5FEB517C
P 1700 3850
F 0 "U2" H 1550 4500 50  0000 C CNN
F 1 "74HC590" H 1900 4500 50  0000 C CNN
F 2 "" H 1700 3900 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC590.pdf" H 1700 3900 50  0001 C CNN
	1    1700 3850
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC04 U8
U 2 1 5FEB3C62
P 10500 1050
F 0 "U8" H 10500 1367 50  0000 C CNN
F 1 "74HCT04" H 10500 1276 50  0000 C CNN
F 2 "" H 10500 1050 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT04.pdf" H 10500 1050 50  0001 C CNN
	2    10500 1050
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC04 U8
U 4 1 5FEDDBD6
P 3600 1550
F 0 "U8" H 3600 1867 50  0000 C CNN
F 1 "74HCT04" H 3600 1776 50  0000 C CNN
F 2 "" H 3600 1550 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT04.pdf" H 3600 1550 50  0001 C CNN
	4    3600 1550
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC04 U8
U 6 1 5FEDEC65
P 3600 900
F 0 "U8" H 3600 1217 50  0000 C CNN
F 1 "74HCT04" H 3600 1126 50  0000 C CNN
F 2 "" H 3600 900 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT04.pdf" H 3600 900 50  0001 C CNN
	6    3600 900 
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC00 U9
U 4 1 5FEE132F
P 7300 1550
F 0 "U9" H 7300 1875 50  0000 C CNN
F 1 "74AHCT00" H 7300 1784 50  0000 C CNN
F 2 "" H 7300 1550 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74hc00" H 7300 1550 50  0001 C CNN
	4    7300 1550
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC74 U7
U 2 1 5FF0BEEA
P 6450 2250
F 0 "U7" H 6300 2500 50  0000 C CNN
F 1 "74HCT74" H 6650 2500 50  0000 C CNN
F 2 "" H 6450 2250 50  0001 C CNN
F 3 "74xx/74hc_hct74.pdf" H 6450 2250 50  0001 C CNN
	2    6450 2250
	1    0    0    -1  
$EndComp
Wire Wire Line
	1300 4950 1100 4950
Wire Wire Line
	1100 4950 1100 5000
$Comp
L power:GND #PWR013
U 1 1 5FF59B89
P 1100 5000
F 0 "#PWR013" H 1100 4750 50  0001 C CNN
F 1 "GND" H 1200 5000 50  0000 C CNN
F 2 "" H 1100 5000 50  0001 C CNN
F 3 "" H 1100 5000 50  0001 C CNN
	1    1100 5000
	1    0    0    -1  
$EndComp
Wire Wire Line
	3100 1150 3200 1150
Wire Wire Line
	1300 3350 900  3350
Wire Wire Line
	900  3350 900  3400
$Comp
L power:GND #PWR010
U 1 1 5FF5E5F0
P 900 3400
F 0 "#PWR010" H 900 3150 50  0001 C CNN
F 1 "GND" H 900 3250 50  0000 C CNN
F 2 "" H 900 3400 50  0001 C CNN
F 3 "" H 900 3400 50  0001 C CNN
	1    900  3400
	1    0    0    -1  
$EndComp
Text GLabel 700  3850 0    50   Input ~ 0
~HR
Text GLabel 7150 2350 2    50   Output ~ 0
~OE
Wire Wire Line
	7150 2350 6900 2350
Text GLabel 1300 5650 0    50   Input ~ 0
~OE
Text GLabel 1300 4050 0    50   Input ~ 0
~OE
Text GLabel 1300 5450 0    50   Input ~ 0
~VR
Text Label 2100 3350 0    50   ~ 0
VA0
Text Label 2100 3450 0    50   ~ 0
VA1
Text Label 2100 3550 0    50   ~ 0
VA2
Text Label 2100 3650 0    50   ~ 0
VA3
Text Label 2100 3750 0    50   ~ 0
VA4
Text Label 2100 3850 0    50   ~ 0
VA5
Text Label 2100 3950 0    50   ~ 0
VA6
Text Label 2100 4050 0    50   ~ 0
VA7
Text Label 2100 5050 0    50   ~ 0
VA8
Text Label 2100 5150 0    50   ~ 0
VA9
NoConn ~ 2100 4950
NoConn ~ 2100 4250
$Comp
L power:VCC #PWR09
U 1 1 60086EF9
P 6200 2600
F 0 "#PWR09" H 6200 2450 50  0001 C CNN
F 1 "VCC" H 6300 2650 50  0000 C CNN
F 2 "" H 6200 2600 50  0001 C CNN
F 3 "" H 6200 2600 50  0001 C CNN
	1    6200 2600
	1    0    0    -1  
$EndComp
Wire Wire Line
	6200 2600 6450 2600
Wire Wire Line
	6450 2600 6450 2550
$Comp
L power:VCC #PWR04
U 1 1 600909D0
P 6450 1950
F 0 "#PWR04" H 6450 1800 50  0001 C CNN
F 1 "VCC" H 6465 2123 50  0000 C CNN
F 2 "" H 6450 1950 50  0001 C CNN
F 3 "" H 6450 1950 50  0001 C CNN
	1    6450 1950
	1    0    0    -1  
$EndComp
Connection ~ 6900 2350
Wire Wire Line
	6900 2350 6750 2350
Text GLabel 7150 2150 2    50   Output ~ 0
PHI2
Wire Wire Line
	8200 2000 8450 2000
Wire Wire Line
	8450 2000 8450 1950
$Comp
L power:VCC #PWR06
U 1 1 600B372D
P 8200 2000
F 0 "#PWR06" H 8200 1850 50  0001 C CNN
F 1 "VCC" H 8300 2050 50  0000 C CNN
F 2 "" H 8200 2000 50  0001 C CNN
F 3 "" H 8200 2000 50  0001 C CNN
	1    8200 2000
	1    0    0    -1  
$EndComp
Wire Wire Line
	6800 1450 7000 1450
Text GLabel 8750 1550 2    50   Output ~ 0
~WE
Wire Wire Line
	8150 1250 8450 1250
Wire Wire Line
	8450 1250 8450 1350
Wire Wire Line
	5450 800  5650 800 
Text GLabel 5650 800  2    50   Output ~ 0
~ROMOE
Text GLabel 1300 3650 0    50   Input ~ 0
CLK1
Text GLabel 1300 5250 0    50   Input ~ 0
CLK1
Text GLabel 3900 1150 2    50   Output ~ 0
CLK4
Text GLabel 1300 3550 0    50   Input ~ 0
CLK4
Text GLabel 8150 1250 0    50   Input ~ 0
~CLK4
Text GLabel 5900 2150 0    50   Input ~ 0
CLK4
Text GLabel 1750 2500 2    50   Output ~ 0
CLK1
Wire Wire Line
	1600 2500 1750 2500
Connection ~ 1600 1850
Wire Wire Line
	1600 1850 2100 1850
Wire Wire Line
	800  1550 800  1850
$Comp
L power:GND #PWR08
U 1 1 5FF52804
P 2600 2350
F 0 "#PWR08" H 2600 2100 50  0001 C CNN
F 1 "GND" H 2605 2177 50  0000 C CNN
F 2 "" H 2600 2350 50  0001 C CNN
F 3 "" H 2600 2350 50  0001 C CNN
	1    2600 2350
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR01
U 1 1 5FF5125D
P 2600 750
F 0 "#PWR01" H 2600 600 50  0001 C CNN
F 1 "VCC" H 2615 923 50  0000 C CNN
F 2 "" H 2600 750 50  0001 C CNN
F 3 "" H 2600 750 50  0001 C CNN
	1    2600 750 
	1    0    0    -1  
$EndComp
NoConn ~ 2100 1050
NoConn ~ 2100 1150
NoConn ~ 2100 1250
NoConn ~ 2100 1350
Wire Wire Line
	1400 1850 1600 1850
$Comp
L power:VCC #PWR02
U 1 1 5FF4EF83
P 1900 1500
F 0 "#PWR02" H 1900 1350 50  0001 C CNN
F 1 "VCC" H 2000 1500 50  0000 C CNN
F 2 "" H 1900 1500 50  0001 C CNN
F 3 "" H 1900 1500 50  0001 C CNN
	1    1900 1500
	1    0    0    -1  
$EndComp
Wire Wire Line
	1900 1550 2100 1550
Connection ~ 1900 1650
Wire Wire Line
	1900 1750 2100 1750
Wire Wire Line
	1900 1650 1900 1750
Wire Wire Line
	1900 1550 1900 1500
Connection ~ 1900 1550
Wire Wire Line
	1900 1650 1900 1550
Wire Wire Line
	2100 1650 1900 1650
$Comp
L power:VCC #PWR05
U 1 1 5FF4CD17
P 1900 2000
F 0 "#PWR05" H 1900 1850 50  0001 C CNN
F 1 "VCC" H 2000 2000 50  0000 C CNN
F 2 "" H 1900 2000 50  0001 C CNN
F 3 "" H 1900 2000 50  0001 C CNN
	1    1900 2000
	1    0    0    -1  
$EndComp
Wire Wire Line
	1900 2050 1900 2000
Wire Wire Line
	2100 2050 1900 2050
$Comp
L power:GND #PWR07
U 1 1 5FF4AFFC
P 1100 2150
F 0 "#PWR07" H 1100 1900 50  0001 C CNN
F 1 "GND" H 1105 1977 50  0000 C CNN
F 2 "" H 1100 2150 50  0001 C CNN
F 3 "" H 1100 2150 50  0001 C CNN
	1    1100 2150
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR03
U 1 1 5FF496A8
P 1100 1550
F 0 "#PWR03" H 1100 1400 50  0001 C CNN
F 1 "VCC" H 1115 1723 50  0000 C CNN
F 2 "" H 1100 1550 50  0001 C CNN
F 3 "" H 1100 1550 50  0001 C CNN
	1    1100 1550
	1    0    0    -1  
$EndComp
Connection ~ 1100 1550
Wire Wire Line
	800  1550 1100 1550
$Comp
L 74xx:74LS163 U1
U 1 1 5FEB4707
P 2600 1550
F 0 "U1" H 2450 2200 50  0000 C CNN
F 1 "74ACT163" H 2800 2200 50  0000 C CNN
F 2 "" H 2600 1550 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS163" H 2600 1550 50  0001 C CNN
	1    2600 1550
	1    0    0    -1  
$EndComp
$Comp
L Oscillator:CXO_DIP8 X1
U 1 1 5FEB3975
P 1100 1850
F 0 "X1" H 900 2100 50  0000 L CNN
F 1 "25.175MHz" H 1150 2100 50  0000 L CNN
F 2 "Oscillator:Oscillator_DIP-8" H 1550 1500 50  0001 C CNN
F 3 "http://cdn-reichelt.de/documents/datenblatt/B400/OSZI.pdf" H 1000 1850 50  0001 C CNN
	1    1100 1850
	1    0    0    -1  
$EndComp
Text GLabel 8150 1650 0    50   Input ~ 0
~CLK2
Text GLabel 3900 900  2    50   Output ~ 0
~CLK2
Text GLabel 3900 1550 2    50   Output ~ 0
~CLK4
Text GLabel 6150 2250 0    50   Input ~ 0
~CLK2
Wire Wire Line
	7600 1550 7650 1550
Wire Wire Line
	6900 1650 7000 1650
Wire Wire Line
	7150 2150 6900 2150
Connection ~ 6900 2150
Wire Wire Line
	6900 2150 6900 2350
Wire Wire Line
	6900 1650 6900 2150
Wire Wire Line
	3200 1550 3200 1150
Wire Wire Line
	3200 1550 3300 1550
Wire Wire Line
	3200 1150 3900 1150
Wire Wire Line
	1600 2500 1600 1850
Text GLabel 7750 800  2    50   Output ~ 0
~CPUBUS
Wire Wire Line
	7750 800  7650 800 
Wire Wire Line
	7650 800  7650 1550
Connection ~ 7650 1550
Wire Wire Line
	7650 1550 8150 1550
Wire Wire Line
	4750 6550 4750 6500
$Comp
L power:VCC #PWR015
U 1 1 603C6763
P 4750 6500
F 0 "#PWR015" H 4750 6350 50  0001 C CNN
F 1 "VCC" H 4850 6500 50  0000 C CNN
F 2 "" H 4750 6500 50  0001 C CNN
F 3 "" H 4750 6500 50  0001 C CNN
	1    4750 6500
	1    0    0    -1  
$EndComp
Text GLabel 2900 7350 0    50   Input ~ 0
~CPUBUS
Wire Wire Line
	800  5150 1300 5150
$Comp
L 74xx:74HC04 U8
U 5 1 5FEDE470
P 800 4500
F 0 "U8" V 750 4800 50  0000 R CNN
F 1 "74HCT04" V 850 4900 50  0000 R CNN
F 2 "" H 800 4500 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT04.pdf" H 800 4500 50  0001 C CNN
	5    800  4500
	0    1    1    0   
$EndComp
Wire Wire Line
	2150 5850 2100 5850
Wire Wire Line
	2150 6200 2150 5850
Wire Wire Line
	1250 6200 2150 6200
Text GLabel 1300 6850 0    50   Input ~ 0
CLK1
NoConn ~ 2100 7250
NoConn ~ 2100 7150
NoConn ~ 2100 7050
NoConn ~ 2100 6950
NoConn ~ 2100 6850
NoConn ~ 2100 6750
NoConn ~ 2100 6650
NoConn ~ 2100 7450
Text Label 2100 6550 0    50   ~ 0
VA15
Text GLabel 1300 7050 0    50   Input ~ 0
~VR
Text GLabel 1300 7250 0    50   Input ~ 0
~OE
Wire Wire Line
	1250 6550 1250 6200
Wire Wire Line
	1300 6550 1250 6550
Wire Wire Line
	1300 6750 800  6750
$Comp
L 74xx:74HC590 U4
U 1 1 5FEB5F36
P 1700 7050
F 0 "U4" H 1550 7700 50  0000 C CNN
F 1 "74HC590" H 1900 7700 50  0000 C CNN
F 2 "" H 1700 7100 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC590.pdf" H 1700 7100 50  0001 C CNN
	1    1700 7050
	1    0    0    -1  
$EndComp
Text GLabel 6400 4250 0    50   Input ~ 0
~CLK4
Entry Wire Line
	5700 3450 5800 3350
Entry Wire Line
	5700 3550 5800 3450
Entry Wire Line
	5700 3650 5800 3550
Entry Wire Line
	5700 3750 5800 3650
Entry Wire Line
	5700 3850 5800 3750
Entry Wire Line
	5700 3950 5800 3850
Entry Wire Line
	5700 4050 5800 3950
Entry Wire Line
	5700 4150 5800 4050
Entry Wire Line
	5600 3650 5700 3750
Entry Wire Line
	5600 3550 5700 3650
Entry Wire Line
	5600 3450 5700 3550
Entry Wire Line
	5600 3350 5700 3450
Entry Wire Line
	5600 3250 5700 3350
Entry Wire Line
	5600 3150 5700 3250
Entry Wire Line
	5600 3050 5700 3150
Entry Wire Line
	5600 2950 5700 3050
Wire Wire Line
	6400 4050 5800 4050
Wire Wire Line
	6400 3950 5800 3950
Wire Wire Line
	6400 3850 5800 3850
Wire Wire Line
	6400 3750 5800 3750
Wire Wire Line
	6400 3650 5800 3650
Wire Wire Line
	6400 3550 5800 3550
Wire Wire Line
	6400 3450 5800 3450
Wire Wire Line
	6400 3350 5800 3350
Wire Wire Line
	5000 3650 5600 3650
Wire Wire Line
	5000 3550 5600 3550
Wire Wire Line
	5000 3450 5600 3450
Wire Wire Line
	5000 3350 5600 3350
Wire Wire Line
	5000 3250 5600 3250
Wire Wire Line
	5000 3150 5600 3150
Wire Wire Line
	5000 3050 5600 3050
Wire Wire Line
	5000 2950 5600 2950
Text Label 6400 4050 2    50   ~ 0
VD7
Text Label 6400 3950 2    50   ~ 0
VD6
Text Label 6400 3850 2    50   ~ 0
VD5
Text Label 6400 3750 2    50   ~ 0
VD4
Text Label 6400 3650 2    50   ~ 0
VD3
Text Label 6400 3550 2    50   ~ 0
VD2
Text Label 6400 3450 2    50   ~ 0
VD1
Text Label 6400 3350 2    50   ~ 0
VD0
Text Label 5000 3650 0    50   ~ 0
VD7
Text Label 5000 3550 0    50   ~ 0
VD6
Text Label 5000 3450 0    50   ~ 0
VD5
Text Label 5000 3350 0    50   ~ 0
VD4
Text Label 5000 3250 0    50   ~ 0
VD3
Text Label 5000 3150 0    50   ~ 0
VD2
Text Label 5000 3050 0    50   ~ 0
VD1
Text Label 5000 2950 0    50   ~ 0
VD0
Text Label 4000 4350 2    50   ~ 0
VA14
Text Label 4000 4250 2    50   ~ 0
VA13
Text Label 4000 4150 2    50   ~ 0
VA12
Text Label 4000 4050 2    50   ~ 0
VA11
Text Label 4000 3950 2    50   ~ 0
VA10
Text Label 4000 3850 2    50   ~ 0
VA9
Text Label 4000 3750 2    50   ~ 0
VA8
Text Label 4000 3650 2    50   ~ 0
VA7
Text Label 4000 3550 2    50   ~ 0
VA6
Text Label 4000 3450 2    50   ~ 0
VA5
Text Label 4000 3350 2    50   ~ 0
VA4
Text Label 4000 3250 2    50   ~ 0
VA3
Text Label 4000 3150 2    50   ~ 0
VA2
Text Label 4000 3050 2    50   ~ 0
VA1
Text Label 4000 2950 2    50   ~ 0
VA0
Wire Wire Line
	2750 4350 4000 4350
Wire Wire Line
	2750 4250 4000 4250
Wire Wire Line
	2750 4150 4000 4150
Wire Wire Line
	2750 4050 4000 4050
Wire Wire Line
	2750 3650 4000 3650
Wire Wire Line
	2750 3550 4000 3550
Wire Wire Line
	2100 6550 2550 6550
Wire Wire Line
	2100 4050 2550 4050
Wire Wire Line
	2100 3950 2550 3950
Wire Wire Line
	2100 3850 2550 3850
Wire Wire Line
	2100 3750 2550 3750
Wire Wire Line
	2100 3650 2550 3650
Wire Wire Line
	2100 3550 2550 3550
Wire Wire Line
	2100 3450 2550 3450
Wire Wire Line
	2100 3350 2550 3350
Entry Wire Line
	2650 3050 2750 2950
Entry Wire Line
	2650 3150 2750 3050
Entry Wire Line
	2650 3250 2750 3150
Entry Wire Line
	2650 3350 2750 3250
Entry Wire Line
	2650 3450 2750 3350
Entry Wire Line
	2650 3550 2750 3450
Entry Wire Line
	2650 3650 2750 3550
Entry Wire Line
	2650 3750 2750 3650
Entry Wire Line
	2650 3850 2750 3750
Entry Wire Line
	2650 3950 2750 3850
Entry Wire Line
	2650 4050 2750 3950
Entry Wire Line
	2650 4150 2750 4050
Entry Wire Line
	2650 4250 2750 4150
Entry Wire Line
	2650 4350 2750 4250
Entry Wire Line
	2550 6550 2650 6650
Entry Wire Line
	2650 4450 2750 4350
Entry Wire Line
	2550 4050 2650 4150
Entry Wire Line
	2550 3950 2650 4050
Entry Wire Line
	2550 3850 2650 3950
Entry Wire Line
	2550 3750 2650 3850
Entry Wire Line
	2550 3650 2650 3750
Entry Wire Line
	2550 3550 2650 3650
Entry Wire Line
	2550 3450 2650 3550
Entry Wire Line
	2550 3350 2650 3450
Text GLabel 5200 4150 2    50   Input ~ 0
~WE
Text GLabel 5000 4050 2    50   Input ~ 0
~OE
Wire Wire Line
	5450 3950 5450 4000
$Comp
L power:GND #PWR011
U 1 1 5FFBBB45
P 5450 4000
F 0 "#PWR011" H 5450 3750 50  0001 C CNN
F 1 "GND" H 5350 4000 50  0000 C CNN
F 2 "" H 5450 4000 50  0001 C CNN
F 3 "" H 5450 4000 50  0001 C CNN
	1    5450 4000
	1    0    0    -1  
$EndComp
Wire Wire Line
	5000 3950 5450 3950
Text GLabel 7400 4050 2    50   Output ~ 0
~VR
Text GLabel 7400 3750 2    50   Output ~ 0
~HR
Text GLabel 10750 4650 2    50   Output ~ 0
VGA_V
Text GLabel 10750 4350 2    50   Output ~ 0
VGA_H
Text GLabel 10750 4050 2    50   Output ~ 0
VGA_R
Text GLabel 10750 3650 2    50   Output ~ 0
VGA_G
Text GLabel 10750 3250 2    50   Output ~ 0
VGA_B
Wire Wire Line
	5950 4350 6400 4350
$Comp
L power:VCC #PWR012
U 1 1 5FFB261A
P 5950 4300
F 0 "#PWR012" H 5950 4150 50  0001 C CNN
F 1 "VCC" H 5950 4450 50  0000 C CNN
F 2 "" H 5950 4300 50  0001 C CNN
F 3 "" H 5950 4300 50  0001 C CNN
	1    5950 4300
	1    0    0    -1  
$EndComp
Wire Wire Line
	5950 4350 5950 4300
$Comp
L 74xx:74HC273 U6
U 1 1 5FEB7927
P 6900 3850
F 0 "U6" H 6750 4500 50  0000 C CNN
F 1 "74HCT273" H 7100 4500 50  0000 C CNN
F 2 "" H 6900 3850 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT273.pdf" H 6900 3850 50  0001 C CNN
	1    6900 3850
	1    0    0    -1  
$EndComp
Entry Wire Line
	6050 5650 6150 5750
Entry Wire Line
	6050 5750 6150 5850
Entry Wire Line
	6050 5850 6150 5950
Entry Wire Line
	6050 5950 6150 6050
Entry Wire Line
	6050 6050 6150 6150
Entry Wire Line
	6050 6150 6150 6250
Entry Wire Line
	6050 6250 6150 6350
Entry Wire Line
	6050 6350 6150 6450
Wire Wire Line
	5900 5650 6050 5650
Wire Wire Line
	5900 5750 6050 5750
Wire Wire Line
	5900 5850 6050 5850
Wire Wire Line
	5900 5950 6050 5950
Wire Wire Line
	5900 6050 6050 6050
Wire Wire Line
	5900 6150 6050 6150
Wire Wire Line
	5900 6250 6050 6250
Wire Wire Line
	5900 6350 6050 6350
Wire Wire Line
	4900 5650 4750 5650
Wire Wire Line
	4900 5750 4750 5750
Wire Wire Line
	4900 5850 4750 5850
Wire Wire Line
	4900 5950 4750 5950
Wire Wire Line
	4900 6050 4750 6050
Wire Wire Line
	4900 6150 4750 6150
Wire Wire Line
	4900 6250 4750 6250
Wire Wire Line
	4900 6350 4750 6350
Entry Wire Line
	4650 6450 4750 6350
Entry Wire Line
	4650 6350 4750 6250
Entry Wire Line
	4650 6250 4750 6150
Entry Wire Line
	4650 6150 4750 6050
Entry Wire Line
	4650 6050 4750 5950
Entry Wire Line
	4650 5950 4750 5850
Entry Wire Line
	4650 5850 4750 5750
Entry Wire Line
	4650 5750 4750 5650
$Comp
L 74xx:74HC245 U12
U 1 1 604E8E6B
P 7400 5650
F 0 "U12" H 7200 6300 50  0000 C CNN
F 1 "74AHCT245" H 7650 6300 50  0000 C CNN
F 2 "" H 7400 5650 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC245" H 7400 5650 50  0001 C CNN
	1    7400 5650
	1    0    0    -1  
$EndComp
Wire Wire Line
	6900 6050 6750 6050
Wire Wire Line
	6750 6050 6750 6000
$Comp
L power:VCC #PWR014
U 1 1 604E8E73
P 6750 6000
F 0 "#PWR014" H 6750 5850 50  0001 C CNN
F 1 "VCC" H 6850 6000 50  0000 C CNN
F 2 "" H 6750 6000 50  0001 C CNN
F 3 "" H 6750 6000 50  0001 C CNN
	1    6750 6000
	1    0    0    -1  
$EndComp
Text GLabel 6900 6150 0    50   Input ~ 0
~CPUBUS
Entry Wire Line
	8200 5150 8300 5250
Entry Wire Line
	8200 5250 8300 5350
Entry Wire Line
	8200 5350 8300 5450
Entry Wire Line
	8200 5450 8300 5550
Entry Wire Line
	8200 5550 8300 5650
Entry Wire Line
	8200 5650 8300 5750
Entry Wire Line
	8200 5750 8300 5850
Entry Wire Line
	8200 5850 8300 5950
Wire Wire Line
	7900 5150 8200 5150
Wire Wire Line
	7900 5250 8200 5250
Wire Wire Line
	7900 5350 8200 5350
Wire Wire Line
	7900 5450 8200 5450
Wire Wire Line
	7900 5550 8200 5550
Wire Wire Line
	7900 5650 8200 5650
Wire Wire Line
	7900 5750 8200 5750
Wire Wire Line
	7900 5850 8200 5850
Wire Wire Line
	6900 5150 6600 5150
Wire Wire Line
	6900 5250 6600 5250
Wire Wire Line
	6900 5350 6600 5350
Wire Wire Line
	6900 5450 6600 5450
Wire Wire Line
	6900 5550 6600 5550
Wire Wire Line
	6900 5650 6600 5650
Wire Wire Line
	6900 5750 6600 5750
Wire Wire Line
	6900 5850 6600 5850
Entry Wire Line
	6500 5950 6600 5850
Entry Wire Line
	6500 5850 6600 5750
Entry Wire Line
	6500 5750 6600 5650
Entry Wire Line
	6500 5650 6600 5550
Entry Wire Line
	6500 5550 6600 5450
Entry Wire Line
	6500 5450 6600 5350
Entry Wire Line
	6500 5350 6600 5250
Entry Wire Line
	6500 5250 6600 5150
Text Label 6900 5150 2    50   ~ 0
D0
Text Label 6900 5250 2    50   ~ 0
D1
Text Label 6900 5350 2    50   ~ 0
D2
Text Label 6900 5450 2    50   ~ 0
D3
Text Label 6900 5550 2    50   ~ 0
D4
Text Label 6900 5650 2    50   ~ 0
D5
Text Label 6900 5750 2    50   ~ 0
D6
Text Label 6900 5850 2    50   ~ 0
D7
Text Label 7900 5150 0    50   ~ 0
VD0
Text Label 7900 5250 0    50   ~ 0
VD1
Text Label 7900 5350 0    50   ~ 0
VD2
Text Label 7900 5450 0    50   ~ 0
VD3
Text Label 7900 5550 0    50   ~ 0
VD4
Text Label 7900 5650 0    50   ~ 0
VD5
Text Label 7900 5750 0    50   ~ 0
VD6
Text Label 7900 5850 0    50   ~ 0
VD7
Text Label 5700 4750 0    50   ~ 0
VD[0..7]
$Comp
L 74xx:74HC245 U10
U 1 1 605BFF2C
P 3700 6150
F 0 "U10" H 3500 6800 50  0000 C CNN
F 1 "74AHCT245" H 3950 6800 50  0000 C CNN
F 2 "" H 3700 6150 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC245" H 3700 6150 50  0001 C CNN
	1    3700 6150
	1    0    0    -1  
$EndComp
Entry Wire Line
	4400 5650 4500 5750
Entry Wire Line
	4400 5750 4500 5850
Entry Wire Line
	4400 5850 4500 5950
Entry Wire Line
	4400 5950 4500 6050
Entry Wire Line
	4400 6050 4500 6150
Entry Wire Line
	4400 6150 4500 6250
Entry Wire Line
	4400 6250 4500 6350
Wire Wire Line
	4200 5650 4400 5650
Wire Wire Line
	4200 5750 4400 5750
Wire Wire Line
	4200 5850 4400 5850
Wire Wire Line
	4200 5950 4400 5950
Wire Wire Line
	4200 6050 4400 6050
Wire Wire Line
	4200 6150 4400 6150
Wire Wire Line
	4200 6250 4400 6250
Wire Wire Line
	800  4800 800  5150
Connection ~ 800  5150
Wire Wire Line
	800  4200 800  3850
Wire Wire Line
	800  3850 1300 3850
Wire Wire Line
	700  3850 800  3850
Connection ~ 800  3850
Wire Wire Line
	800  5150 800  6750
Wire Bus Line
	4500 5150 6150 5150
Wire Bus Line
	2650 5150 4500 5150
Connection ~ 4500 5150
Connection ~ 2650 5150
Text Label 5900 5650 0    50   ~ 0
VA0
Text Label 5900 5750 0    50   ~ 0
VA1
Text Label 5900 5850 0    50   ~ 0
VA2
Text Label 5900 5950 0    50   ~ 0
VA3
Text Label 5900 6050 0    50   ~ 0
VA4
Text Label 5900 6150 0    50   ~ 0
VA5
Text Label 5900 6250 0    50   ~ 0
VA6
Text Label 5900 6350 0    50   ~ 0
VA7
Text Label 4200 5650 0    50   ~ 0
VA8
Text Label 4200 5750 0    50   ~ 0
VA9
Text Label 4200 5850 0    50   ~ 0
VA10
Text Label 4200 5950 0    50   ~ 0
VA11
Text Label 4200 6050 0    50   ~ 0
VA12
Text Label 4200 6150 0    50   ~ 0
VA13
Text Label 4200 6250 0    50   ~ 0
VA14
Text Label 4900 5650 2    50   ~ 0
A0
Text Label 4900 5750 2    50   ~ 0
A1
Text Label 4900 5850 2    50   ~ 0
A2
Text Label 4900 5950 2    50   ~ 0
A3
Text Label 4900 6050 2    50   ~ 0
A4
Text Label 4900 6150 2    50   ~ 0
A5
Text Label 4900 6250 2    50   ~ 0
A6
Text Label 4900 6350 2    50   ~ 0
A7
Text Label 3200 5650 2    50   ~ 0
A8
Text Label 3200 5750 2    50   ~ 0
A9
Text Label 3200 5850 2    50   ~ 0
A10
Text Label 3200 5950 2    50   ~ 0
A11
Text Label 3200 6050 2    50   ~ 0
A12
Text Label 3200 6150 2    50   ~ 0
A13
Text Label 3200 6250 2    50   ~ 0
A14
Wire Bus Line
	8300 4750 5700 4750
Text Label 4500 5150 0    50   ~ 0
VA[0..14]
Wire Bus Line
	5700 7000 5700 7350
Wire Bus Line
	5700 7350 5550 7350
Wire Bus Line
	6500 7500 5550 7500
Text GLabel 5550 7500 0    50   Input ~ 0
D[0..7]
Text GLabel 5550 7350 0    50   Input ~ 0
A[0..15]
$Comp
L Device:R R1
U 1 1 60906ACB
P 9700 3250
F 0 "R1" V 9493 3250 50  0000 C CNN
F 1 "470" V 9584 3250 50  0000 C CNN
F 2 "" V 9630 3250 50  0001 C CNN
F 3 "~" H 9700 3250 50  0001 C CNN
	1    9700 3250
	0    1    1    0   
$EndComp
$Comp
L Device:R R3
U 1 1 60907928
P 9700 4050
F 0 "R3" V 9493 4050 50  0000 C CNN
F 1 "470" V 9584 4050 50  0000 C CNN
F 2 "" V 9630 4050 50  0001 C CNN
F 3 "~" H 9700 4050 50  0001 C CNN
	1    9700 4050
	0    1    1    0   
$EndComp
Wire Wire Line
	9850 3250 10000 3250
Wire Wire Line
	9850 4050 10000 4050
Wire Wire Line
	10000 3250 10300 3250
Connection ~ 10000 3250
Wire Wire Line
	10000 3650 10300 3650
Connection ~ 10000 3650
$Comp
L Device:R R7
U 1 1 609A5C81
P 10450 3250
F 0 "R7" V 10243 3250 50  0000 C CNN
F 1 "220" V 10334 3250 50  0000 C CNN
F 2 "" V 10380 3250 50  0001 C CNN
F 3 "~" H 10450 3250 50  0001 C CNN
	1    10450 3250
	0    1    1    0   
$EndComp
$Comp
L Device:R R8
U 1 1 609A60F6
P 10450 3650
F 0 "R8" V 10243 3650 50  0000 C CNN
F 1 "220" V 10334 3650 50  0000 C CNN
F 2 "" V 10380 3650 50  0001 C CNN
F 3 "~" H 10450 3650 50  0001 C CNN
	1    10450 3650
	0    1    1    0   
$EndComp
$Comp
L Device:R R9
U 1 1 609A6330
P 10450 4050
F 0 "R9" V 10243 4050 50  0000 C CNN
F 1 "220" V 10334 4050 50  0000 C CNN
F 2 "" V 10380 4050 50  0001 C CNN
F 3 "~" H 10450 4050 50  0001 C CNN
	1    10450 4050
	0    1    1    0   
$EndComp
Wire Wire Line
	10000 3250 10000 3300
Wire Wire Line
	10000 3650 10000 3700
$Comp
L Device:R R5
U 1 1 6094E6D5
P 10000 3850
F 0 "R5" H 9930 3804 50  0000 R CNN
F 1 "680" H 9930 3895 50  0000 R CNN
F 2 "" V 9930 3850 50  0001 C CNN
F 3 "~" H 10000 3850 50  0001 C CNN
	1    10000 3850
	-1   0    0    1   
$EndComp
$Comp
L Device:R R4
U 1 1 6094DFE8
P 10000 3450
F 0 "R4" H 9930 3404 50  0000 R CNN
F 1 "680" H 9930 3495 50  0000 R CNN
F 2 "" V 9930 3450 50  0001 C CNN
F 3 "~" H 10000 3450 50  0001 C CNN
	1    10000 3450
	-1   0    0    1   
$EndComp
Wire Wire Line
	10600 4050 10750 4050
Wire Wire Line
	10600 3650 10750 3650
Wire Wire Line
	10600 3250 10750 3250
Wire Wire Line
	7400 3950 7700 3950
Wire Wire Line
	7800 3850 7400 3850
Wire Wire Line
	7700 3950 7700 4650
Wire Wire Line
	7700 4650 10750 4650
Wire Wire Line
	7800 3850 7800 4550
Wire Wire Line
	7800 4550 10450 4550
Wire Notes Line
	7100 2050 7400 2050
Wire Notes Line
	7400 2050 7400 2250
Wire Notes Line
	7400 2250 7100 2250
Wire Notes Line
	7100 2250 7100 2050
Wire Notes Line
	5600 700  6000 700 
Wire Notes Line
	6000 700  6000 900 
Wire Notes Line
	6000 900  5600 900 
Wire Notes Line
	5600 900  5600 700 
Wire Notes Line
	5650 1450 5650 1650
Wire Wire Line
	4850 7350 4850 6650
Wire Wire Line
	3150 7350 3150 6650
Wire Wire Line
	10450 4550 10450 4350
Wire Wire Line
	10450 4350 10750 4350
Wire Notes Line
	5150 7250 5600 7250
Wire Notes Line
	5600 7250 5600 7600
Wire Notes Line
	5600 7600 5150 7600
Wire Notes Line
	5150 7600 5150 7250
Wire Wire Line
	4750 6550 4900 6550
Wire Wire Line
	4900 6650 4850 6650
$Comp
L 74xx:74HC245 U11
U 1 1 5FEF85BF
P 5400 6150
F 0 "U11" H 5200 6800 50  0000 C CNN
F 1 "74AHCT245" H 5650 6800 50  0000 C CNN
F 2 "" H 5400 6150 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC245" H 5400 6150 50  0001 C CNN
	1    5400 6150
	1    0    0    -1  
$EndComp
Wire Wire Line
	3200 6650 3150 6650
Wire Wire Line
	5200 4150 5000 4150
Wire Wire Line
	5900 2150 6150 2150
Text Notes 7400 7500 0    71   ~ 14
Simple VGA extension to BE6502 - 320x200 variant
Text Notes 8150 7650 0    71   ~ 14
13/03/2021
Text Notes 10600 7650 0    71   ~ 14
1
Text Notes 7000 7100 0    47   ~ 0
Simple 320x200 VGA extension to BE6502.  The output mode is based on 640x400.  Video memory overlays \nROM and is write-only.\n\nChips specified here are the ones I've used, but aren't necessarily required, e.g. substituting HCT for AHCT might\nbe fine in some or all cases.\n\nSome VCC and GND connections have been left out to save space, but of course they should all be connected.
Wire Bus Line
	4650 7000 5700 7000
Wire Wire Line
	2900 7350 3150 7350
Connection ~ 3150 7350
Wire Wire Line
	3150 7350 4850 7350
Wire Wire Line
	3200 900  3300 900 
Wire Wire Line
	3200 900  3200 1050
Wire Wire Line
	3200 1050 3100 1050
Connection ~ 3200 1150
$Comp
L 74xx:74HC00 U9
U 2 1 5FEDF6C0
P 10500 2150
F 0 "U9" H 10500 2475 50  0000 C CNN
F 1 "74AHCT00" H 10500 2384 50  0000 C CNN
F 2 "" H 10500 2150 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74hc00" H 10500 2150 50  0001 C CNN
	2    10500 2150
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC00 U9
U 1 1 5FEBEECE
P 10500 1600
F 0 "U9" H 10500 1925 50  0000 C CNN
F 1 "74AHCT00" H 10500 1834 50  0000 C CNN
F 2 "" H 10500 1600 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74hc00" H 10500 1600 50  0001 C CNN
	1    10500 1600
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC00 U9
U 3 1 5FEE0C64
P 5900 1450
F 0 "U9" H 5900 1775 50  0000 C CNN
F 1 "74AHCT00" H 5900 1684 50  0000 C CNN
F 2 "" H 5900 1450 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74hc00" H 5900 1450 50  0001 C CNN
	3    5900 1450
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC04 U8
U 3 1 5FEDD03F
P 6500 1450
F 0 "U8" H 6500 1767 50  0000 C CNN
F 1 "74HCT04" H 6500 1676 50  0000 C CNN
F 2 "" H 6500 1450 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT04.pdf" H 6500 1450 50  0001 C CNN
	3    6500 1450
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC04 U8
U 1 1 5FED8473
P 5000 1350
F 0 "U8" H 5000 1667 50  0000 C CNN
F 1 "74HCT04" H 5000 1576 50  0000 C CNN
F 2 "" H 5000 1350 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT04.pdf" H 5000 1350 50  0001 C CNN
	1    5000 1350
	1    0    0    -1  
$EndComp
Wire Notes Line
	4500 1250 4750 1250
Wire Notes Line
	4750 1250 4750 1450
Wire Notes Line
	4500 1450 4500 1250
Wire Notes Line
	4750 1450 4500 1450
Wire Notes Line
	5350 1650 5350 1450
Wire Notes Line
	5650 1650 5350 1650
Wire Notes Line
	5350 1450 5650 1450
Text GLabel 5600 1550 0    50   Input ~ 0
A15
Text GLabel 4700 1350 0    50   Input ~ 0
R~W
Wire Wire Line
	5450 1350 5600 1350
Connection ~ 5450 1350
Wire Wire Line
	5450 1350 5450 800 
Wire Wire Line
	5300 1350 5450 1350
NoConn ~ 10800 1050
NoConn ~ 10800 1600
NoConn ~ 10800 2150
Wire Wire Line
	10200 1050 10150 1050
Wire Wire Line
	10150 1050 10150 1500
Wire Wire Line
	10200 2250 10150 2250
Connection ~ 10150 2250
Wire Wire Line
	10150 2250 10150 2400
Wire Wire Line
	10200 2050 10150 2050
Connection ~ 10150 2050
Wire Wire Line
	10150 2050 10150 2250
Wire Wire Line
	10200 1700 10150 1700
Connection ~ 10150 1700
Wire Wire Line
	10150 1700 10150 2050
Wire Wire Line
	10200 1500 10150 1500
Connection ~ 10150 1500
Wire Wire Line
	10150 1500 10150 1700
$Comp
L power:GND #PWR017
U 1 1 60202E8E
P 10150 2400
F 0 "#PWR017" H 10150 2150 50  0001 C CNN
F 1 "GND" H 10155 2227 50  0000 C CNN
F 2 "" H 10150 2400 50  0001 C CNN
F 3 "" H 10150 2400 50  0001 C CNN
	1    10150 2400
	1    0    0    -1  
$EndComp
NoConn ~ 8750 1750
NoConn ~ 3100 1250
NoConn ~ 3100 1350
NoConn ~ 3100 1550
NoConn ~ 6750 2150
Wire Wire Line
	7400 3650 7700 3650
Wire Wire Line
	7700 3650 7700 3750
Wire Wire Line
	7700 3750 8300 3750
Wire Wire Line
	8300 3650 7800 3650
Wire Wire Line
	7800 3650 7800 3550
Wire Wire Line
	7400 3550 7800 3550
Wire Wire Line
	7400 3450 8300 3450
Wire Wire Line
	7400 3350 8300 3350
Wire Wire Line
	8300 4050 8250 4050
Wire Wire Line
	8250 4050 8250 4100
$Comp
L power:GND #PWR019
U 1 1 60701C51
P 8250 4100
F 0 "#PWR019" H 8250 3850 50  0001 C CNN
F 1 "GND" H 8255 3927 50  0000 C CNN
F 2 "" H 8250 4100 50  0001 C CNN
F 3 "" H 8250 4100 50  0001 C CNN
	1    8250 4100
	1    0    0    -1  
$EndComp
NoConn ~ 9300 2750
NoConn ~ 9300 3050
Wire Wire Line
	8300 3150 8250 3150
Wire Wire Line
	8250 3150 8250 3050
Wire Wire Line
	8250 3050 8300 3050
Wire Wire Line
	8250 3050 8250 2850
Wire Wire Line
	8250 2850 8300 2850
Connection ~ 8250 3050
Wire Wire Line
	8250 2850 8250 2750
Wire Wire Line
	8250 2750 8300 2750
Connection ~ 8250 2850
Wire Wire Line
	8250 2750 8250 2700
Connection ~ 8250 2750
$Comp
L power:VCC #PWR018
U 1 1 6078A8B9
P 8250 2700
F 0 "#PWR018" H 8250 2550 50  0001 C CNN
F 1 "VCC" H 8265 2873 50  0000 C CNN
F 2 "" H 8250 2700 50  0001 C CNN
F 3 "" H 8250 2700 50  0001 C CNN
	1    8250 2700
	1    0    0    -1  
$EndComp
Wire Wire Line
	4600 2100 4500 2100
Wire Wire Line
	3900 2100 3800 2100
Wire Wire Line
	5450 2750 8000 2750
Wire Wire Line
	8000 2750 8000 3950
Wire Wire Line
	8000 3950 8300 3950
Wire Wire Line
	3200 1550 3200 2100
Connection ~ 3200 1550
$Comp
L 74xx:74HC04 U13
U 4 1 607D1AF3
P 4900 2100
F 0 "U13" H 4900 2417 50  0000 C CNN
F 1 "74HCT04" H 4900 2326 50  0000 C CNN
F 2 "" H 4900 2100 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT04.pdf" H 4900 2100 50  0001 C CNN
	4    4900 2100
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC04 U13
U 5 1 607D1150
P 4200 2100
F 0 "U13" H 4200 2417 50  0000 C CNN
F 1 "74HCT04" H 4200 2326 50  0000 C CNN
F 2 "" H 4200 2100 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT04.pdf" H 4200 2100 50  0001 C CNN
	5    4200 2100
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC04 U13
U 6 1 607D03E8
P 3500 2100
F 0 "U13" H 3500 2417 50  0000 C CNN
F 1 "74HCT04" H 3500 2326 50  0000 C CNN
F 2 "" H 3500 2100 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT04.pdf" H 3500 2100 50  0001 C CNN
	6    3500 2100
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS157 U14
U 1 1 605F78BA
P 8800 3350
F 0 "U14" H 8650 4100 50  0000 C CNN
F 1 "74LS157" H 9000 4100 50  0000 C CNN
F 2 "" H 8800 3350 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS157" H 8800 3350 50  0001 C CNN
	1    8800 3350
	1    0    0    -1  
$EndComp
Connection ~ 10000 4050
Wire Wire Line
	10000 4050 10300 4050
Wire Wire Line
	10000 4000 10000 4050
Wire Wire Line
	10000 3600 10000 3650
Wire Wire Line
	9550 3250 9400 3250
Wire Wire Line
	9400 3250 9400 3350
Wire Wire Line
	9400 3350 9300 3350
Wire Wire Line
	9300 3650 9400 3650
Wire Wire Line
	9400 3650 9400 4050
Wire Wire Line
	9400 4050 9550 4050
Wire Wire Line
	2750 3950 4000 3950
Wire Wire Line
	2750 3850 4000 3850
Wire Wire Line
	2750 3750 4000 3750
Wire Wire Line
	2750 3450 4000 3450
Wire Wire Line
	2750 3350 4000 3350
Wire Wire Line
	2750 3250 4000 3250
Wire Wire Line
	2750 3150 4000 3150
Wire Wire Line
	2750 3050 4000 3050
Wire Wire Line
	2750 2950 4000 2950
Wire Notes Line
	8400 5100 11100 5100
Wire Notes Line
	11100 5100 11100 6100
Wire Notes Line
	11100 6100 8400 6100
Wire Notes Line
	8400 6100 8400 5100
Text Notes 8450 6050 0    47   ~ 0
This is a further extension on top of 320x100, to double the vertical \nresolution to 320x200.\n\nThe changes involve bringing an extra bit from counter U3, upgrading\nthe RAM to at least 64K, and routing another bit through transceiver \nU10 from a bank register, e.g. port B of the 6522.\n\nPlease refer to the earlier schematics for more notes.\n
Text Notes 8450 5300 0    79   ~ 16
https://github.com/gfoot/simplevga6502
$Comp
L Memory_RAM:AS6C4008-55PCN U5
U 1 1 6062127E
P 4500 3850
F 0 "U5" H 4500 5131 50  0000 C CNN
F 1 "AS6C4008-55PCN" H 4500 5040 50  0000 C CNN
F 2 "Package_DIP:DIP-32_W15.24mm" H 4500 3950 50  0001 C CNN
F 3 "https://www.alliancememory.com/wp-content/uploads/pdf/AS6C4008.pdf" H 4500 3950 50  0001 C CNN
	1    4500 3850
	1    0    0    -1  
$EndComp
Wire Wire Line
	5450 2750 5450 2100
Wire Wire Line
	5450 2100 5200 2100
Text Label 4000 4450 2    50   ~ 0
VA15
Wire Wire Line
	2750 4450 4000 4450
Entry Wire Line
	2650 4450 2750 4350
Entry Wire Line
	2650 4550 2750 4450
NoConn ~ 4000 4550
NoConn ~ 4000 4650
NoConn ~ 4000 4750
Entry Wire Line
	2550 5050 2650 5150
Entry Wire Line
	2550 5150 2650 5250
Entry Wire Line
	2550 5250 2650 5350
Entry Wire Line
	2550 5350 2650 5450
Entry Wire Line
	2550 5450 2650 5550
Entry Wire Line
	2550 5550 2650 5650
Wire Wire Line
	2100 5050 2550 5050
Wire Wire Line
	2100 5150 2550 5150
Wire Wire Line
	2100 5250 2550 5250
Wire Wire Line
	2100 5350 2550 5350
Wire Wire Line
	2100 5450 2550 5450
Wire Wire Line
	2100 5550 2550 5550
Text Label 2100 5550 0    50   ~ 0
VA13
Text Label 2100 5450 0    50   ~ 0
VA12
Text Label 2100 5350 0    50   ~ 0
VA11
Text Label 2100 5250 0    50   ~ 0
VA10
Entry Wire Line
	2550 5550 2650 5650
Entry Wire Line
	2550 5650 2650 5750
Wire Wire Line
	2100 5650 2550 5650
Text Label 2100 5650 0    50   ~ 0
VA14
Entry Wire Line
	4400 6250 4500 6350
Entry Wire Line
	4400 6350 4500 6450
Wire Wire Line
	4200 6350 4400 6350
Text Label 4200 6350 0    50   ~ 0
VA15
Connection ~ 4650 7000
Text GLabel 2900 7200 0    50   Input ~ 0
BANK0
Wire Wire Line
	2950 6350 3200 6350
Wire Wire Line
	2950 7200 2900 7200
Wire Wire Line
	2950 6350 2950 7200
Wire Bus Line
	2800 7000 4650 7000
Wire Wire Line
	3050 6550 3200 6550
Entry Wire Line
	2800 5750 2900 5650
Entry Wire Line
	2800 5850 2900 5750
Entry Wire Line
	2800 5950 2900 5850
Entry Wire Line
	2800 6050 2900 5950
Entry Wire Line
	2800 6150 2900 6050
Entry Wire Line
	2800 6250 2900 6150
Entry Wire Line
	2800 6350 2900 6250
Wire Wire Line
	3200 6250 2900 6250
Wire Wire Line
	3200 6150 2900 6150
Wire Wire Line
	3200 6050 2900 6050
Wire Wire Line
	3200 5950 2900 5950
Wire Wire Line
	3200 5850 2900 5850
Wire Wire Line
	3200 5750 2900 5750
Wire Wire Line
	3200 5650 2900 5650
$Comp
L power:VCC #PWR016
U 1 1 605BFF34
P 3050 6500
F 0 "#PWR016" H 3050 6350 50  0001 C CNN
F 1 "VCC" H 3150 6500 50  0000 C CNN
F 2 "" H 3050 6500 50  0001 C CNN
F 3 "" H 3050 6500 50  0001 C CNN
	1    3050 6500
	1    0    0    -1  
$EndComp
Wire Wire Line
	3050 6550 3050 6500
Wire Bus Line
	2650 5150 2650 6650
Wire Bus Line
	2800 5750 2800 7000
Wire Bus Line
	4500 5150 4500 6450
Wire Bus Line
	6500 5250 6500 7500
Wire Bus Line
	8300 4750 8300 5950
Wire Bus Line
	4650 5750 4650 7000
Wire Bus Line
	6150 5150 6150 6450
Wire Bus Line
	5700 3050 5700 4750
Wire Bus Line
	2650 3050 2650 5150
$EndSCHEMATC
