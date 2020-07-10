( Embedded Systems - Sistemi Embedded )
( Some code for Nucleo STM32F446RE )
( Giuseppe Gambino, Università degli Studi di Palermo, 19-20 )

\ Must be INCLUDEd after ADC-HAL.f and LCD-1602.f

: LCD_WELCOME
    s"   SYSTEM  DOWN  " LCDTYPE 
    NEWLINE
    s" PRESS BLU BUTTON" LCDTYPE
;

: NUMBER2LCD
    DUP 10 /  48 +  LCDEMIT
    DUP 10 mod  48 +  LCDEMIT
    37 LCDEMIT
;

: DRY_SOIL  
    s" DRY SOIL   " LCDTYPE DRY
    NEWLINE
    s" MOISTURE:    " LCDTYPE  NUMBER2LCD
;

: PERFECT_SOIL 
    PLANT s"  PERFECT SOIL " LCDTYPE PLANT
    NEWLINE
    s" MOISTURE:    " LCDTYPE  NUMBER2LCD
;

: WET_SOIL 
    s" WET SOIL   " LCDTYPE WET
    NEWLINE
    s" MOISTURE:    " LCDTYPE  NUMBER2LCD
;

: MEAN  
    adc1 dr @  
    1000 1 DO adc1 dr @ + LOOP  
    1000 / 
;

: ?VALUE 
    START_CONVERSION 
    MEAN  
    99 *  4095 /
;

: ?MOISTURE
   CLEAN_LCD 
   DUP 80 > IF  WET_SOIL      ELSE
   DUP 40 > IF  PERFECT_SOIL  ELSE
                DRY_SOIL
   THEN THEN DROP
;

: INIT 
    LCD_INIT 
    LCD_WELCOME
    ADC_INIT
    BUTTON CLICKED 
    BEGIN  ADC_ON ?VALUE ADC_OFF ?MOISTURE 1m DELAY  AGAIN
;
