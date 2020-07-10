( Embedded Systems - Sistemi Embedded )
( Some code for Nucleo STM32F446RE )
( Giuseppe Gambino, Università degli Studi di Palermo, 19-20 )

\ Must be INCLUDEd after simple_hal.f

$40023800 constant RCC
$04 REGS{
   $40 OFFSET>REGS
   REG APB1ENR   REG APB2ENR
}REGS

$40012000 constant ADC1
$04 REGS{
    REG SR    REG CR1   REG CR2
    REG SMPR1 REG SMPR2 REG JOFR1
    REG JOFR2 REG JOFR3 REG JOFR4
    REG HTR   REG LTR   REG SQR1
    REG SQR2  REG SQR3  REG JSQR
    REG JDR1  REG JDR2  REG JDR3
    REG JDR4  REG DR
}REGS
$04 REGS{
    $300 OFFSET>REGS
    REG CSR  REG CCR
}REGS

8  1BIT MASK CONSTANT ADC1EN    
0  1BIT MASK CONSTANT ADON      
1  1BIT MASK CONSTANT CONT      
20 4BIT MASK CONSTANT L         \ Regular channel sequence length
4  1BIT MASK CONSTANT STRT      
30 1BIT MASK CONSTANT SWSTART   

: ADC_INIT
    ADC1EN  RCC APB2ENR bis!    \ Abilito il clock dell'adc
    ADON  ADC1 CR2 bis!         \ Accendo l'ADC
    CONT  ADC1 CR2 bis!         \ Modalità di conversione continua
    0 ADC1 SMPR1 !              \ Numero di cicli di campionamento (0 == 3, 1 == 15)
    L  ADC1 SQR1 bic!           \ Canele di tipo regular group e numero di conversioni = 1
    0 ADC1 SQR3 !               \ Seleziono il canale di input
    3 0 GPIOA MODE!             \ Setto la porta GPIOA 0 in modalità Analogica (3)
;

: ADC_ON  ADON  ADC1 CR2 bis!  ;
: ADC_OFF  ADON  ADC1 CR2 bic!  ;

: START_CONVERSION              \ Inizia la conversione dei valori
    STRT ADC1 SR bis!           \ Regular Channel Start Flag
    SWSTART ADC1 CR2 bis!       
;
