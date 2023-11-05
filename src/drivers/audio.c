#include "audio.h"


// Возможно не работает

// Звук при помощи внутренних устройств
void play_sound(u32 nFrequence) {
        u32 Div;
        u8 tmp;

        Div = 1193180 / nFrequence;
        port_byte_out(0x43, 0xb6);
        port_byte_out(0x42, (u8) (Div) );
        port_byte_out(0x42, (u8) (Div >> 8));

        tmp = port_byte_in(0x61);
        if (tmp != (tmp | 3)) {
                port_byte_out(0x61, tmp | 3);
        }

}

void nosound() {
        u8 tmp = port_byte_in(0x61) & 0xFC;
        port_byte_out(0x61, tmp);
}

void beep() {
        play_sound(1000);
        nosound();
        //set_PIT_2(old_frequency);
}
