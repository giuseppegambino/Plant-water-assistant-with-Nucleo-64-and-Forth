# Plant-water-assistant-with-Nucleo-64-and-Forth

<img src="/setup.jpg" width="600">

Documentation of ready-to-use application created for the Embedded Systems class held by Professor Daniele Peri in the A.Y. 2019/2020.

The aim of the project is to create an application that shows the percentage of soil moisture in a plant, indicating to the user if the time for watering has come or if it is convenient to wait to avoid stagnation of water.
All through the use of the Nucleo-64 microcontroller with Mecrisp Stellaris installed, a FORTH-based system.

<h3>Hardware</h3>
The hardware used are:
  - Nucleo-64 microcontroller, NUCLEO-F446RE STM32 STMicroelectronics
  - Analog soil moisture sensor, ICStation 3274
  - LCD display 1602, AZDelivery HD44780
  - Breadboard 400
  - Potentiometer 10K Ω
  - Jumper cables
  - Mini-USB cable with charger
  
The resources used are:
  - The Reference Manual R0390 (en.DM00135183.pdf), in particular Chapter 13
  - The slides provided by the Professor regarding the Nucleo-64 STM32F446 and the 16x02 LCD display
  
The software part of the project was developed on a MacBook Pro 13 with macOS Mojave, Visual Studio Code was used as a text editor for the programming part and the system terminal to install the operating system and compile the code on the card.

The software used are:
  - Mecrisp Stellaris
  - Stlink (STMicroelectronics)
 
Have been used various source codes provided by Professor to write the application:
  - nucle64-STM32F446RE-HAL.f for the first HAL (Hardware Abstraction Layer)
  - arduino.f to use the PIN references of the Arduino board
  - LCD-1602.f for connection with the LCD display and the definition of personalized characters

These codes have been slightly modified to allow the code to be compiled in the flash memory instead of in the RAM of the card, by executing the compiletoflash command directly from the terminal. Also, there are my own custom characters instead of the example ones in the original code.

Then I developed two source codes:
  - ADC-HAL.f for the HAL relating to Nucleo-64 ADC
  - main.f for the definition of the most abstract words and for the redefinition of the word INIT
  
  
  
