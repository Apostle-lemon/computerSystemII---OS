#include "printk.h"
#include "clock.h"
#include "proc.h"

void trap_handler(unsigned long scause, unsigned long sepc) {
    if(scause & 0x8000000000000000 != 0) { //interrupt
        if(scause == 0x8000000000000005) { //timer interrupt
            // printk("[DEBUG] Supervisor Mode Timer Interrupt\n");
            do_timer();
            clock_set_next_event();
        }
    } else { //exception
        printk("[DEBUG]: Exception, scause: %lx, sepc: %lx \n", scause, sepc);
    }
}