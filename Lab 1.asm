	# I.....
	# 17
	# Section: 2
	# Lab 1 Exercise
	#1. Print out a message string with a welcome message "Welcome to Lab 1 exercise. Please enter your name "
        #2. Get an input from user to enter his/her name
        #3. Print out a message string with a hello message and followed by the user's name (e.g. "Hello Adam")
        #4. Manipulate the user's name to output an encrypted user name with a 7 place displacement (i.e. A=H, d=k, a=h, m=t)
        #5. Print out the encrypted user name with a short message ("Hi Adam, your encrypted user name is Hkht")
        #6. End the code
        #7. Optimise the code using procedures whenever possible.
		
	.data
	welcome: .asciiz "*** Welcome to Lab 1 exercise***\n"
	ms: .asciiz "Please enter your name: "
	print: .asciiz "--------------------------------\n"
 	msg: .asciiz "\thello "
 	hi: .asciiz "Hi "
 	name: .space 10
 	encrpname: .space 10
 	msg2: .asciiz "Your encrypted name is: "
 
	.text
	main:
	
         # Print out a message string with a welcome message
         li $v0,4
         la $a0, welcome
         syscall 
        
         li $v0,4
         la $a0, print
         syscall 
         
         li $v0,4
         la $a0, ms
         syscall 
 	# Get an input from user to enter his/her name
 	la $a0,name
	la $a1,10 		
 	li $v0,8
 	syscall
 	la $t0,($a0) 		# Entered string is stored in the t0 register
 	li $t1,0 		# string length
 	
        #  Print out a message string with a hello message and the user's name
 	li $v0, 4
  	la $a0, msg
  	syscall
  	li $v0, 4
  	la $a0, name
  	syscall
  	
         #  Print out a message string with a Hi message and the user's name
  	li $v0, 4
        la $a0, hi
        syscall
        
  	li $v0, 4
        la $a0, name
        syscall

  	li $v0, 4
        la $a0, msg2
        syscall
  	#Print out the encrypted user name with a short message 

        
 	#Manipulate the user's name to output an encrypted user nam
	Encrypt:
 	lb $t4, 0($t0)  	 	# The first character is read
 	beq $t4,10,end 	 	
 	beqz $t4,end  			
 	jal islower 
  	
  	# Check if the character is lower case
	Encrypt2:
 	beq $v0,1,EncryptLower   	
	beq $v0,0,EncryptUpper   	
	move $a0, $t4   		

	PrintEncryptChar:
 	li $v0,11 			# print the encrypted character
 	syscall
 	add $t0,$t0,1 			
 	add $t1,$t1,1 			
 	j Encrypt
 
	 end:
	 li $v0,10
 	 syscall
 
	
	# For the use of Encryption

	islower:
 	bgt $t4,122,NotlowerOrupper	 	# if the character is not lower case or upper case
	blt $t4,97,IsupperORanyother 		# if the character is not lower case 
 	li $v0,1   				
 	jr $ra    	
 	
 	
	NotlowerOrupper:
 	li $v0,2   				# store value 2 in register VO if the character is not lower or upper
 	j Encrypt2                              # jump back
 	
 	
	IsupperORanyother:
 	blt $t4,65,NotlowerOrupper		
 	bgt $t4,91,NotlowerOrupper 		
 	li $v0,0   				# store value 0 in register V0 if the character is upper case
 	j Encrypt2
 
	EncryptLower:
	li $t5,26   				# Encrypt lower case characters
 	sub $t4,$t4,97
 	add $t4, $t4, 7
 	div $t4,$t5
 	mfhi $a0
 	addi $a0,$a0,97
 
 	j PrintEncryptChar
 
	EncryptUpper:
 	li $t5,26   				# Encrypt Upper case characters
 	sub $t4,$t4,65
 	add $t4, $t4, 7
 	div $t4,$t5
 	mfhi $a0
 	addi $a0,$a0,65
 	j PrintEncryptChar
         
         # End the code
         li $v0,10
 	 syscall
 