( Embedded Systems - Sistemi Embedded - 17873 )
( Some code for NUCLEO STM32F446RE )
( Daniele Peri, Università degli Studi di Palermo, 17-18 )

: GPIO{  ( addr -- )  ;
: PORT   ( addr -- addr )  DUP CONSTANT $0400 + ;
: }GPIO  ( addr -- )  DROP ;

$40020000 
GPIO{  PORT GPIOA  PORT GPIOB  PORT GPIOC ( ... ) }GPIO
( More GPIO port definitions could be added... )

: REGS{  0  ;
: OFFSET>REGS  ( u -- ) NIP ;
: REG  <builds  DUP , OVER + DOES> @ + ; \ OVER (1 2 - 1 2 1) 
: }REGS  2DROP ;

$04 REGS{
	REG MODER  REG OTYPER  REG OSPEEDR
	REG PUPDR  REG IDR     REG ODR
	REG BSSR   REG LCKR    REG AFRL
	REG AFRH
}REGS

: DELAY  0 DO LOOP ;
: 1BIT   $1 1 ;
: 2BIT   $3 2 ;
: 4BIT   $F 4 ;
: MASK  ( index mask width -- offset_mask ) ROT * LSHIFT ; \ ROT ( 1 2 3 - 2 3 1)
: PIN   SWAP 1BIT MASK SWAP ;
: MODE   OVER 2BIT MASK SWAP ;
: MODE!   >R R@ MODE @ SWAP NOT AND ROT 3 AND ROT 2 * LSHIFT OR R> ! ; \ to R -> from R
: BIT  ( mask addr -- addr value mask )  DUP @ ROT ;
: TRUTH  ( addr value mask -- value )  AND 0<> NIP ; \ NIP (1 2 - 2)
: OUT@   ODR PIN BIT TRUTH ;
: OUT!   ODR PIN BIT SWAP OVER NOT AND >R ROT AND R> OR SWAP ! ;

: BUTTON   $2000 GPIOC IDR ; \ Same as 13 GPIOC IDR PIN 
: RELEASED  BIT TRUTH ;
: PRESSED   RELEASED NOT ;
: ?BUTTON   BUTTON PRESSED ;
: CLICKED   BEGIN 2DUP PRESSED UNTIL  BEGIN 2DUP RELEASED UNTIL 2DROP ;

: 1ms 3000 ;
: 1s  1ms 1000 *  ;
: 1m  1s 60 *  ; 
: 1h 1m 60 * ;
