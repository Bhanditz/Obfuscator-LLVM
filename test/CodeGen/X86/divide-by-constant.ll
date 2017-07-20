; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-pc-linux-gnu | FileCheck %s --check-prefix=X32
; RUN: llc < %s -mtriple=x86_64-pc-linux-gnu | FileCheck %s --check-prefix=X64

define zeroext i16 @test1(i16 zeroext %x) nounwind {
; X32-LABEL: test1:
; X32:       # BB#0: # %entry
; X32-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    imull $63551, %eax, %eax # imm = 0xF83F
; X32-NEXT:    shrl $21, %eax
; X32-NEXT:    # kill: %AX<def> %AX<kill> %EAX<kill>
; X32-NEXT:    retl
;
; X64-LABEL: test1:
; X64:       # BB#0: # %entry
; X64-NEXT:    imull $63551, %edi, %eax # imm = 0xF83F
; X64-NEXT:    shrl $21, %eax
; X64-NEXT:    # kill: %AX<def> %AX<kill> %EAX<kill>
; X64-NEXT:    retq
entry:
	%div = udiv i16 %x, 33
	ret i16 %div
}

define zeroext i16 @test2(i8 signext %x, i16 zeroext %c) nounwind readnone ssp noredzone {
; X32-LABEL: test2:
; X32:       # BB#0: # %entry
; X32-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    imull $43691, %eax, %eax # imm = 0xAAAB
; X32-NEXT:    shrl $17, %eax
; X32-NEXT:    # kill: %AX<def> %AX<kill> %EAX<kill>
; X32-NEXT:    retl
;
; X64-LABEL: test2:
; X64:       # BB#0: # %entry
; X64-NEXT:    imull $43691, %esi, %eax # imm = 0xAAAB
; X64-NEXT:    shrl $17, %eax
; X64-NEXT:    # kill: %AX<def> %AX<kill> %EAX<kill>
; X64-NEXT:    retq
entry:
  %div = udiv i16 %c, 3
  ret i16 %div

}

define zeroext i8 @test3(i8 zeroext %x, i8 zeroext %c) nounwind readnone ssp noredzone {
; X32-LABEL: test3:
; X32:       # BB#0: # %entry
; X32-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    imull $171, %eax, %eax
; X32-NEXT:    andl $65024, %eax # imm = 0xFE00
; X32-NEXT:    shrl $9, %eax
; X32-NEXT:    # kill: %AL<def> %AL<kill> %EAX<kill>
; X32-NEXT:    retl
;
; X64-LABEL: test3:
; X64:       # BB#0: # %entry
; X64-NEXT:    imull $171, %esi, %eax
; X64-NEXT:    andl $65024, %eax # imm = 0xFE00
; X64-NEXT:    shrl $9, %eax
; X64-NEXT:    # kill: %AL<def> %AL<kill> %EAX<kill>
; X64-NEXT:    retq
entry:
  %div = udiv i8 %c, 3
  ret i8 %div
}

