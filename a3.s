
.section .data        # memory variables

input: .asciz "%d"
input1: .asciz "%lf"
outputSUM: .asciz "sum=%lf "
outputAVG: .asciz "avg=%lf\n"

n: .int 0
i: .double 0.0
sum: .double 0.0
n1: .double 0.0 #will equal to n after converting it from int to double
average: .double 0.0


.section .text
.globl _main

_main:
    pushl $n
    pushl $input
    call _scanf
    add $8, %esp       
    movl $0, %ecx       #will be used in while loop as number of iterations
    cvtpi2pd n, %xmm0   #convert n from int to double and save it in %xmm0
    movdqu %xmm0, n1    #save value of xmm0 in n1
loop1:
    pushl %ecx
    pushl $i+4
    pushl $i
    pushl $input1
    call _scanf
    add $12, %esp

    fldl i   #add next double to sum
    faddl sum
    fstpl sum
    popl %ecx
    add $1, %ecx
    cmpl %ecx, n
    ja loop1         
   
    fldl sum  #divide sum on number of elements
    fdivl n1
    fstpl average
   
    pushl sum+4 #print sum
    pushl sum
    pushl $outputSUM
    call _printf
    add $12, %esp

    pushl average+4 #print average
    pushl average
    pushl $outputAVG
    call _printf
    add $12, %esp  

   ret
   