  .section	__TEXT,__text,regular,pure_instructions
  .build_version macos, 10, 15	sdk_version 10, 15
  .globl	_main                   ## -- Begin function main
  .p2align	4, 0x90
_main:                                  ## @main
Lfunc_begin0:
  .file	1 "/Users/matthew/GitHub/blog/content/blog/duff-device" "duff-like.c"
  .loc	1 27 0                  ## duff-like.c:27:0
  .cfi_startproc
## %bb.0:
  pushq	%rbp
  .cfi_def_cfa_offset 16
  .cfi_offset %rbp, -16
  movq	%rsp, %rbp
  .cfi_def_cfa_register %rbp
  subq	$32, %rsp
  movl	$0, -4(%rbp)
Ltmp0:
  .loc	1 28 7 prologue_end     ## duff-like.c:28:7
  movl	$100, -8(%rbp)
  .loc	1 29 7                  ## duff-like.c:29:7
  movl	$0, -12(%rbp)
  .loc	1 30 12                 ## duff-like.c:30:12
  movl	-8(%rbp), %eax
  .loc	1 30 18 is_stmt 0       ## duff-like.c:30:18
  movl	%eax, %ecx
  addl	$7, %ecx
  .loc	1 30 23                 ## duff-like.c:30:23
  movl	%eax, %edx
  sarl	$31, %ecx
  shrl	$29, %ecx
  movl	%ecx, %esi
  leal	7(%rdx,%rsi), %eax
  sarl	$3, %eax
  .loc	1 30 7                  ## duff-like.c:30:7
  movl	%eax, -16(%rbp)
  .loc	1 32 11 is_stmt 1       ## duff-like.c:32:11
  movl	-8(%rbp), %eax
  .loc	1 32 17 is_stmt 0       ## duff-like.c:32:17
  movl	%eax, %ecx
  sarl	$31, %ecx
  shrl	$29, %ecx
  movl	%eax, %edi
  addl	%ecx, %edi
  andl	$-8, %edi
  subl	%edi, %eax
  .loc	1 32 3                  ## duff-like.c:32:3
  movl	%eax, %edx
  subl	$7, %eax
  movq	%rdx, -24(%rbp)         ## 8-byte Spill
  movl	%eax, -28(%rbp)         ## 4-byte Spill
  ja	LBB0_12
## %bb.13:
  .loc	1 0 3                   ## duff-like.c:0:3
  leaq	LJTI0_0(%rip), %rax
  movq	-24(%rbp), %rcx         ## 8-byte Reload
  movslq	(%rax,%rcx,4), %rdx
  addq	%rax, %rdx
  jmpq	*%rdx
LBB0_1:
Ltmp1:
  .loc	1 33 13 is_stmt 1       ## duff-like.c:33:13
  jmp	LBB0_2
LBB0_2:
Ltmp2:
  .loc	1 33 21 is_stmt 0       ## duff-like.c:33:21
  movl	-12(%rbp), %eax
  addl	$1, %eax
  movl	%eax, -12(%rbp)
LBB0_3:
  .loc	1 34 21 is_stmt 1       ## duff-like.c:34:21
  movl	-12(%rbp), %eax
  addl	$1, %eax
  movl	%eax, -12(%rbp)
LBB0_4:
  .loc	1 35 21                 ## duff-like.c:35:21
  movl	-12(%rbp), %eax
  addl	$1, %eax
  movl	%eax, -12(%rbp)
LBB0_5:
  .loc	1 36 21                 ## duff-like.c:36:21
  movl	-12(%rbp), %eax
  addl	$1, %eax
  movl	%eax, -12(%rbp)
LBB0_6:
  .loc	1 37 21                 ## duff-like.c:37:21
  movl	-12(%rbp), %eax
  addl	$1, %eax
  movl	%eax, -12(%rbp)
LBB0_7:
  .loc	1 38 21                 ## duff-like.c:38:21
  movl	-12(%rbp), %eax
  addl	$1, %eax
  movl	%eax, -12(%rbp)
LBB0_8:
  .loc	1 39 21                 ## duff-like.c:39:21
  movl	-12(%rbp), %eax
  addl	$1, %eax
  movl	%eax, -12(%rbp)
LBB0_9:
  .loc	1 40 21                 ## duff-like.c:40:21
  movl	-12(%rbp), %eax
  addl	$1, %eax
  movl	%eax, -12(%rbp)
Ltmp3:
## %bb.10:
  .loc	1 41 22                 ## duff-like.c:41:22
  movl	-16(%rbp), %eax
  addl	$-1, %eax
  movl	%eax, -16(%rbp)
  .loc	1 41 26 is_stmt 0       ## duff-like.c:41:26
  cmpl	$0, %eax
