
../../vmlinux:     file format elf64-littleriscv


Disassembly of section .text:

0000000080200000 <_start>:

.section .text.init # 将代码放在.text.init段中
.globl _start # 全局符号_start
_start:
  # set the stack pointer
  la sp,boot_stack_bottom # 将栈指针指向栈底
    80200000:	00002117          	auipc	sp,0x2
    80200004:	01013103          	ld	sp,16(sp) # 80202010 <_GLOBAL_OFFSET_TABLE_+0x8>

  # DEBUG:
  rdtime a0
    80200008:	c0102573          	rdtime	a0
  jal testLemon
    8020000c:	378000ef          	jal	ra,80200384 <testLemon>

  # set stvec = _traps, and set the mode to Direct
  la a0, _traps
    80200010:	00002517          	auipc	a0,0x2
    80200014:	00853503          	ld	a0,8(a0) # 80202018 <_GLOBAL_OFFSET_TABLE_+0x10>
  li a1, 0xfffffffc
    80200018:	0010059b          	addiw	a1,zero,1
    8020001c:	02059593          	slli	a1,a1,0x20
    80200020:	ffc58593          	addi	a1,a1,-4
  and a0, a0, a1
    80200024:	00b57533          	and	a0,a0,a1
  csrw stvec, a0
    80200028:	10551073          	csrw	stvec,a0
  # 开启时钟中断
  csrr t0, sie
    8020002c:	104022f3          	csrr	t0,sie
  li t1, 0x20
    80200030:	02000313          	li	t1,32
  or t0, t0, t1 // 将第 5 位置 1 
    80200034:	0062e2b3          	or	t0,t0,t1
  csrw sie, t0
    80200038:	10429073          	csrw	sie,t0

  # set first time interrupt
  rdtime a0
    8020003c:	c0102573          	rdtime	a0
  li a1, 10000000
    80200040:	009895b7          	lui	a1,0x989
    80200044:	6805859b          	addiw	a1,a1,1664
  add a0, a0, a1
    80200048:	00b50533          	add	a0,a0,a1
  and a6, a6 , 0
    8020004c:	00087813          	andi	a6,a6,0
  and a7, a7 , 0
    80200050:	0008f893          	andi	a7,a7,0
  ecall
    80200054:	00000073          	ecall

  # set sstatus[SIE] = 1, 开启S态异常相应
  csrr t0, sstatus
    80200058:	100022f3          	csrr	t0,sstatus
  li t1, 0x2
    8020005c:	00200313          	li	t1,2
  or t0, t0, t1 // 将第 1 位置 1
    80200060:	0062e2b3          	or	t0,t0,t1
  csrw sstatus, t0
    80200064:	10029073          	csrw	sstatus,t0

  li a0,2025
    80200068:	7e900513          	li	a0,2025
  j start_kernel
    8020006c:	2dc0006f          	j	80200348 <start_kernel>

0000000080200070 <_traps>:
    .section .text.entry
    .align 2
    .globl _traps 
