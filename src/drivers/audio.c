#include "audio.h"

#

// Does not work.

//Play sound using built in speaker
void play_sound(u32 nFrequence) {
        u32 Div;
        u8 tmp;

        // Set the PIT to the desired frequency.
        Div = 1193180 / nFrequence;
        port_byte_out(0x43, 0xb6);
        port_byte_out(0x42, (u8) (Div) );
        port_byte_out(0x42, (u8) (Div >> 8));

        // Play the sound using the PC speaker.
        tmp = port_byte_in(0x61);
        if (tmp != (tmp | 3)) {
                port_byte_out(0x61, tmp | 3);
        }

}

// Make it shutup.
void nosound() {
        u8 tmp = port_byte_in(0x61) & 0xFC;
        port_byte_out(0x61, tmp);
}

// Make a beep.
void beep() {
        play_sound(1000);
        nosound();
        //set_PIT_2(old_frequency);
}