Ltmp4:
  .loc	1 41 13                 ## duff-like.c:41:13
  jg	LBB0_2
Ltmp5:
## %bb.11:
  .loc	1 42 3 is_stmt 1        ## duff-like.c:42:3
  jmp	LBB0_12
Ltmp6:
LBB0_12:
  .loc	1 44 23                 ## duff-like.c:44:23
  movl	-12(%rbp), %esi
  .loc	1 44 3 is_stmt 0        ## duff-like.c:44:3
  leaq	L_.str(%rip), %rdi
  movb	$0, %al
  callq	_printf
  xorl	%esi, %esi
  movl	%eax, -32(%rbp)         ## 4-byte Spill
  .loc	1 45 3 is_stmt 1        ## duff-like.c:45:3
  movl	%esi, %eax
  addq	$32, %rsp
  popq	%rbp
  retq
Ltmp7:
Lfunc_end0:
  .cfi_endproc
  .p2align	2, 0x90
  .data_region jt32
.set L0_0_set_1, LBB0_1-LJTI0_0
.set L0_0_set_9, LBB0_9-LJTI0_0
.set L0_0_set_8, LBB0_8-LJTI0_0
.set L0_0_set_7, LBB0_7-LJTI0_0
.set L0_0_set_6, LBB0_6-LJTI0_0
.set L0_0_set_5, LBB0_5-LJTI0_0
.set L0_0_set_4, LBB0_4-LJTI0_0
.set L0_0_set_3, LBB0_3-LJTI0_0
LJTI0_0:
  .long	L0_0_set_1
  .long	L0_0_set_9
  .long	L0_0_set_8
  .long	L0_0_set_7
  .long	L0_0_set_6
  .long	L0_0_set_5
  .long	L0_0_set_4
  .long	L0_0_set_3
  .end_data_region
                                        ## -- End function
  .section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
  .asciz	"sum: %d\n"

  .section	__DWARF,__debug_str,regular,debug
Linfo_string:
  .asciz	"Apple clang version 11.0.0 (clang-1100.0.33.17)" ## string offset=0
  .asciz	"duff-like.c"           ## string offset=48
  .asciz	"/Users/matthew/GitHub/blog/content/blog/duff-device" ## string offset=60
  .asciz	"main"                  ## string offset=112
  .asciz	"int"                   ## string offset=117
  .asciz	"count"                 ## string offset=121
  .asciz	"sum"                   ## string offset=127
  .asciz	"n"                     ## string offset=131
  .section	__DWARF,__debug_abbrev,regular,debug
Lsection_abbrev:
  .byte	1                       ## Abbreviation Code
  .byte	17                      ## DW_TAG_compile_unit
  .byte	1                       ## DW_CHILDREN_yes
  .byte	37                      ## DW_AT_producer
  .byte	14                      ## DW_FORM_strp
  .byte	19                      ## DW_AT_language
  .byte	5                       ## DW_FORM_data2
  .byte	3                       ## DW_AT_name
  .byte	14                      ## DW_FORM_strp
  .byte	16                      ## DW_AT_stmt_list
  .byte	23                      ## DW_FORM_sec_offset
  .byte	27                      ## DW_AT_comp_dir
  .byte	14                      ## DW_FORM_strp
  .ascii	"\264B"                 ## DW_AT_GNU_pubnames
  .byte	25                      ## DW_FORM_flag_present
  .byte	17                      ## DW_AT_low_pc
  .byte	1                       ## DW_FORM_addr
  .byte	18                      ## DW_AT_high_pc
  .byte	6                       ## DW_FORM_data4
  .byte	0                       ## EOM(1)
  .byte	0                       ## EOM(2)
  .byte	2                       ## Abbreviation Code
  .byte	46                      ## DW_TAG_subprogram
  .byte	1                       ## DW_CHILDREN_yes
  .byte	17                      ## DW_AT_low_pc
  .byte	1                       ## DW_FORM_addr
  .byte	18                      ## DW_AT_high_pc
  .byte	6                       ## DW_FORM_data4
  .byte	64                      ## DW_AT_frame_base
  .byte	24                      ## DW_FORM_exprloc
  .byte	3                       ## DW_AT_name
  .byte	14                      ## DW_FORM_strp
  .byte	58                      ## DW_AT_decl_file
  .byte	11                      ## DW_FORM_data1
  .byte	59                      ## DW_AT_decl_line
  .byte	11                      ## DW_FORM_data1
  .byte	73                      ## DW_AT_type
  .byte	19                      ## DW_FORM_ref4
  .byte	63                      ## DW_AT_external
  .byte	25                      ## DW_FORM_flag_present
  .byte	0                       ## EOM(1)
  .byte	0                       ## EOM(2)
  .byte	3                       ## Abbreviation Code
  .byte	52                      ## DW_TAG_variable
  .byte	0                       ## DW_CHILDREN_no
  .byte	2                       ## DW_AT_location
  .byte	24                      ## DW_FORM_exprloc
  .byte	3                       ## DW_AT_name
  .byte	14                      ## DW_FORM_strp
  .byte	58                      ## DW_AT_decl_file
  .byte	11                      ## DW_FORM_data1
  .byte	59                      ## DW_AT_decl_line
  .byte	11                      ## DW_FORM_data1
  .byte	73                      ## DW_AT_type
  .byte	19                      ## DW_FORM_ref4
  .byte	0                       ## EOM(1)
  .byte	0                       ## EOM(2)
  .byte	4                       ## Abbreviation Code
  .byte	36                      ## DW_TAG_base_type
  .byte	0                       ## DW_CHILDREN_no
  .byte	3                       ## DW_AT_name
  .byte	14                      ## DW_FORM_strp
  .byte	62                      ## DW_AT_encoding
  .byte	11                      ## DW_FORM_data1
  .byte	11                      ## DW_AT_byte_size
  .byte	11                      ## DW_FORM_data1
  .byte	0                       ## EOM(1)
  .byte	0                       ## EOM(2)
  .byte	0                       ## EOM(3)
  .section	__DWARF,__debug_info,regular,debug