_traps:
    # 1. save 32 registers and sepc to stack
    addi sp, sp, -32*8
    80200070:	f0010113          	addi	sp,sp,-256
    sd x2, 8(sp)
    80200074:	00213423          	sd	sp,8(sp)
    sd x1, 0(sp)
    80200078:	00113023          	sd	ra,0(sp)
    sd x3, 16(sp)
    8020007c:	00313823          	sd	gp,16(sp)
    sd x4, 24(sp)
    80200080:	00413c23          	sd	tp,24(sp)
    sd x5, 32(sp)
    80200084:	02513023          	sd	t0,32(sp)
    sd x6, 40(sp)
    80200088:	02613423          	sd	t1,40(sp)
    sd x7, 48(sp)
    8020008c:	02713823          	sd	t2,48(sp)
    sd x8, 56(sp)
    80200090:	02813c23          	sd	s0,56(sp)
    sd x9, 64(sp)
    80200094:	04913023          	sd	s1,64(sp)
    sd x10, 72(sp)
    80200098:	04a13423          	sd	a0,72(sp)
    sd x11, 80(sp)
    8020009c:	04b13823          	sd	a1,80(sp)
    sd x12, 88(sp)
    802000a0:	04c13c23          	sd	a2,88(sp)
    sd x13, 96(sp)
    802000a4:	06d13023          	sd	a3,96(sp)
    sd x14, 104(sp)
    802000a8:	06e13423          	sd	a4,104(sp)
    sd x15, 112(sp)
    802000ac:	06f13823          	sd	a5,112(sp)
    sd x16, 120(sp)
    802000b0:	07013c23          	sd	a6,120(sp)
    sd x17, 128(sp)
    802000b4:	09113023          	sd	a7,128(sp)
    sd x18, 136(sp)
    802000b8:	09213423          	sd	s2,136(sp)
    sd x19, 144(sp)
    802000bc:	09313823          	sd	s3,144(sp)
    sd x20, 152(sp)
    802000c0:	09413c23          	sd	s4,152(sp)
    sd x21, 160(sp)
    802000c4:	0b513023          	sd	s5,160(sp)
    sd x22, 168(sp)
    802000c8:	0b613423          	sd	s6,168(sp)
    sd x23, 176(sp)
    802000cc:	0b713823          	sd	s7,176(sp)
    sd x24, 184(sp)
    802000d0:	0b813c23          	sd	s8,184(sp)
    sd x25, 192(sp) 
    802000d4:	0d913023          	sd	s9,192(sp)
    sd x26, 200(sp)
    802000d8:	0da13423          	sd	s10,200(sp)
    sd x27, 208(sp)
    802000dc:	0db13823          	sd	s11,208(sp)
    sd x28, 216(sp)
    802000e0:	0dc13c23          	sd	t3,216(sp)
    sd x29, 224(sp)
    802000e4:	0fd13023          	sd	t4,224(sp)
    sd x30, 232(sp)
    802000e8:	0fe13423          	sd	t5,232(sp)
    sd x31, 240(sp)
    802000ec:	0ff13823          	sd	t6,240(sp)
    csrr t0, sepc
    802000f0:	141022f3          	csrr	t0,sepc
    sd t0, 248(sp)
    802000f4:	0e513c23          	sd	t0,248(sp)

    # 2. call trap_handler
    csrr a0, scause
    802000f8:	14202573          	csrr	a0,scause
    csrr a1, sepc
    802000fc:	141025f3          	csrr	a1,sepc
    jal trap_handler
    80200100:	1d4000ef          	jal	ra,802002d4 <trap_handler>

    # 3. restore sepc and 32 registers (x2(sp) should be restore last) from stack
    ld t0, 248(sp)
    80200104:	0f813283          	ld	t0,248(sp)
    csrw sepc, t0
    80200108:	14129073          	csrw	sepc,t0
    ld x31, 240(sp)
    8020010c:	0f013f83          	ld	t6,240(sp)
    ld x30, 232(sp)
    80200110:	0e813f03          	ld	t5,232(sp)
    ld x29, 224(sp)
    80200114:	0e013e83          	ld	t4,224(sp)
    ld x28, 216(sp)
    80200118:	0d813e03          	ld	t3,216(sp)
    ld x27, 208(sp)
    8020011c:	0d013d83          	ld	s11,208(sp)
    ld x26, 200(sp)
    80200120:	0c813d03          	ld	s10,200(sp)
    ld x25, 192(sp)
    80200124:	0c013c83          	ld	s9,192(sp)
    ld x24, 184(sp)
    80200128:	0b813c03          	ld	s8,184(sp)
    ld x23, 176(sp)
    8020012c:	0b013b83          	ld	s7,176(sp)
    ld x22, 168(sp)
    80200130:	0a813b03          	ld	s6,168(sp)
    ld x21, 160(sp)
    80200134:	0a013a83          	ld	s5,160(sp)
    ld x20, 152(sp)
    80200138:	09813a03          	ld	s4,152(sp)
    ld x19, 144(sp)
    8020013c:	09013983          	ld	s3,144(sp)
    ld x18, 136(sp)
    80200140:	08813903          	ld	s2,136(sp)
    ld x17, 128(sp)
    80200144:	08013883          	ld	a7,128(sp)
    ld x16, 120(sp)
    80200148:	07813803          	ld	a6,120(sp)
    ld x15, 112(sp)
    8020014c:	07013783          	ld	a5,112(sp)
    ld x14, 104(sp)
    80200150:	06813703          	ld	a4,104(sp)
    ld x13, 96(sp)
    80200154:	06013683          	ld	a3,96(sp)
    ld x12, 88(sp)
    80200158:	05813603          	ld	a2,88(sp)
    ld x11, 80(sp)
    8020015c:	05013583          	ld	a1,80(sp)
    ld x10, 72(sp)
    80200160:	04813503          	ld	a0,72(sp)
    ld x9, 64(sp)
    80200164:	04013483          	ld	s1,64(sp)
    ld x8, 56(sp)
    80200168:	03813403          	ld	s0,56(sp)
    ld x7, 48(sp)
    8020016c:	03013383          	ld	t2,48(sp)
    ld x6, 40(sp)
    80200170:	02813303          	ld	t1,40(sp)
    ld x5, 32(sp)
    80200174:	02013283          	ld	t0,32(sp)
    ld x4, 24(sp)
    80200178:	01813203          	ld	tp,24(sp)
    ld x3, 16(sp)
    8020017c:	01013183          	ld	gp,16(sp)
    ld x1, 0(sp)
    80200180:	00013083          	ld	ra,0(sp)
    ld x2, 8(sp)
    80200184:	00813103          	ld	sp,8(sp)
    addi sp, sp, 32*8
    80200188:	10010113          	addi	sp,sp,256

    # 4. return from trap
    8020018c:	10200073          	sret

0000000080200190 <get_cycles>:
#include "printk.h"
#include "sbi.h"

unsigned long TIMECLOCK = 10000000;

unsigned long get_cycles() {
    80200190:	fe010113          	addi	sp,sp,-32
    80200194:	00813c23          	sd	s0,24(sp)
    80200198:	02010413          	addi	s0,sp,32
    unsigned long time;
    asm volatile("rdtime %0" : "=r"(time));
    8020019c:	c01027f3          	rdtime	a5
    802001a0:	fef43423          	sd	a5,-24(s0)
    // printk("get_cycles() get time: %lx \n", time);
    return time;
    802001a4:	fe843783          	ld	a5,-24(s0)
}
    802001a8:	00078513          	mv	a0,a5
    802001ac:	01813403          	ld	s0,24(sp)
    802001b0:	02010113          	addi	sp,sp,32
    802001b4:	00008067          	ret

00000000802001b8 <clock_set_next_event>:

