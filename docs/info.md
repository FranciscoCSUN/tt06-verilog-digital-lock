<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

The digital lock uses 4 button inputs. 4 combinations are allowed. If the incorrect one is used, the seven segment display says 'err' and the last led will be on, otherwise it will say 'open' and all of the leds will be on. Usign the rstn button, the lock is reset and can take in another combination.

## How to test

Project can be used from a verilog simulator to test different inputs and get an output.

## External hardware

5 pushbuttons
4 leds
1 4-digit seven segment display