Lsection_info:
Lcu_begin0:
.set Lset0, Ldebug_info_end0-Ldebug_info_start0 ## Length of Unit
  .long	Lset0
Ldebug_info_start0:
  .short	4                       ## DWARF version number
.set Lset1, Lsection_abbrev-Lsection_abbrev ## Offset Into Abbrev. Section
  .long	Lset1
  .byte	8                       ## Address Size (in bytes)
  .byte	1                       ## Abbrev [1] 0xb:0x6b DW_TAG_compile_unit
  .long	0                       ## DW_AT_producer
  .short	12                      ## DW_AT_language
  .long	48                      ## DW_AT_name
.set Lset2, Lline_table_start0-Lsection_line ## DW_AT_stmt_list
  .long	Lset2
  .long	60                      ## DW_AT_comp_dir
                                        ## DW_AT_GNU_pubnames
  .quad	Lfunc_begin0            ## DW_AT_low_pc
.set Lset3, Lfunc_end0-Lfunc_begin0     ## DW_AT_high_pc
  .long	Lset3
  .byte	2                       ## Abbrev [2] 0x2a:0x44 DW_TAG_subprogram
  .quad	Lfunc_begin0            ## DW_AT_low_pc
.set Lset4, Lfunc_end0-Lfunc_begin0     ## DW_AT_high_pc
  .long	Lset4
  .byte	1                       ## DW_AT_frame_base
  .byte	86
  .long	112                     ## DW_AT_name
  .byte	1                       ## DW_AT_decl_file
  .byte	27                      ## DW_AT_decl_line
  .long	110                     ## DW_AT_type
                                        ## DW_AT_external
  .byte	3                       ## Abbrev [3] 0x43:0xe DW_TAG_variable
  .byte	2                       ## DW_AT_location
  .byte	145
  .byte	120
  .long	121                     ## DW_AT_name
  .byte	1                       ## DW_AT_decl_file
  .byte	28                      ## DW_AT_decl_line
  .long	110                     ## DW_AT_type
  .byte	3                       ## Abbrev [3] 0x51:0xe DW_TAG_variable
  .byte	2                       ## DW_AT_location
  .byte	145
  .byte	116
  .long	127                     ## DW_AT_name
  .byte	1                       ## DW_AT_decl_file
  .byte	29                      ## DW_AT_decl_line
  .long	110                     ## DW_AT_type
  .byte	3                       ## Abbrev [3] 0x5f:0xe DW_TAG_variable
  .byte	2                       ## DW_AT_location
  .byte	145
  .byte	112
  .long	131                     ## DW_AT_name
  .byte	1                       ## DW_AT_decl_file
  .byte	30                      ## DW_AT_decl_line
  .long	110                     ## DW_AT_type
  .byte	0                       ## End Of Children Mark
  .byte	4                       ## Abbrev [4] 0x6e:0x7 DW_TAG_base_type
  .long	117                     ## DW_AT_name
  .byte	5                       ## DW_AT_encoding
  .byte	4                       ## DW_AT_byte_size
  .byte	0                       ## End Of Children Mark
Ldebug_info_end0:
  .section	__DWARF,__debug_macinfo,regular,debug