void clock_set_next_event() {
    802001b8:	fe010113          	addi	sp,sp,-32
    802001bc:	00113c23          	sd	ra,24(sp)
    802001c0:	00813823          	sd	s0,16(sp)
    802001c4:	02010413          	addi	s0,sp,32
    uint64 current_time = get_cycles();
    802001c8:	fc9ff0ef          	jal	ra,80200190 <get_cycles>
    802001cc:	fea43423          	sd	a0,-24(s0)
    uint64 next = current_time + TIMECLOCK;
    802001d0:	00002797          	auipc	a5,0x2
    802001d4:	e3078793          	addi	a5,a5,-464 # 80202000 <TIMECLOCK>
    802001d8:	0007b783          	ld	a5,0(a5)
    802001dc:	fe843703          	ld	a4,-24(s0)
    802001e0:	00f707b3          	add	a5,a4,a5
    802001e4:	fef43023          	sd	a5,-32(s0)
    // printk("clock_set_next_event() current_time: %lx, next: %lx \n", current_time, next);
    sbi_ecall(SBI_SET_TIMER, 0, next, 0, 0, 0, 0, 0);
    802001e8:	00000893          	li	a7,0
    802001ec:	00000813          	li	a6,0
    802001f0:	00000793          	li	a5,0
    802001f4:	00000713          	li	a4,0
    802001f8:	00000693          	li	a3,0
    802001fc:	fe043603          	ld	a2,-32(s0)
    80200200:	00000593          	li	a1,0
    80200204:	00000513          	li	a0,0
    80200208:	018000ef          	jal	ra,80200220 <sbi_ecall>
    return;
    8020020c:	00000013          	nop
    80200210:	01813083          	ld	ra,24(sp)
    80200214:	01013403          	ld	s0,16(sp)
    80200218:	02010113          	addi	sp,sp,32
    8020021c:	00008067          	ret

0000000080200220 <sbi_ecall>:
#include "types.h"
#include "sbi.h"

struct sbiret sbi_ecall(int ext, int fid, uint64 arg0, uint64 arg1, uint64 arg2,
                        uint64 arg3, uint64 arg4, uint64 arg5)
{
    80200220:	f9010113          	addi	sp,sp,-112
    80200224:	06813423          	sd	s0,104(sp)
    80200228:	07010413          	addi	s0,sp,112
    8020022c:	fcc43023          	sd	a2,-64(s0)
    80200230:	fad43c23          	sd	a3,-72(s0)
    80200234:	fae43823          	sd	a4,-80(s0)
    80200238:	faf43423          	sd	a5,-88(s0)
    8020023c:	fb043023          	sd	a6,-96(s0)
    80200240:	f9143c23          	sd	a7,-104(s0)
    80200244:	00050793          	mv	a5,a0
    80200248:	fcf42623          	sw	a5,-52(s0)
    8020024c:	00058793          	mv	a5,a1
    80200250:	fcf42423          	sw	a5,-56(s0)
  struct sbiret ret;
  register uint64 a0 asm("a0") = (uint64)arg0;
    80200254:	fc043503          	ld	a0,-64(s0)
  register uint64 a1 asm("a1") = (uint64)arg1;
    80200258:	fb843583          	ld	a1,-72(s0)
  register uint64 a2 asm("a2") = (uint64)arg2;
    8020025c:	fb043603          	ld	a2,-80(s0)
  register uint64 a3 asm("a3") = (uint64)arg3;
    80200260:	fa843683          	ld	a3,-88(s0)
  register uint64 a4 asm("a4") = (uint64)arg4;
    80200264:	fa043703          	ld	a4,-96(s0)
  register uint64 a5 asm("a5") = (uint64)arg5;
    80200268:	f9843783          	ld	a5,-104(s0)
  register uint64 a6 asm("a6") = (uint64)fid;
    8020026c:	fc842783          	lw	a5,-56(s0)
    80200270:	00078813          	mv	a6,a5
  register uint64 a7 asm("a7") = (uint64)ext;
    80200274:	fcc42783          	lw	a5,-52(s0)
    80200278:	00078893          	mv	a7,a5

  asm volatile("ecall");
    8020027c:	00000073          	ecall
  ret.error = a0;
    80200280:	00050793          	mv	a5,a0
    80200284:	fcf43823          	sd	a5,-48(s0)
  ret.value = a1;
    80200288:	00058793          	mv	a5,a1
    8020028c:	fcf43c23          	sd	a5,-40(s0)
  return ret; 
    80200290:	fd043783          	ld	a5,-48(s0)
    80200294:	fef43023          	sd	a5,-32(s0)
    80200298:	fd843783          	ld	a5,-40(s0)
    8020029c:	fef43423          	sd	a5,-24(s0)
    802002a0:	00000713          	li	a4,0
    802002a4:	fe043703          	ld	a4,-32(s0)
    802002a8:	00000793          	li	a5,0
    802002ac:	fe843783          	ld	a5,-24(s0)
    802002b0:	00070313          	mv	t1,a4
    802002b4:	00078393          	mv	t2,a5
    802002b8:	00030713          	mv	a4,t1
    802002bc:	00038793          	mv	a5,t2
}
    802002c0:	00070513          	mv	a0,a4
    802002c4:	00078593          	mv	a1,a5
    802002c8:	06813403          	ld	s0,104(sp)
    802002cc:	07010113          	addi	sp,sp,112
    802002d0:	00008067          	ret

00000000802002d4 <trap_handler>:
#include "printk.h"
#include "clock.h"


void trap_handler(unsigned long scause, unsigned long sepc) {
    802002d4:	fe010113          	addi	sp,sp,-32
    802002d8:	00113c23          	sd	ra,24(sp)
    802002dc:	00813823          	sd	s0,16(sp)
    802002e0:	02010413          	addi	s0,sp,32
    802002e4:	fea43423          	sd	a0,-24(s0)
    802002e8:	feb43023          	sd	a1,-32(s0)
    if(scause & 0x8000000000000000 != 0) { //interrupt
    802002ec:	fe843783          	ld	a5,-24(s0)
    802002f0:	0017f793          	andi	a5,a5,1
    802002f4:	02078663          	beqz	a5,80200320 <trap_handler+0x4c>
        if(scause == 0x8000000000000005) { //timer interrupt
    802002f8:	fe843703          	ld	a4,-24(s0)
    802002fc:	fff00793          	li	a5,-1
    80200300:	03f79793          	slli	a5,a5,0x3f
    80200304:	00578793          	addi	a5,a5,5
    80200308:	02f71663          	bne	a4,a5,80200334 <trap_handler+0x60>
            printk("[S] Supervisor Mode Timer Interrupt\n");
    8020030c:	00001517          	auipc	a0,0x1
    80200310:	cf450513          	addi	a0,a0,-780 # 80201000 <_srodata>
    80200314:	638000ef          	jal	ra,8020094c <printk>
            clock_set_next_event();
    80200318:	ea1ff0ef          	jal	ra,802001b8 <clock_set_next_event>
        }
    } else { //exception
        printk("[DEBUG]: Exception, scause: %lx, sepc: %lx \n", scause, sepc);
    }
    8020031c:	0180006f          	j	80200334 <trap_handler+0x60>
        printk("[DEBUG]: Exception, scause: %lx, sepc: %lx \n", scause, sepc);
    80200320:	fe043603          	ld	a2,-32(s0)
    80200324:	fe843583          	ld	a1,-24(s0)
    80200328:	00001517          	auipc	a0,0x1
    8020032c:	d0050513          	addi	a0,a0,-768 # 80201028 <_srodata+0x28>
    80200330:	61c000ef          	jal	ra,8020094c <printk>
    80200334:	00000013          	nop
    80200338:	01813083          	ld	ra,24(sp)
    8020033c:	01013403          	ld	s0,16(sp)
    80200340:	02010113          	addi	sp,sp,32
    80200344:	00008067          	ret

0000000080200348 <start_kernel>:
#include "types.h"
#include "sbi.h"

extern void test();

int start_kernel(uint64 input) {
    80200348:	fe010113          	addi	sp,sp,-32
    8020034c:	00113c23          	sd	ra,24(sp)
    80200350:	00813823          	sd	s0,16(sp)
    80200354:	02010413          	addi	s0,sp,32
    80200358:	fea43423          	sd	a0,-24(s0)

    printk(" ZJU Computer System II\n");
    8020035c:	00001517          	auipc	a0,0x1
    80200360:	cfc50513          	addi	a0,a0,-772 # 80201058 <_srodata+0x58>
    80200364:	5e8000ef          	jal	ra,8020094c <printk>

    test(); // DO NOT DELETE !!!
    80200368:	060000ef          	jal	ra,802003c8 <test>

	return 0;
    8020036c:	00000793          	li	a5,0
}
    80200370:	00078513          	mv	a0,a5
    80200374:	01813083          	ld	ra,24(sp)
    80200378:	01013403          	ld	s0,16(sp)
    8020037c:	02010113          	addi	sp,sp,32
    80200380:	00008067          	ret

0000000080200384 <testLemon>:

void testLemon(uint64 input) {
    80200384:	fe010113          	addi	sp,sp,-32
    80200388:	00113c23          	sd	ra,24(sp)
    8020038c:	00813823          	sd	s0,16(sp)
    80200390:	02010413          	addi	s0,sp,32
    80200394:	fea43423          	sd	a0,-24(s0)
    printk("Well come to testLemon(), this will show the value of A0.\n");
    80200398:	00001517          	auipc	a0,0x1
    8020039c:	ce050513          	addi	a0,a0,-800 # 80201078 <_srodata+0x78>
    802003a0:	5ac000ef          	jal	ra,8020094c <printk>
    printk("current a0: %lx \n", input);
    802003a4:	fe843583          	ld	a1,-24(s0)
    802003a8:	00001517          	auipc	a0,0x1
    802003ac:	d1050513          	addi	a0,a0,-752 # 802010b8 <_srodata+0xb8>
    802003b0:	59c000ef          	jal	ra,8020094c <printk>
    802003b4:	00000013          	nop
    802003b8:	01813083          	ld	ra,24(sp)
    802003bc:	01013403          	ld	s0,16(sp)
    802003c0:	02010113          	addi	sp,sp,32
    802003c4:	00008067          	ret

00000000802003c8 <test>:
#include "printk.h"
#include "defs.h"

// Please do not modify

void test() {
    802003c8:	fe010113          	addi	sp,sp,-32
    802003cc:	00113c23          	sd	ra,24(sp)
    802003d0:	00813823          	sd	s0,16(sp)
    802003d4:	02010413          	addi	s0,sp,32
    unsigned long record_time = 0; 
    802003d8:	fe043423          	sd	zero,-24(s0)
    while (1) {
        unsigned long present_time;
        __asm__ volatile("rdtime %[t]" : [t] "=r" (present_time) : : "memory");
    802003dc:	c01027f3          	rdtime	a5
    802003e0:	fef43023          	sd	a5,-32(s0)
        present_time /= 10000000;
    802003e4:	fe043703          	ld	a4,-32(s0)
    802003e8:	009897b7          	lui	a5,0x989
    802003ec:	68078793          	addi	a5,a5,1664 # 989680 <_start-0x7f876980>
    802003f0:	02f757b3          	divu	a5,a4,a5
    802003f4:	fef43023          	sd	a5,-32(s0)
        if (record_time < present_time) {
    802003f8:	fe843703          	ld	a4,-24(s0)
    802003fc:	fe043783          	ld	a5,-32(s0)
    80200400:	fcf77ee3          	bgeu	a4,a5,802003dc <test+0x14>
            printk("kernel is running! Time: %lus\n", present_time);
    80200404:	fe043583          	ld	a1,-32(s0)
    80200408:	00001517          	auipc	a0,0x1
    8020040c:	cc850513          	addi	a0,a0,-824 # 802010d0 <_srodata+0xd0>
    80200410:	53c000ef          	jal	ra,8020094c <printk>
            record_time = present_time; 
    80200414:	fe043783          	ld	a5,-32(s0)
    80200418:	fef43423          	sd	a5,-24(s0)
    while (1) {
    8020041c:	fc1ff06f          	j	802003dc <test+0x14>

0000000080200420 <putc>:
#include "printk.h"
#include "sbi.h"

void putc(char c) {
    80200420:	fe010113          	addi	sp,sp,-32
    80200424:	00113c23          	sd	ra,24(sp)
    80200428:	00813823          	sd	s0,16(sp)
    8020042c:	02010413          	addi	s0,sp,32
    80200430:	00050793          	mv	a5,a0
    80200434:	fef407a3          	sb	a5,-17(s0)
  sbi_ecall(SBI_PUTCHAR, 0, c, 0, 0, 0, 0, 0);
    80200438:	fef44603          	lbu	a2,-17(s0)
    8020043c:	00000893          	li	a7,0
    80200440:	00000813          	li	a6,0
    80200444:	00000793          	li	a5,0
    80200448:	00000713          	li	a4,0
    8020044c:	00000693          	li	a3,0
    80200450:	00000593          	li	a1,0
    80200454:	00100513          	li	a0,1
    80200458:	dc9ff0ef          	jal	ra,80200220 <sbi_ecall>
}
    8020045c:	00000013          	nop
    80200460:	01813083          	ld	ra,24(sp)
    80200464:	01013403          	ld	s0,16(sp)
    80200468:	02010113          	addi	sp,sp,32
    8020046c:	00008067          	ret

0000000080200470 <vprintfmt>:

static int vprintfmt(void(*putch)(char), const char *fmt, va_list vl) {
    80200470:	f2010113          	addi	sp,sp,-224
    80200474:	0c113c23          	sd	ra,216(sp)
    80200478:	0c813823          	sd	s0,208(sp)
    8020047c:	0e010413          	addi	s0,sp,224
    80200480:	f2a43c23          	sd	a0,-200(s0)
    80200484:	f2b43823          	sd	a1,-208(s0)
    80200488:	f2c43423          	sd	a2,-216(s0)
    int in_format = 0, longarg = 0;
    8020048c:	fe042623          	sw	zero,-20(s0)
    80200490:	fe042423          	sw	zero,-24(s0)
    size_t pos = 0;
    80200494:	fe043023          	sd	zero,-32(s0)
    for( ; *fmt; fmt++) {
    80200498:	48c0006f          	j	80200924 <vprintfmt+0x4b4>
        if (in_format) {
    8020049c:	fec42783          	lw	a5,-20(s0)
    802004a0:	0007879b          	sext.w	a5,a5
    802004a4:	42078663          	beqz	a5,802008d0 <vprintfmt+0x460>
            switch(*fmt) {
    802004a8:	f3043783          	ld	a5,-208(s0)
    802004ac:	0007c783          	lbu	a5,0(a5)
    802004b0:	0007879b          	sext.w	a5,a5
    802004b4:	f9d7869b          	addiw	a3,a5,-99
    802004b8:	0006871b          	sext.w	a4,a3
    802004bc:	01500793          	li	a5,21
    802004c0:	44e7ea63          	bltu	a5,a4,80200914 <vprintfmt+0x4a4>
    802004c4:	02069793          	slli	a5,a3,0x20
    802004c8:	0207d793          	srli	a5,a5,0x20
    802004cc:	00279713          	slli	a4,a5,0x2
    802004d0:	00001797          	auipc	a5,0x1
    802004d4:	c2078793          	addi	a5,a5,-992 # 802010f0 <_srodata+0xf0>
    802004d8:	00f707b3          	add	a5,a4,a5
    802004dc:	0007a783          	lw	a5,0(a5)
    802004e0:	0007871b          	sext.w	a4,a5
    802004e4:	00001797          	auipc	a5,0x1
    802004e8:	c0c78793          	addi	a5,a5,-1012 # 802010f0 <_srodata+0xf0>
    802004ec:	00f707b3          	add	a5,a4,a5
    802004f0:	00078067          	jr	a5
                case 'l': { 
                    longarg = 1; 
    802004f4:	00100793          	li	a5,1
    802004f8:	fef42423          	sw	a5,-24(s0)
                    break; 
    802004fc:	41c0006f          	j	80200918 <vprintfmt+0x4a8>
                }
                
                case 'x': {
                    long num = longarg ? va_arg(vl, long) : va_arg(vl, int);
    80200500:	fe842783          	lw	a5,-24(s0)
    80200504:	0007879b          	sext.w	a5,a5
    80200508:	00078c63          	beqz	a5,80200520 <vprintfmt+0xb0>
    8020050c:	f2843783          	ld	a5,-216(s0)
    80200510:	00878713          	addi	a4,a5,8
    80200514:	f2e43423          	sd	a4,-216(s0)
    80200518:	0007b783          	ld	a5,0(a5)
    8020051c:	0140006f          	j	80200530 <vprintfmt+0xc0>
    80200520:	f2843783          	ld	a5,-216(s0)
    80200524:	00878713          	addi	a4,a5,8
    80200528:	f2e43423          	sd	a4,-216(s0)
    8020052c:	0007a783          	lw	a5,0(a5)
    80200530:	f8f43c23          	sd	a5,-104(s0)

                    int hexdigits = 2 * (longarg ? sizeof(long) : sizeof(int)) - 1;
    80200534:	fe842783          	lw	a5,-24(s0)
    80200538:	0007879b          	sext.w	a5,a5
    8020053c:	00078663          	beqz	a5,80200548 <vprintfmt+0xd8>
    80200540:	00f00793          	li	a5,15
    80200544:	0080006f          	j	8020054c <vprintfmt+0xdc>
    80200548:	00700793          	li	a5,7
    8020054c:	f8f42a23          	sw	a5,-108(s0)
                    for(int halfbyte = hexdigits; halfbyte >= 0; halfbyte--) {
    80200550:	f9442783          	lw	a5,-108(s0)
    80200554:	fcf42e23          	sw	a5,-36(s0)
    80200558:	0840006f          	j	802005dc <vprintfmt+0x16c>
                        int hex = (num >> (4*halfbyte)) & 0xF;
    8020055c:	fdc42783          	lw	a5,-36(s0)
    80200560:	0027979b          	slliw	a5,a5,0x2
    80200564:	0007879b          	sext.w	a5,a5
    80200568:	f9843703          	ld	a4,-104(s0)
    8020056c:	40f757b3          	sra	a5,a4,a5
    80200570:	0007879b          	sext.w	a5,a5
    80200574:	00f7f793          	andi	a5,a5,15
    80200578:	f8f42823          	sw	a5,-112(s0)
                        char hexchar = (hex < 10 ? '0' + hex : 'a' + hex - 10);
    8020057c:	f9042783          	lw	a5,-112(s0)
    80200580:	0007871b          	sext.w	a4,a5
    80200584:	00900793          	li	a5,9
    80200588:	00e7cc63          	blt	a5,a4,802005a0 <vprintfmt+0x130>
    8020058c:	f9042783          	lw	a5,-112(s0)
    80200590:	0ff7f793          	andi	a5,a5,255
    80200594:	0307879b          	addiw	a5,a5,48
    80200598:	0ff7f793          	andi	a5,a5,255
    8020059c:	0140006f          	j	802005b0 <vprintfmt+0x140>
    802005a0:	f9042783          	lw	a5,-112(s0)
    802005a4:	0ff7f793          	andi	a5,a5,255
    802005a8:	0577879b          	addiw	a5,a5,87
    802005ac:	0ff7f793          	andi	a5,a5,255
    802005b0:	f8f407a3          	sb	a5,-113(s0)
                        putch(hexchar);
    802005b4:	f8f44783          	lbu	a5,-113(s0)
    802005b8:	f3843703          	ld	a4,-200(s0)
    802005bc:	00078513          	mv	a0,a5
    802005c0:	000700e7          	jalr	a4
                        pos++;
    802005c4:	fe043783          	ld	a5,-32(s0)
    802005c8:	00178793          	addi	a5,a5,1
    802005cc:	fef43023          	sd	a5,-32(s0)
                    for(int halfbyte = hexdigits; halfbyte >= 0; halfbyte--) {
    802005d0:	fdc42783          	lw	a5,-36(s0)
    802005d4:	fff7879b          	addiw	a5,a5,-1
    802005d8:	fcf42e23          	sw	a5,-36(s0)
    802005dc:	fdc42783          	lw	a5,-36(s0)
    802005e0:	0007879b          	sext.w	a5,a5
    802005e4:	f607dce3          	bgez	a5,8020055c <vprintfmt+0xec>
                    }
                    longarg = 0; in_format = 0; 
    802005e8:	fe042423          	sw	zero,-24(s0)
    802005ec:	fe042623          	sw	zero,-20(s0)
                    break;
    802005f0:	3280006f          	j	80200918 <vprintfmt+0x4a8>
                }
            
                case 'd': {
                    long num = longarg ? va_arg(vl, long) : va_arg(vl, int);
    802005f4:	fe842783          	lw	a5,-24(s0)
    802005f8:	0007879b          	sext.w	a5,a5
    802005fc:	00078c63          	beqz	a5,80200614 <vprintfmt+0x1a4>
    80200600:	f2843783          	ld	a5,-216(s0)
    80200604:	00878713          	addi	a4,a5,8
    80200608:	f2e43423          	sd	a4,-216(s0)
    8020060c:	0007b783          	ld	a5,0(a5)
    80200610:	0140006f          	j	80200624 <vprintfmt+0x1b4>
    80200614:	f2843783          	ld	a5,-216(s0)
    80200618:	00878713          	addi	a4,a5,8
    8020061c:	f2e43423          	sd	a4,-216(s0)
    80200620:	0007a783          	lw	a5,0(a5)
    80200624:	fcf43823          	sd	a5,-48(s0)
                    if (num < 0) {
    80200628:	fd043783          	ld	a5,-48(s0)
    8020062c:	0207d463          	bgez	a5,80200654 <vprintfmt+0x1e4>
                        num = -num; putch('-');
    80200630:	fd043783          	ld	a5,-48(s0)
    80200634:	40f007b3          	neg	a5,a5
    80200638:	fcf43823          	sd	a5,-48(s0)
    8020063c:	f3843783          	ld	a5,-200(s0)
    80200640:	02d00513          	li	a0,45
    80200644:	000780e7          	jalr	a5
                        pos++;
    80200648:	fe043783          	ld	a5,-32(s0)
    8020064c:	00178793          	addi	a5,a5,1
    80200650:	fef43023          	sd	a5,-32(s0)
                    }
                    int bits = 0;
    80200654:	fc042623          	sw	zero,-52(s0)
                    char decchar[25] = {'0', 0};
    80200658:	03000793          	li	a5,48
    8020065c:	f6f43023          	sd	a5,-160(s0)
    80200660:	f6043423          	sd	zero,-152(s0)
    80200664:	f6043823          	sd	zero,-144(s0)
    80200668:	f6040c23          	sb	zero,-136(s0)
                    for (long tmp = num; tmp; bits++) {
    8020066c:	fd043783          	ld	a5,-48(s0)
    80200670:	fcf43023          	sd	a5,-64(s0)
    80200674:	0480006f          	j	802006bc <vprintfmt+0x24c>
                        decchar[bits] = (tmp % 10) + '0';
    80200678:	fc043703          	ld	a4,-64(s0)
    8020067c:	00a00793          	li	a5,10
    80200680:	02f767b3          	rem	a5,a4,a5
    80200684:	0ff7f793          	andi	a5,a5,255
    80200688:	0307879b          	addiw	a5,a5,48
    8020068c:	0ff7f713          	andi	a4,a5,255
    80200690:	fcc42783          	lw	a5,-52(s0)
    80200694:	ff040693          	addi	a3,s0,-16
    80200698:	00f687b3          	add	a5,a3,a5
    8020069c:	f6e78823          	sb	a4,-144(a5)
                        tmp /= 10;
    802006a0:	fc043703          	ld	a4,-64(s0)
    802006a4:	00a00793          	li	a5,10
    802006a8:	02f747b3          	div	a5,a4,a5
    802006ac:	fcf43023          	sd	a5,-64(s0)
                    for (long tmp = num; tmp; bits++) {
    802006b0:	fcc42783          	lw	a5,-52(s0)
    802006b4:	0017879b          	addiw	a5,a5,1
    802006b8:	fcf42623          	sw	a5,-52(s0)
    802006bc:	fc043783          	ld	a5,-64(s0)
    802006c0:	fa079ce3          	bnez	a5,80200678 <vprintfmt+0x208>
                    }

                    for (int i = bits; i >= 0; i--) {
    802006c4:	fcc42783          	lw	a5,-52(s0)
    802006c8:	faf42e23          	sw	a5,-68(s0)
    802006cc:	02c0006f          	j	802006f8 <vprintfmt+0x288>
                        putch(decchar[i]);
    802006d0:	fbc42783          	lw	a5,-68(s0)
    802006d4:	ff040713          	addi	a4,s0,-16
    802006d8:	00f707b3          	add	a5,a4,a5
    802006dc:	f707c783          	lbu	a5,-144(a5)
    802006e0:	f3843703          	ld	a4,-200(s0)
    802006e4:	00078513          	mv	a0,a5
    802006e8:	000700e7          	jalr	a4
                    for (int i = bits; i >= 0; i--) {
    802006ec:	fbc42783          	lw	a5,-68(s0)
    802006f0:	fff7879b          	addiw	a5,a5,-1
    802006f4:	faf42e23          	sw	a5,-68(s0)
    802006f8:	fbc42783          	lw	a5,-68(s0)
    802006fc:	0007879b          	sext.w	a5,a5
    80200700:	fc07d8e3          	bgez	a5,802006d0 <vprintfmt+0x260>
                    }
                    pos += bits + 1;
    80200704:	fcc42783          	lw	a5,-52(s0)
    80200708:	0017879b          	addiw	a5,a5,1
    8020070c:	0007879b          	sext.w	a5,a5
    80200710:	00078713          	mv	a4,a5
    80200714:	fe043783          	ld	a5,-32(s0)
    80200718:	00e787b3          	add	a5,a5,a4
    8020071c:	fef43023          	sd	a5,-32(s0)
                    longarg = 0; in_format = 0; 
    80200720:	fe042423          	sw	zero,-24(s0)
    80200724:	fe042623          	sw	zero,-20(s0)
                    break;
    80200728:	1f00006f          	j	80200918 <vprintfmt+0x4a8>
                }

                case 'u': {
                    unsigned long num = longarg ? va_arg(vl, long) : va_arg(vl, int);
    8020072c:	fe842783          	lw	a5,-24(s0)
    80200730:	0007879b          	sext.w	a5,a5
    80200734:	00078c63          	beqz	a5,8020074c <vprintfmt+0x2dc>
    80200738:	f2843783          	ld	a5,-216(s0)
    8020073c:	00878713          	addi	a4,a5,8
    80200740:	f2e43423          	sd	a4,-216(s0)
    80200744:	0007b783          	ld	a5,0(a5)
    80200748:	0140006f          	j	8020075c <vprintfmt+0x2ec>
    8020074c:	f2843783          	ld	a5,-216(s0)
    80200750:	00878713          	addi	a4,a5,8
    80200754:	f2e43423          	sd	a4,-216(s0)
    80200758:	0007a783          	lw	a5,0(a5)
    8020075c:	f8f43023          	sd	a5,-128(s0)
                    int bits = 0;
    80200760:	fa042c23          	sw	zero,-72(s0)
                    char decchar[25] = {'0', 0};
    80200764:	03000793          	li	a5,48
    80200768:	f4f43023          	sd	a5,-192(s0)
    8020076c:	f4043423          	sd	zero,-184(s0)
    80200770:	f4043823          	sd	zero,-176(s0)
    80200774:	f4040c23          	sb	zero,-168(s0)
                    for (long tmp = num; tmp; bits++) {
    80200778:	f8043783          	ld	a5,-128(s0)
    8020077c:	faf43823          	sd	a5,-80(s0)
    80200780:	0480006f          	j	802007c8 <vprintfmt+0x358>
                        decchar[bits] = (tmp % 10) + '0';
    80200784:	fb043703          	ld	a4,-80(s0)
    80200788:	00a00793          	li	a5,10
    8020078c:	02f767b3          	rem	a5,a4,a5
    80200790:	0ff7f793          	andi	a5,a5,255
    80200794:	0307879b          	addiw	a5,a5,48
    80200798:	0ff7f713          	andi	a4,a5,255
    8020079c:	fb842783          	lw	a5,-72(s0)
    802007a0:	ff040693          	addi	a3,s0,-16
    802007a4:	00f687b3          	add	a5,a3,a5
    802007a8:	f4e78823          	sb	a4,-176(a5)
                        tmp /= 10;
    802007ac:	fb043703          	ld	a4,-80(s0)
    802007b0:	00a00793          	li	a5,10
    802007b4:	02f747b3          	div	a5,a4,a5
    802007b8:	faf43823          	sd	a5,-80(s0)
                    for (long tmp = num; tmp; bits++) {
    802007bc:	fb842783          	lw	a5,-72(s0)
    802007c0:	0017879b          	addiw	a5,a5,1
    802007c4:	faf42c23          	sw	a5,-72(s0)
    802007c8:	fb043783          	ld	a5,-80(s0)
    802007cc:	fa079ce3          	bnez	a5,80200784 <vprintfmt+0x314>
                    }

                    for (int i = bits; i >= 0; i--) {
    802007d0:	fb842783          	lw	a5,-72(s0)
    802007d4:	faf42623          	sw	a5,-84(s0)
    802007d8:	02c0006f          	j	80200804 <vprintfmt+0x394>
                        putch(decchar[i]);
    802007dc:	fac42783          	lw	a5,-84(s0)
    802007e0:	ff040713          	addi	a4,s0,-16
    802007e4:	00f707b3          	add	a5,a4,a5
    802007e8:	f507c783          	lbu	a5,-176(a5)
    802007ec:	f3843703          	ld	a4,-200(s0)
    802007f0:	00078513          	mv	a0,a5
    802007f4:	000700e7          	jalr	a4
                    for (int i = bits; i >= 0; i--) {
    802007f8:	fac42783          	lw	a5,-84(s0)
    802007fc:	fff7879b          	addiw	a5,a5,-1
    80200800:	faf42623          	sw	a5,-84(s0)
    80200804:	fac42783          	lw	a5,-84(s0)
    80200808:	0007879b          	sext.w	a5,a5
    8020080c:	fc07d8e3          	bgez	a5,802007dc <vprintfmt+0x36c>
                    }
                    pos += bits + 1;
    80200810:	fb842783          	lw	a5,-72(s0)
    80200814:	0017879b          	addiw	a5,a5,1
    80200818:	0007879b          	sext.w	a5,a5
    8020081c:	00078713          	mv	a4,a5
    80200820:	fe043783          	ld	a5,-32(s0)
    80200824:	00e787b3          	add	a5,a5,a4
    80200828:	fef43023          	sd	a5,-32(s0)
                    longarg = 0; in_format = 0; 
    8020082c:	fe042423          	sw	zero,-24(s0)
    80200830:	fe042623          	sw	zero,-20(s0)
                    break;
    80200834:	0e40006f          	j	80200918 <vprintfmt+0x4a8>
                }

                case 's': {
                    const char* str = va_arg(vl, const char*);
    80200838:	f2843783          	ld	a5,-216(s0)
    8020083c:	00878713          	addi	a4,a5,8
    80200840:	f2e43423          	sd	a4,-216(s0)
    80200844:	0007b783          	ld	a5,0(a5)
    80200848:	faf43023          	sd	a5,-96(s0)
                    while (*str) {
    8020084c:	0300006f          	j	8020087c <vprintfmt+0x40c>
                        putch(*str);
    80200850:	fa043783          	ld	a5,-96(s0)
    80200854:	0007c783          	lbu	a5,0(a5)
    80200858:	f3843703          	ld	a4,-200(s0)
    8020085c:	00078513          	mv	a0,a5
    80200860:	000700e7          	jalr	a4
                        pos++; 
    80200864:	fe043783          	ld	a5,-32(s0)
    80200868:	00178793          	addi	a5,a5,1
    8020086c:	fef43023          	sd	a5,-32(s0)
                        str++;
    80200870:	fa043783          	ld	a5,-96(s0)
    80200874:	00178793          	addi	a5,a5,1
    80200878:	faf43023          	sd	a5,-96(s0)
                    while (*str) {
    8020087c:	fa043783          	ld	a5,-96(s0)
    80200880:	0007c783          	lbu	a5,0(a5)
    80200884:	fc0796e3          	bnez	a5,80200850 <vprintfmt+0x3e0>
                    }
                    longarg = 0; in_format = 0; 
    80200888:	fe042423          	sw	zero,-24(s0)
    8020088c:	fe042623          	sw	zero,-20(s0)
                    break;
    80200890:	0880006f          	j	80200918 <vprintfmt+0x4a8>
                }

                case 'c': {
                    char ch = (char)va_arg(vl,int);
    80200894:	f2843783          	ld	a5,-216(s0)
    80200898:	00878713          	addi	a4,a5,8
    8020089c:	f2e43423          	sd	a4,-216(s0)
    802008a0:	0007a783          	lw	a5,0(a5)
    802008a4:	f6f40fa3          	sb	a5,-129(s0)
                    putch(ch);
    802008a8:	f7f44783          	lbu	a5,-129(s0)
    802008ac:	f3843703          	ld	a4,-200(s0)
    802008b0:	00078513          	mv	a0,a5
    802008b4:	000700e7          	jalr	a4
                    pos++;
    802008b8:	fe043783          	ld	a5,-32(s0)
    802008bc:	00178793          	addi	a5,a5,1
    802008c0:	fef43023          	sd	a5,-32(s0)
                    longarg = 0; in_format = 0; 
    802008c4:	fe042423          	sw	zero,-24(s0)
    802008c8:	fe042623          	sw	zero,-20(s0)
                    break;
    802008cc:	04c0006f          	j	80200918 <vprintfmt+0x4a8>
                }
                default:
                    break;
            }
        }
        else if(*fmt == '%') {
    802008d0:	f3043783          	ld	a5,-208(s0)
    802008d4:	0007c783          	lbu	a5,0(a5)
    802008d8:	00078713          	mv	a4,a5
    802008dc:	02500793          	li	a5,37
    802008e0:	00f71863          	bne	a4,a5,802008f0 <vprintfmt+0x480>
          in_format = 1;
    802008e4:	00100793          	li	a5,1
    802008e8:	fef42623          	sw	a5,-20(s0)
    802008ec:	02c0006f          	j	80200918 <vprintfmt+0x4a8>
        }
        else {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
            putch(*fmt);
    802008f0:	f3043783          	ld	a5,-208(s0)
    802008f4:	0007c783          	lbu	a5,0(a5)
    802008f8:	f3843703          	ld	a4,-200(s0)
    802008fc:	00078513          	mv	a0,a5
    80200900:	000700e7          	jalr	a4
            pos++;
    80200904:	fe043783          	ld	a5,-32(s0)
    80200908:	00178793          	addi	a5,a5,1
    8020090c:	fef43023          	sd	a5,-32(s0)
    80200910:	0080006f          	j	80200918 <vprintfmt+0x4a8>
                    break;
    80200914:	00000013          	nop
    for( ; *fmt; fmt++) {
    80200918:	f3043783          	ld	a5,-208(s0)
    8020091c:	00178793          	addi	a5,a5,1
    80200920:	f2f43823          	sd	a5,-208(s0)
    80200924:	f3043783          	ld	a5,-208(s0)
    80200928:	0007c783          	lbu	a5,0(a5)
    8020092c:	b60798e3          	bnez	a5,8020049c <vprintfmt+0x2c>
        }
    }
    return pos;
    80200930:	fe043783          	ld	a5,-32(s0)
    80200934:	0007879b          	sext.w	a5,a5
}
    80200938:	00078513          	mv	a0,a5
    8020093c:	0d813083          	ld	ra,216(sp)
    80200940:	0d013403          	ld	s0,208(sp)
    80200944:	0e010113          	addi	sp,sp,224
    80200948:	00008067          	ret

000000008020094c <printk>:



int printk(const char* s, ...) {
    8020094c:	f9010113          	addi	sp,sp,-112
    80200950:	02113423          	sd	ra,40(sp)
    80200954:	02813023          	sd	s0,32(sp)
    80200958:	03010413          	addi	s0,sp,48
    8020095c:	fca43c23          	sd	a0,-40(s0)
    80200960:	00b43423          	sd	a1,8(s0)
    80200964:	00c43823          	sd	a2,16(s0)
    80200968:	00d43c23          	sd	a3,24(s0)
    8020096c:	02e43023          	sd	a4,32(s0)
    80200970:	02f43423          	sd	a5,40(s0)
    80200974:	03043823          	sd	a6,48(s0)
    80200978:	03143c23          	sd	a7,56(s0)
    int res = 0;
    8020097c:	fe042623          	sw	zero,-20(s0)
    va_list vl;
    va_start(vl, s);
    80200980:	04040793          	addi	a5,s0,64
    80200984:	fcf43823          	sd	a5,-48(s0)
    80200988:	fd043783          	ld	a5,-48(s0)
    8020098c:	fc878793          	addi	a5,a5,-56
    80200990:	fef43023          	sd	a5,-32(s0)
    res = vprintfmt(putc, s, vl);
    80200994:	fe043783          	ld	a5,-32(s0)
    80200998:	00078613          	mv	a2,a5
    8020099c:	fd843583          	ld	a1,-40(s0)
    802009a0:	00000517          	auipc	a0,0x0
    802009a4:	a8050513          	addi	a0,a0,-1408 # 80200420 <putc>
    802009a8:	ac9ff0ef          	jal	ra,80200470 <vprintfmt>
    802009ac:	00050793          	mv	a5,a0
    802009b0:	fef42623          	sw	a5,-20(s0)
    va_end(vl);
    return res;
    802009b4:	fec42783          	lw	a5,-20(s0)
}
    802009b8:	00078513          	mv	a0,a5
    802009bc:	02813083          	ld	ra,40(sp)
    802009c0:	02013403          	ld	s0,32(sp)
    802009c4:	07010113          	addi	sp,sp,112
    802009c8:	00008067          	ret