define signext i16 @test4(i16 signext %x) nounwind {
; X32-LABEL: test4:
; X32:       # BB#0: # %entry
; X32-NEXT:    movswl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    imull $1986, %eax, %eax # imm = 0x7C2
; X32-NEXT:    movl %eax, %ecx
; X32-NEXT:    shrl $31, %ecx
; X32-NEXT:    shrl $16, %eax
; X32-NEXT:    addl %ecx, %eax
; X32-NEXT:    # kill: %AX<def> %AX<kill> %EAX<kill>
; X32-NEXT:    retl
;
; X64-LABEL: test4:
; X64:       # BB#0: # %entry
; X64-NEXT:    imull $1986, %edi, %eax # imm = 0x7C2
; X64-NEXT:    movl %eax, %ecx
; X64-NEXT:    shrl $31, %ecx
; X64-NEXT:    shrl $16, %eax
; X64-NEXT:    addl %ecx, %eax
; X64-NEXT:    # kill: %AX<def> %AX<kill> %EAX<kill>
; X64-NEXT:    retq
entry:
	%div = sdiv i16 %x, 33		; <i32> [#uses=1]
	ret i16 %div
}

define i32 @test5(i32 %A) nounwind {
; X32-LABEL: test5:
; X32:       # BB#0:
; X32-NEXT:    movl $365384439, %eax # imm = 0x15C752F7
; X32-NEXT:    mull {{[0-9]+}}(%esp)
; X32-NEXT:    shrl $27, %edx
; X32-NEXT:    movl %edx, %eax
; X32-NEXT:    retl
;
; X64-LABEL: test5:
; X64:       # BB#0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    imulq $365384439, %rax, %rax # imm = 0x15C752F7
; X64-NEXT:    shrq $59, %rax
; X64-NEXT:    # kill: %EAX<def> %EAX<kill> %RAX<kill>
; X64-NEXT:    retq
        %tmp1 = udiv i32 %A, 1577682821         ; <i32> [#uses=1]
        ret i32 %tmp1
}

define signext i16 @test6(i16 signext %x) nounwind {
; X32-LABEL: test6:
; X32:       # BB#0: # %entry
; X32-NEXT:    movswl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    imull $26215, %eax, %eax # imm = 0x6667
; X32-NEXT:    movl %eax, %ecx
; X32-NEXT:    shrl $31, %ecx
; X32-NEXT:    sarl $18, %eax
; X32-NEXT:    addl %ecx, %eax
; X32-NEXT:    # kill: %AX<def> %AX<kill> %EAX<kill>
; X32-NEXT:    retl
;
; X64-LABEL: test6:
; X64:       # BB#0: # %entry
; X64-NEXT:    imull $26215, %edi, %eax # imm = 0x6667
; X64-NEXT:    movl %eax, %ecx
; X64-NEXT:    shrl $31, %ecx
; X64-NEXT:    sarl $18, %eax
; X64-NEXT:    addl %ecx, %eax
; X64-NEXT:    # kill: %AX<def> %AX<kill> %EAX<kill>
; X64-NEXT:    retq
entry:
  %div = sdiv i16 %x, 10
  ret i16 %div
}

define i32 @test7(i32 %x) nounwind {
; X32-LABEL: test7:
; X32:       # BB#0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    shrl $2, %eax
; X32-NEXT:    movl $613566757, %ecx # imm = 0x24924925
; X32-NEXT:    mull %ecx
; X32-NEXT:    movl %edx, %eax
; X32-NEXT:    retl
;
; X64-LABEL: test7:
; X64:       # BB#0:
; X64-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; X64-NEXT:    shrl $2, %edi
; X64-NEXT:    imulq $613566757, %rdi, %rax # imm = 0x24924925
; X64-NEXT:    shrq $32, %rax
; X64-NEXT:    # kill: %EAX<def> %EAX<kill> %RAX<kill>
; X64-NEXT:    retq
  %div = udiv i32 %x, 28
  ret i32 %div
}

; PR13326
define i8 @test8(i8 %x) nounwind {
; X32-LABEL: test8:
; X32:       # BB#0:
; X32-NEXT:    movb {{[0-9]+}}(%esp), %al
; X32-NEXT:    shrb %al
; X32-NEXT:    movzbl %al, %eax
; X32-NEXT:    imull $211, %eax, %eax
; X32-NEXT:    andl $24576, %eax # imm = 0x6000
; X32-NEXT:    shrl $13, %eax
; X32-NEXT:    # kill: %AL<def> %AL<kill> %EAX<kill>
; X32-NEXT:    retl
;
; X64-LABEL: test8:
; X64:       # BB#0:
; X64-NEXT:    shrb %dil
; X64-NEXT:    movzbl %dil, %eax
; X64-NEXT:    imull $211, %eax, %eax
; X64-NEXT:    andl $24576, %eax # imm = 0x6000
; X64-NEXT:    shrl $13, %eax
; X64-NEXT:    # kill: %AL<def> %AL<kill> %EAX<kill>
; X64-NEXT:    retq
  %div = udiv i8 %x, 78
  ret i8 %div
}

define i8 @test9(i8 %x) nounwind {
; X32-LABEL: test9:
; X32:       # BB#0:
; X32-NEXT:    movb {{[0-9]+}}(%esp), %al
; X32-NEXT:    shrb $2, %al
; X32-NEXT:    movzbl %al, %eax
; X32-NEXT:    imull $71, %eax, %eax
; X32-NEXT:    andl $6144, %eax # imm = 0x1800
; X32-NEXT:    shrl $11, %eax
; X32-NEXT:    # kill: %AL<def> %AL<kill> %EAX<kill>
; X32-NEXT:    retl
;
; X64-LABEL: test9:
; X64:       # BB#0:
; X64-NEXT:    shrb $2, %dil
; X64-NEXT:    movzbl %dil, %eax
; X64-NEXT:    imull $71, %eax, %eax
; X64-NEXT:    andl $6144, %eax # imm = 0x1800
; X64-NEXT:    shrl $11, %eax
; X64-NEXT:    # kill: %AL<def> %AL<kill> %EAX<kill>
; X64-NEXT:    retq
  %div = udiv i8 %x, 116
  ret i8 %div
}

define i32 @testsize1(i32 %x) minsize nounwind {
; X32-LABEL: testsize1:
; X32:       # BB#0: # %entry
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    pushl $32
; X32-NEXT:    popl %ecx
; X32-NEXT:    cltd
; X32-NEXT:    idivl %ecx
; X32-NEXT:    retl
;
; X64-LABEL: testsize1:
; X64:       # BB#0: # %entry
; X64-NEXT:    pushq $32
; X64-NEXT:    popq %rcx
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    cltd
; X64-NEXT:    idivl %ecx
; X64-NEXT:    retq
entry:
	%div = sdiv i32 %x, 32
	ret i32 %div
}

define i32 @testsize2(i32 %x) minsize nounwind {
; X32-LABEL: testsize2:
; X32:       # BB#0: # %entry
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    pushl $33
; X32-NEXT:    popl %ecx
; X32-NEXT:    cltd
; X32-NEXT:    idivl %ecx
; X32-NEXT:    retl
;
; X64-LABEL: testsize2:
; X64:       # BB#0: # %entry
; X64-NEXT:    pushq $33
; X64-NEXT:    popq %rcx
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    cltd
; X64-NEXT:    idivl %ecx
; X64-NEXT:    retq
entry:
	%div = sdiv i32 %x, 33
	ret i32 %div
}

define i32 @testsize3(i32 %x) minsize nounwind {
; X32-LABEL: testsize3:
; X32:       # BB#0: # %entry
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    shrl $5, %eax
; X32-NEXT:    retl
;
; X64-LABEL: testsize3:
; X64:       # BB#0: # %entry
; X64-NEXT:    shrl $5, %edi
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    retq
entry:
	%div = udiv i32 %x, 32
	ret i32 %div
}

define i32 @testsize4(i32 %x) minsize nounwind {
; X32-LABEL: testsize4:
; X32:       # BB#0: # %entry
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    pushl $33
; X32-NEXT:    popl %ecx
; X32-NEXT:    xorl %edx, %edx
; X32-NEXT:    divl %ecx
; X32-NEXT:    retl
;
; X64-LABEL: testsize4:
; X64:       # BB#0: # %entry
; X64-NEXT:    pushq $33
; X64-NEXT:    popq %rcx
; X64-NEXT:    xorl %edx, %edx
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    divl %ecx
; X64-NEXT:    retq
entry:
	%div = udiv i32 %x, 33
	ret i32 %div
}

define i64 @PR23590(i64 %x) nounwind {
; X32-LABEL: PR23590:
; X32:       # BB#0: # %entry
; X32-NEXT:    subl $12, %esp
; X32-NEXT:    pushl $0
; X32-NEXT:    pushl $12345 # imm = 0x3039
; X32-NEXT:    pushl {{[0-9]+}}(%esp)
; X32-NEXT:    pushl {{[0-9]+}}(%esp)
; X32-NEXT:    calll __umoddi3
; X32-NEXT:    addl $16, %esp
; X32-NEXT:    pushl $0
; X32-NEXT:    pushl $7
; X32-NEXT:    pushl %edx
; X32-NEXT:    pushl %eax
; X32-NEXT:    calll __udivdi3
; X32-NEXT:    addl $28, %esp
; X32-NEXT:    retl
;
; X64-LABEL: PR23590:
; X64:       # BB#0: # %entry
; X64-NEXT:    movq %rdi, %rcx
; X64-NEXT:    movabsq $6120523590596543007, %rdx # imm = 0x54F077C718E7C21F
; X64-NEXT:    movq %rcx, %rax
; X64-NEXT:    mulq %rdx
; X64-NEXT:    shrq $12, %rdx
; X64-NEXT:    imulq $12345, %rdx, %rax # imm = 0x3039
; X64-NEXT:    subq %rax, %rcx
; X64-NEXT:    movabsq $2635249153387078803, %rdx # imm = 0x2492492492492493
; X64-NEXT:    movq %rcx, %rax
; X64-NEXT:    mulq %rdx
; X64-NEXT:    subq %rdx, %rcx
; X64-NEXT:    shrq %rcx
; X64-NEXT:    leaq (%rcx,%rdx), %rax
; X64-NEXT:    shrq $2, %rax
; X64-NEXT:    retq
entry:
	%rem = urem i64 %x, 12345
	%div = udiv i64 %rem, 7
	ret i64 %div
}