Ldebug_macinfo:
  .byte	0                       ## End Of Macro List Mark
  .section	__DWARF,__apple_names,regular,debug
Lnames_begin:
  .long	1212240712              ## Header Magic
  .short	1                       ## Header Version
  .short	0                       ## Header Hash Function
  .long	1                       ## Header Bucket Count
  .long	1                       ## Header Hash Count
  .long	12                      ## Header Data Length
  .long	0                       ## HeaderData Die Offset Base
  .long	1                       ## HeaderData Atom Count
  .short	1                       ## DW_ATOM_die_offset
  .short	6                       ## DW_FORM_data4
  .long	0                       ## Bucket 0
  .long	2090499946              ## Hash in Bucket 0
.set Lset5, LNames0-Lnames_begin        ## Offset in Bucket 0
  .long	Lset5
LNames0:
  .long	112                     ## main
  .long	1                       ## Num DIEs
  .long	42
  .long	0
  .section	__DWARF,__apple_objc,regular,debug
Lobjc_begin:
  .long	1212240712              ## Header Magic
  .short	1                       ## Header Version
  .short	0                       ## Header Hash Function
  .long	1                       ## Header Bucket Count
  .long	0                       ## Header Hash Count
  .long	12                      ## Header Data Length
  .long	0                       ## HeaderData Die Offset Base
  .long	1                       ## HeaderData Atom Count
  .short	1                       ## DW_ATOM_die_offset
  .short	6                       ## DW_FORM_data4
  .long	-1                      ## Bucket 0
  .section	__DWARF,__apple_namespac,regular,debug
Lnamespac_begin:
  .long	1212240712              ## Header Magic
  .short	1                       ## Header Version
  .short	0                       ## Header Hash Function
  .long	1                       ## Header Bucket Count
  .long	0                       ## Header Hash Count
  .long	12                      ## Header Data Length
  .long	0                       ## HeaderData Die Offset Base
  .long	1                       ## HeaderData Atom Count
  .short	1                       ## DW_ATOM_die_offset
  .short	6                       ## DW_FORM_data4
  .long	-1                      ## Bucket 0
  .section	__DWARF,__apple_types,regular,debug
Ltypes_begin:
  .long	1212240712              ## Header Magic
  .short	1                       ## Header Version
  .short	0                       ## Header Hash Function
  .long	1                       ## Header Bucket Count
  .long	1                       ## Header Hash Count
  .long	20                      ## Header Data Length
  .long	0                       ## HeaderData Die Offset Base
  .long	3                       ## HeaderData Atom Count
  .short	1                       ## DW_ATOM_die_offset
  .short	6                       ## DW_FORM_data4
  .short	3                       ## DW_ATOM_die_tag
  .short	5                       ## DW_FORM_data2
  .short	4                       ## DW_ATOM_type_flags
  .short	11                      ## DW_FORM_data1
  .long	0                       ## Bucket 0
  .long	193495088               ## Hash in Bucket 0
.set Lset6, Ltypes0-Ltypes_begin        ## Offset in Bucket 0
  .long	Lset6
Ltypes0:
  .long	117                     ## int
  .long	1                       ## Num DIEs
  .long	110
  .short	36
  .byte	0
  .long	0
  .section	__DWARF,__debug_gnu_pubn,regular,debug
.set Lset7, LpubNames_end0-LpubNames_begin0 ## Length of Public Names Info
  .long	Lset7
LpubNames_begin0:
  .short	2                       ## DWARF Version
.set Lset8, Lcu_begin0-Lsection_info    ## Offset of Compilation Unit Info
  .long	Lset8
  .long	118                     ## Compilation Unit Length
  .long	42                      ## DIE offset
  .byte	48                      ## Attributes: FUNCTION, EXTERNAL
  .asciz	"main"                  ## External Name
  .long	0                       ## End Mark
LpubNames_end0:
  .section	__DWARF,__debug_gnu_pubt,regular,debug
.set Lset9, LpubTypes_end0-LpubTypes_begin0 ## Length of Public Types Info
  .long	Lset9
LpubTypes_begin0:
  .short	2                       ## DWARF Version
.set Lset10, Lcu_begin0-Lsection_info   ## Offset of Compilation Unit Info
  .long	Lset10
  .long	118                     ## Compilation Unit Length
  .long	110                     ## DIE offset
  .byte	144                     ## Attributes: TYPE, STATIC
  .asciz	"int"                   ## External Name
  .long	0                       ## End Mark
LpubTypes_end0:

.subsections_via_symbols
  .section	__DWARF,__debug_line,regular,debug
Lsection_line:
Lline_table_start0:
