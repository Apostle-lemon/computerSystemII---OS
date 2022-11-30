.extern start_kernel

.section .text.init # 将代码放在.text.init段中
.globl _start # 全局符号_start
_start:
  # set the stack pointer
  la sp,boot_stack_bottom # 将栈指针指向栈底

  # DEBUG:
  rdtime a0
  jal testLemon

  # set stvec = _traps, and set the mode to Direct
  la a0, _traps
  li a1, 0xfffffffc
  and a0, a0, a1
  csrw stvec, a0
  # 开启时钟中断
  csrr t0, sie
  li t1, 0x20
  or t0, t0, t1 // 将第 5 位置 1 
  csrw sie, t0

  # set first time interrupt
  rdtime a0
  li a1, 10000000
  add a0, a0, a1
  and a6, a6 , 0
  and a7, a7 , 0
  ecall

  # set sstatus[SIE] = 1, 开启S态异常相应
  csrr t0, sstatus
  li t1, 0x2
  or t0, t0, t1 // 将第 1 位置 1
  csrw sstatus, t0

  li a0,2025
  j start_kernel

.section .stack.space
.globl boot_stack
boot_stack:
  .space 0x1000 # 4KB
.globl boot_stack_bottom
boot_stack_bottom: