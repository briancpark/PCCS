	.arch armv8-a
	.file	"driver1.c"
	.text
	.align	2
	.p2align 3,,7
	.global	initialize
	.type	initialize, %function
initialize:
.LFB43:
	.cfi_startproc
	cbz	x0, .L1
	sub	x2, x0, #1
	cmp	x2, 2
	bls	.L6
	lsr	x3, x0, 1
	mov	x2, x1
	dup	v1.2d, v0.d[0]
	add	x3, x1, x3, lsl 4
	.p2align 3,,7
.L4:
	str	q1, [x2], 16
	cmp	x2, x3
	bne	.L4
	and	x2, x0, -2
	tbz	x0, 0, .L1
.L3:
	add	x3, x2, 1
	str	d0, [x1, x2, lsl 3]
	cmp	x3, x0
	bcs	.L1
	add	x2, x2, 2
	str	d0, [x1, x3, lsl 3]
	cmp	x0, x2
	bls	.L1
	str	d0, [x1, x2, lsl 3]
.L1:
	ret
.L6:
	mov	x2, 0
	b	.L3
	.cfi_endproc
.LFE43:
	.size	initialize, .-initialize
	.align	2
	.p2align 3,,7
	.global	kernel
	.type	kernel, %function
kernel:
.LFB44:
	.cfi_startproc
	mov	w6, 8
	str	w6, [x3]
	mov	w5, 2
	str	w5, [x4]
	cbz	x1, .L12
	cbz	x0, .L12
	cmp	x1, 2
	sub	x9, x1, #1
	bls	.L38
	adrp	x3, .LC0
	lsr	x4, x0, 1
	and	x7, x0, -2
	mov	x8, 1
	ldr	q4, [x3, #:lo12:.LC0]
	adrp	x3, .LC1
	add	x5, x2, x4, lsl 4
	fmov	d2, 5.0e-1
	ldr	d3, [x3, #:lo12:.LC1]
	adrp	x3, .LC2
	ldr	d5, [x3, #:lo12:.LC2]
.L18:
	cmp	x0, 1
	beq	.L39
	fmul	d1, d2, d5
	mov	x3, x2
	dup	v7.2d, v2.d[0]
	dup	v6.2d, v1.d[0]
	.p2align 3,,7
.L16:
	mov	v16.16b, v7.16b
	ldr	q0, [x3]
	mov	v17.16b, v7.16b
	fmla	v16.2d, v0.2d, v4.2d
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v7.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v7.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v7.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v7.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v7.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v7.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v7.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v7.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v7.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v7.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v7.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v7.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v7.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v7.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v7.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v7.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v7.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v7.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v7.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v7.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v7.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v7.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v7.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v7.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v7.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v7.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v7.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v7.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v7.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v7.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v6.16b
	mov	v0.16b, v17.16b
	fmla	v16.2d, v17.2d, v4.2d
	mov	v17.16b, v6.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v6.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v6.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v6.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v6.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v6.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v6.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v6.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v6.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v6.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v6.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v6.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v6.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v6.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v6.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v6.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v6.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v6.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v6.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v6.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v6.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v6.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v6.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v6.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v6.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v6.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v6.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v6.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v6.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v6.16b
	fmla	v17.2d, v0.2d, v16.2d
	mov	v16.16b, v17.16b
	mov	v17.16b, v6.16b
	fmla	v17.2d, v0.2d, v16.2d
	str	q17, [x3], 16
	cmp	x3, x5
	bne	.L16
	mov	x3, x7
	cmp	x0, x7
	beq	.L17
.L23:
	ldr	d6, [x2, x3, lsl 3]
	fmul	d1, d2, d5
	fmadd	d0, d6, d3, d2
	fmadd	d0, d6, d0, d2
	fmadd	d0, d6, d0, d2
	fmadd	d0, d6, d0, d2
	fmadd	d0, d6, d0, d2
	fmadd	d0, d6, d0, d2
	fmadd	d0, d6, d0, d2
	fmadd	d0, d6, d0, d2
	fmadd	d0, d6, d0, d2
	fmadd	d0, d6, d0, d2
	fmadd	d0, d6, d0, d2
	fmadd	d0, d6, d0, d2
	fmadd	d0, d6, d0, d2
	fmadd	d0, d6, d0, d2
	fmadd	d0, d6, d0, d2
	fmadd	d0, d6, d0, d2
	fmadd	d0, d6, d0, d2
	fmadd	d0, d6, d0, d2
	fmadd	d0, d6, d0, d2
	fmadd	d0, d6, d0, d2
	fmadd	d0, d6, d0, d2
	fmadd	d0, d6, d0, d2
	fmadd	d0, d6, d0, d2
	fmadd	d0, d6, d0, d2
	fmadd	d0, d6, d0, d2
	fmadd	d0, d6, d0, d2
	fmadd	d0, d6, d0, d2
	fmadd	d0, d6, d0, d2
	fmadd	d0, d6, d0, d2
	fmadd	d0, d6, d0, d2
	fmadd	d0, d6, d0, d2
	fmadd	d2, d6, d0, d2
	fmadd	d0, d2, d3, d1
	fmadd	d0, d2, d0, d1
	fmadd	d0, d2, d0, d1
	fmadd	d0, d2, d0, d1
	fmadd	d0, d2, d0, d1
	fmadd	d0, d2, d0, d1
	fmadd	d0, d2, d0, d1
	fmadd	d0, d2, d0, d1
	fmadd	d0, d2, d0, d1
	fmadd	d0, d2, d0, d1
	fmadd	d0, d2, d0, d1
	fmadd	d0, d2, d0, d1
	fmadd	d0, d2, d0, d1
	fmadd	d0, d2, d0, d1
	fmadd	d0, d2, d0, d1
	fmadd	d0, d2, d0, d1
	fmadd	d0, d2, d0, d1
	fmadd	d0, d2, d0, d1
	fmadd	d0, d2, d0, d1
	fmadd	d0, d2, d0, d1
	fmadd	d0, d2, d0, d1
	fmadd	d0, d2, d0, d1
	fmadd	d0, d2, d0, d1
	fmadd	d0, d2, d0, d1
	fmadd	d0, d2, d0, d1
	fmadd	d0, d2, d0, d1
	fmadd	d0, d2, d0, d1
	fmadd	d0, d2, d0, d1
	fmadd	d0, d2, d0, d1
	fmadd	d0, d2, d0, d1
	fmadd	d0, d2, d0, d1
	fmadd	d2, d2, d0, d1
	str	d2, [x2, x3, lsl 3]
.L17:
	add	x6, x8, 1
	add	x8, x8, 2
	fmul	d2, d1, d5
	cmp	x9, x8
	bhi	.L18
.L15:
	adrp	x3, .LC0
	add	x4, x2, x4, lsl 4
	sub	x8, x0, #1
	ldr	q3, [x3, #:lo12:.LC0]
	adrp	x3, .LC1
	ldr	d4, [x3, #:lo12:.LC1]
	adrp	x3, .LC2
	ldr	d5, [x3, #:lo12:.LC2]
	.p2align 3,,7
.L22:
	cmp	x8, 1
	bls	.L25
	dup	v1.2d, v2.d[0]
	mov	x3, x2
	.p2align 3,,7
.L20:
	mov	v6.16b, v1.16b
	ldr	q0, [x3]
	mov	v7.16b, v1.16b
	fmla	v6.2d, v0.2d, v3.2d
	fmla	v7.2d, v0.2d, v6.2d
	mov	v6.16b, v7.16b
	mov	v7.16b, v1.16b
	fmla	v7.2d, v0.2d, v6.2d
	mov	v6.16b, v7.16b
	mov	v7.16b, v1.16b
	fmla	v7.2d, v0.2d, v6.2d
	mov	v6.16b, v7.16b
	mov	v7.16b, v1.16b
	fmla	v7.2d, v0.2d, v6.2d
	mov	v6.16b, v7.16b
	mov	v7.16b, v1.16b
	fmla	v7.2d, v0.2d, v6.2d
	mov	v6.16b, v7.16b
	mov	v7.16b, v1.16b
	fmla	v7.2d, v0.2d, v6.2d
	mov	v6.16b, v7.16b
	mov	v7.16b, v1.16b
	fmla	v7.2d, v0.2d, v6.2d
	mov	v6.16b, v7.16b
	mov	v7.16b, v1.16b
	fmla	v7.2d, v0.2d, v6.2d
	mov	v6.16b, v7.16b
	mov	v7.16b, v1.16b
	fmla	v7.2d, v0.2d, v6.2d
	mov	v6.16b, v7.16b
	mov	v7.16b, v1.16b
	fmla	v7.2d, v0.2d, v6.2d
	mov	v6.16b, v7.16b
	mov	v7.16b, v1.16b
	fmla	v7.2d, v0.2d, v6.2d
	mov	v6.16b, v7.16b
	mov	v7.16b, v1.16b
	fmla	v7.2d, v0.2d, v6.2d
	mov	v6.16b, v7.16b
	mov	v7.16b, v1.16b
	fmla	v7.2d, v0.2d, v6.2d
	mov	v6.16b, v7.16b
	mov	v7.16b, v1.16b
	fmla	v7.2d, v0.2d, v6.2d
	mov	v6.16b, v7.16b
	mov	v7.16b, v1.16b
	fmla	v7.2d, v0.2d, v6.2d
	mov	v6.16b, v7.16b
	mov	v7.16b, v1.16b
	fmla	v7.2d, v0.2d, v6.2d
	mov	v6.16b, v7.16b
	mov	v7.16b, v1.16b
	fmla	v7.2d, v0.2d, v6.2d
	mov	v6.16b, v7.16b
	mov	v7.16b, v1.16b
	fmla	v7.2d, v0.2d, v6.2d
	mov	v6.16b, v7.16b
	mov	v7.16b, v1.16b
	fmla	v7.2d, v0.2d, v6.2d
	mov	v6.16b, v7.16b
	mov	v7.16b, v1.16b
	fmla	v7.2d, v0.2d, v6.2d
	mov	v6.16b, v7.16b
	mov	v7.16b, v1.16b
	fmla	v7.2d, v0.2d, v6.2d
	mov	v6.16b, v7.16b
	mov	v7.16b, v1.16b
	fmla	v7.2d, v0.2d, v6.2d
	mov	v6.16b, v7.16b
	mov	v7.16b, v1.16b
	fmla	v7.2d, v0.2d, v6.2d
	mov	v6.16b, v7.16b
	mov	v7.16b, v1.16b
	fmla	v7.2d, v0.2d, v6.2d
	mov	v6.16b, v7.16b
	mov	v7.16b, v1.16b
	fmla	v7.2d, v0.2d, v6.2d
	mov	v6.16b, v7.16b
	mov	v7.16b, v1.16b
	fmla	v7.2d, v0.2d, v6.2d
	mov	v6.16b, v7.16b
	mov	v7.16b, v1.16b
	fmla	v7.2d, v0.2d, v6.2d
	mov	v6.16b, v7.16b
	mov	v7.16b, v1.16b
	fmla	v7.2d, v0.2d, v6.2d
	mov	v6.16b, v7.16b
	mov	v7.16b, v1.16b
	fmla	v7.2d, v0.2d, v6.2d
	mov	v6.16b, v7.16b
	mov	v7.16b, v1.16b
	fmla	v7.2d, v0.2d, v6.2d
	mov	v6.16b, v7.16b
	mov	v7.16b, v1.16b
	fmla	v7.2d, v0.2d, v6.2d
	str	q7, [x3], 16
	cmp	x3, x4
	bne	.L20
	mov	x3, x7
	cmp	x0, x7
	beq	.L21
.L19:
	ldr	d1, [x2, x3, lsl 3]
	add	x5, x3, 1
	cmp	x5, x0
	lsl	x5, x3, 3
	fmadd	d0, d1, d4, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	str	d0, [x2, x3, lsl 3]
	bcs	.L21
	add	x3, x5, 8
	ldr	d1, [x2, x3]
	fmadd	d0, d1, d4, d2
	fmadd	d0, d1, d0, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d0, d1, d2
	fmadd	d0, d1, d0, d2
	fmadd	d0, d1, d0, d2
	fmadd	d0, d1, d0, d2
	fmadd	d0, d1, d0, d2
	fmadd	d0, d1, d0, d2
	fmadd	d0, d1, d0, d2
	fmadd	d0, d1, d0, d2
	fmadd	d0, d1, d0, d2
	fmadd	d0, d1, d0, d2
	fmadd	d0, d1, d0, d2
	fmadd	d0, d1, d0, d2
	fmadd	d0, d1, d0, d2
	fmadd	d0, d1, d0, d2
	fmadd	d0, d1, d0, d2
	str	d0, [x2, x3]
.L21:
	add	x6, x6, 1
	fmul	d2, d2, d5
	cmp	x1, x6
	bhi	.L22
.L12:
	ret
.L25:
	mov	x3, 0
	b	.L19
.L38:
	lsr	x4, x0, 1
	and	x7, x0, -2
	mov	x6, 0
	fmov	d2, 5.0e-1
	b	.L15
.L39:
	mov	x3, 0
	b	.L23
	.cfi_endproc
.LFE44:
	.size	kernel, .-kernel
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC3:
	.string	"%lu,%lu,%3lf,%lu,%lu,%.3lf,%.3lf\n"
	.text
	.align	2
	.p2align 3,,7
	.type	main._omp_fn.0, %function
main._omp_fn.0:
.LFB47:
	.cfi_startproc
	stp	x29, x30, [sp, -144]!
	.cfi_def_cfa_offset 144
	.cfi_offset 29, -144
	.cfi_offset 30, -136
	mov	x29, sp
	stp	x25, x26, [sp, 64]
	.cfi_offset 25, -80
	.cfi_offset 26, -72
	mov	x25, x0
	adrp	x0, :got:__stack_chk_guard
	stp	x19, x20, [sp, 16]
	ldr	x0, [x0, #:got_lo12:__stack_chk_guard]
	stp	x21, x22, [sp, 32]
	ldr	x1, [x0]
	str	x1, [sp, 136]
	mov	x1,0
	stp	x27, x28, [sp, 80]
	.cfi_offset 19, -128
	.cfi_offset 20, -120
	.cfi_offset 21, -112
	.cfi_offset 22, -104
	.cfi_offset 27, -64
	.cfi_offset 28, -56
	bl	omp_get_thread_num
	sxtw	x20, w0
	bl	omp_get_num_threads
	sxtw	x27, w0
	ldp	x19, x1, [x25]
	mov	x21, x20
	str	w0, [x25, 24]
	ldp	w2, w26, [x25, 16]
	udiv	x27, x19, x27
	lsr	x27, x27, 3
	and	x27, x27, 2305843009213693944
	mul	x20, x20, x27
	add	x20, x1, x20, lsl 3
	cbz	x27, .L40
	fmov	v0.2d, 1.0e+0
	mov	x0, x20
	add	x1, x20, x27, lsl 3
.L42:
	str	q0, [x0], 16
	cmp	x0, x1
	bne	.L42
	mov	x0, 4194303
	cmp	x27, x0
	bls	.L40
	mov	x0, 225833675390976
	orr	w21, w2, w21
	add	x22, sp, 128
	stp	x23, x24, [sp, 48]
	.cfi_offset 24, -88
	.cfi_offset 23, -96
	add	x23, sp, 132
	mov	x1, 4562146422526312448
	movk	x0, 0x41cd, lsl 48
	mov	x19, 4194304
	stp	d8, d9, [sp, 96]
	.cfi_offset 73, -40
	.cfi_offset 72, -48
	fmov	d8, x1
	fmov	d9, x0
	str	d10, [sp, 112]
	.cfi_offset 74, -32
.L44:
	adrp	x0, .LC3
	mov	x28, 1
	add	x24, x0, :lo12:.LC3
	b	.L49
	.p2align 2,,3
.L58:
	mov	x1, x28
	mov	x4, x23
	mov	x3, x22
	mov	x2, x20
	mov	x0, x19
	add	x28, x28, 1
	bl	kernel
	bl	GOMP_barrier
	cmp	x28, 601
	beq	.L62
.L49:
	bl	GOMP_barrier
	cbnz	w21, .L58
	bl	omp_get_wtime
	fmov	d10, d0
	mov	x1, x28
	mov	x4, x23
	mov	x3, x22
	mov	x2, x20
	mov	x0, x19
	bl	kernel
	bl	GOMP_barrier
	bl	omp_get_wtime
	fsub	d0, d0, d10
	ldr	w2, [x25, 24]
	mov	x3, x28
	ldp	w4, w7, [sp, 128]
	mov	x1, x24
	mov	w0, 1
	smull	x2, w26, w2
	sxtw	x5, w4
	smull	x4, w4, w7
	mul	x2, x2, x19
	mul	x7, x2, x28
	add	x28, x28, 1
	mul	x2, x5, x2
	lsl	x5, x7, 6
	mul	x4, x4, x7
	ucvtf	d1, x5
	ucvtf	d2, x4
	fdiv	d1, d1, d0
	fdiv	d2, d2, d0
	fdiv	d1, d1, d9
	fmul	d2, d2, d8
	fmul	d2, d2, d8
	fmul	d2, d2, d8
	bl	__printf_chk
	cmp	x28, 601
	bne	.L49
.L62:
	cmp	x19, x19, lsl 1
	lsl	x0, x19, 1
	beq	.L63
	cmp	x27, x0
	bcc	.L61
.L46:
	mov	x19, x0
	b	.L44
.L63:
	add	x0, x19, 1
	cmp	x27, x0
	bcs	.L46
.L61:
	ldp	x23, x24, [sp, 48]
	.cfi_restore 24
	.cfi_restore 23
	ldp	d8, d9, [sp, 96]
	.cfi_restore 73
	.cfi_restore 72
	ldr	d10, [sp, 112]
	.cfi_restore 74
.L40:
	adrp	x0, :got:__stack_chk_guard
	ldr	x0, [x0, #:got_lo12:__stack_chk_guard]
	ldr	x1, [sp, 136]
	ldr	x2, [x0]
	subs	x1, x1, x2
	mov	x2, 0
	bne	.L64
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	ldp	x29, x30, [sp], 144
	.cfi_remember_state
	.cfi_restore 30
	.cfi_restore 29
	.cfi_restore 27
	.cfi_restore 28
	.cfi_restore 25
	.cfi_restore 26
	.cfi_restore 21
	.cfi_restore 22
	.cfi_restore 19
	.cfi_restore 20
	.cfi_def_cfa_offset 0
	ret
.L64:
	.cfi_restore_state
	stp	x23, x24, [sp, 48]
	.cfi_offset 24, -88
	.cfi_offset 23, -96
	stp	d8, d9, [sp, 96]
	.cfi_offset 73, -40
	.cfi_offset 72, -48
	str	d10, [sp, 112]
	.cfi_offset 74, -32
	bl	__stack_chk_fail
	.cfi_endproc
.LFE47:
	.size	main._omp_fn.0, .-main._omp_fn.0
	.align	2
	.p2align 3,,7
	.global	getTime
	.type	getTime, %function
getTime:
.LFB45:
	.cfi_startproc
	b	omp_get_wtime
	.cfi_endproc
.LFE45:
	.size	getTime, .-getTime
	.section	.rodata.str1.8
	.align	3
.LC4:
	.string	"nsize,trials,microseconds,bytes,single_thread_bandwidth,total_bandwidth,GFLOPS,bandwidth(GB/s)"
	.align	3
.LC5:
	.string	"Out of memory!\n"
	.align	3
.LC6:
	.string	"META_DATA"
	.align	3
.LC7:
	.string	"FLOPS          %d\n"
	.align	3
.LC8:
	.string	"OPENMP_THREADS %d\n"
	.section	.text.startup,"ax",@progbits
	.align	2
	.p2align 3,,7
	.global	main
	.type	main, %function
main:
.LFB46:
	.cfi_startproc
	stp	x29, x30, [sp, -96]!
	.cfi_def_cfa_offset 96
	.cfi_offset 29, -96
	.cfi_offset 30, -88
	mov	x0, 1073741824
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	.cfi_offset 19, -80
	.cfi_offset 20, -72
	adrp	x20, :got:__stack_chk_guard
	ldr	x1, [x20, #:got_lo12:__stack_chk_guard]
	ldr	x2, [x1]
	str	x2, [sp, 88]
	mov	x2,0
	bl	malloc
	mov	x19, x0
	adrp	x1, .LC4
	add	x0, x1, :lo12:.LC4
	bl	puts
	cbz	x19, .L71
	adrp	x0, .LC9
	mov	x4, 1073741824
	add	x1, sp, 56
	mov	w3, 0
	ldr	d0, [x0, #:lo12:.LC9]
	mov	w2, 0
	adrp	x0, main._omp_fn.0
	add	x0, x0, :lo12:main._omp_fn.0
	str	x21, [sp, 32]
	.cfi_offset 21, -64
	mov	w21, 1
	stp	x4, x19, [sp, 56]
	str	d0, [sp, 72]
	str	w21, [sp, 80]
	bl	GOMP_parallel
	mov	x0, x19
	ldr	w19, [sp, 80]
	bl	free
	mov	w0, 10
	bl	putchar
	adrp	x0, .LC6
	add	x0, x0, :lo12:.LC6
	bl	puts
	mov	w0, w21
	mov	w2, 64
	adrp	x1, .LC7
	add	x1, x1, :lo12:.LC7
	bl	__printf_chk
	mov	w0, w21
	mov	w2, w19
	adrp	x1, .LC8
	add	x1, x1, :lo12:.LC8
	bl	__printf_chk
	ldr	x21, [sp, 32]
	.cfi_restore 21
	mov	w0, 0
.L66:
	ldr	x20, [x20, #:got_lo12:__stack_chk_guard]
	ldr	x1, [sp, 88]
	ldr	x2, [x20]
	subs	x1, x1, x2
	mov	x2, 0
	bne	.L72
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 96
	.cfi_remember_state
	.cfi_restore 30
	.cfi_restore 29
	.cfi_restore 19
	.cfi_restore 20
	.cfi_def_cfa_offset 0
	ret
.L71:
	.cfi_restore_state
	adrp	x3, :got:stderr
	adrp	x0, .LC5
	mov	x2, 15
	add	x0, x0, :lo12:.LC5
	ldr	x3, [x3, #:got_lo12:stderr]
	mov	x1, 1
	ldr	x3, [x3]
	bl	fwrite
	mov	w0, -1
	b	.L66
.L72:
	str	x21, [sp, 32]
	.cfi_offset 21, -64
	bl	__stack_chk_fail
	.cfi_endproc
.LFE46:
	.size	main, .-main
	.section	.rodata.cst16,"aM",@progbits,16
	.align	4
.LC0:
	.word	2576980378
	.word	1072273817
	.word	2576980378
	.word	1072273817
	.section	.rodata.cst8,"aM",@progbits,8
	.align	3
.LC1:
	.word	2576980378
	.word	1072273817
	.align	3
.LC2:
	.word	4204895303
	.word	1072693247
	.align	3
.LC9:
	.word	0
	.word	1
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
