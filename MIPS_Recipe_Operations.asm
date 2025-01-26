##############################################################
#Array
##############################################################
#   4 Bytes - Address of the Data
#   4 Bytes - Size of array
#   4 Bytes - Size of elements
##############################################################

##############################################################
#Linked List
##############################################################
#   4 Bytes - Address of the First Node
#   4 Bytes - Size of linked list
##############################################################

##############################################################
#Linked List Node
##############################################################
#   4 Bytes - Address of the Data
#   4 Bytes - Address of the Next Node
##############################################################

##############################################################
#Recipe
##############################################################
#   4 Bytes - Name (address of the name)
#	4 Bytes - Ingredients (address of the ingredients array)
#   4 Bytes - Cooking Time
#	4 Bytes - Difficulty
#	4 Bytes - Rating
##############################################################


.data
space: .asciiz " "
newLine: .asciiz "\n"
tab: .asciiz "\t"
lines: .asciiz "------------------------------------------------------------------\n"


listStr: .asciiz "List: \n"
recipeName: .asciiz "Recipe name: "
ingredients: .asciiz "Ingredients: "
cookingTime: .asciiz "Cooking time: "
difficulty: .asciiz "Difficulty: "
rating: .asciiz "Rating: "
listSize: .asciiz "List Size: "
emptyListWarning: .asciiz "List is empty!\n"
indexBoundWarning: .asciiz "Index out of bounds!\n"
recipeNotMatch: .asciiz "Recipe not matched!\n"
recipeMatch: .asciiz "Recipe matched!\n"
recipeAdded: .asciiz "Recipe added.\n"
recipeRemoved: .asciiz "Recipe removed.\n"
noRecipeWarning: .asciiz "No recipe to print!\n"

addressOfRecipeList: .word 0 #the address of the array of recipe list stored here!


# Recipe 1: Pancakes
r1: .asciiz "Pancakes"
r1i1: .asciiz "Flour"
r1i2: .asciiz "Milk"
r1i3: .asciiz "Eggs"
r1i4: .asciiz "Sugar"
r1i5: .asciiz "Baking powder"
r1c: .word 15							# Cooking time in minutes
r1d: .word 2							# Difficulty (scale 1-5)
r1r: .word 4							# Rating (scale 1-5)

# Recipe 2: Spaghetti Bolognese
r2: .asciiz "Spaghetti Bolognese"
r2i1: .asciiz "Spaghetti"
r2i2: .asciiz "Ground beef"
r2i3: .asciiz "Tomato sauce"
r2i4: .asciiz "Garlic"
r2i5: .asciiz "Onion"
r2c: .word 30
r2d: .word 3
r2r: .word 5

# Recipe 3: Chicken Stir-Fry
r3: .asciiz "Chicken Stir-Fry"
r3i1: .asciiz "Chicken breast"
r3i2: .asciiz "Soy sauce"
r3i3: .asciiz "Bell peppers"
r3i4: .asciiz "Broccoli"
r3i5: .asciiz "Garlic"
r3c: .word 20
r3d: .word 3
r3r: .word 4

# Recipe 4: Caesar Salad
r4: .asciiz "Caesar Salad"
r4i1: .asciiz "Romaine lettuce"
r4i2: .asciiz "Caesar dressing"
r4i3: .asciiz "Parmesan cheese"
r4i4: .asciiz "Croutons"
r4i5: .asciiz "Chicken breast (optional)"
r4c: .word 10
r4d: .word 1
r4r: .word 4

# Recipe 5: Chocolate Chip Cookies
r5: .asciiz "Chocolate Chip Cookies"
r5i1: .asciiz "Butter"
r5i2: .asciiz "Sugar"
r5i3: .asciiz "Flour"
r5i4: .asciiz "Eggs"
r5i5: .asciiz "Chocolate chips"
r5c: .word 25
r5d: .word 2
r5r: .word 5


search1: .asciiz "Caesar Salad"
search2: .asciiz "Shepherd's Pie"

.text
main:
    # 1. Initialize the Recipe List:
    jal createLinkedList           # Create linked list
    sw $v0, addressOfRecipeList    # Store the address of the list

    # 2. Create and Add Pancakes Recipe:
    # Create ingredients array
    li $a0, 5                      # 5 elements
    li $a1, 4                      # 4 bytes per element
    jal createArray                # Create ingredients array
    move $s0, $v0                  # Save array address

    # Add ingredients to Pancakes array
    move $a0, $s0
    li $a1, 0
    la $a2, r1i1                    # Flour
    jal putElementToArray

    move $a0, $s0
    li $a1, 1
    la $a2, r1i2                    # Milk
    jal putElementToArray

    move $a0, $s0
    li $a1, 2
    la $a2, r1i3                    # Eggs
    jal putElementToArray

    move $a0, $s0
    li $a1, 3
    la $a2, r1i4                    # Sugar
    jal putElementToArray

    move $a0, $s0
    li $a1, 4
    la $a2, r1i5                   # Baking Powder
    jal putElementToArray

    # Create Pancakes Recipe
    la $a0, r1                     # Recipe name
    move $a1, $s0                  # Ingredients array
    lw $a2, r1c                    # Cooking time
    lw $a3, r1d                    # Difficulty
    
    # Prepare rating for stack
    addi $sp, $sp, -4
    lw $t1, r1r                    # Rating
    sw $t1, 0($sp)
    jal createRecipe               # Create recipe structure
    add $sp, $sp, 4

    # Enqueue Pancakes Recipe
    lw $a0, addressOfRecipeList    # Linked list address
    move $a1, $v0
    jal enqueue

    # 3. Create and Add Spaghetti Bolognese Recipe:
    # Create ingredients array
    li $a0, 5                      # 5 elements
    li $a1, 4                      # 4 bytes per element
    jal createArray                # Create ingredients array
    move $s0, $v0                  # Save array address

    # Add ingredients to Spaghetti Bolognese array
    move $a0, $s0
    li $a1, 0
    la $a2, r2i1                   # Spaghetti
    jal putElementToArray

    move $a0, $s0
    li $a1, 1
    la $a2, r2i2                   # Ground beef
    jal putElementToArray

    move $a0, $s0
    li $a1, 2
    la $a2, r2i3                    # Tomato sauce
    jal putElementToArray

    move $a0, $s0
    li $a1, 3
    la $a2, r2i4                   # Garlic
    jal putElementToArray

    move $a0, $s0
    li $a1, 4
    la $a2, r2i5                    # Onion
    jal putElementToArray

    # Create Spaghetti Bolognese Recipe
    la $a0, r2                     # Recipe name
    move $a1, $s0                  # Ingredients array
    lw $a2, r2c                    # Cooking time
    lw $a3, r2d                    # Difficulty
    
    # Prepare rating for stack
    addi $sp, $sp, -4
    lw $t1, r2r                    # Rating
    sw $t1, 0($sp)
    jal createRecipe               # Create recipe structure
    add $sp, $sp, 4

    # Enqueue Spaghetti Bolognese Recipe
    lw $a0, addressOfRecipeList    # Linked list address
    move $a1, $v0                  # Recipe structure
    jal enqueue

    li $v0, 4
    la $a0, listSize
    syscall

    # 4. Print Queue Size:
    lw $a0, addressOfRecipeList
    jal queueSize                   # Go queue size function

    move $a0, $v0
    li $v0, 1                       # Size integer
    syscall

    li $v0, 4
    la $a0, newLine
    syscall

    # 5. Print Current Recipes in the List:
    li $v0, 4
    la $a0, listStr                 # "List: "
    syscall

    li $v0, 4
    la $a0, lines
    syscall

    lw $a0, addressOfRecipeList
    la $a1, printRecipe             # This function will use in other function
    jal traverseLinkedList          # Go to this function for print recipes

    li $v0, 4
    la $a0, lines
    syscall

    li $v0, 4
    la $a0, newLine
    syscall

    # 6. Dequeue and Print the First Recipe:
    lw $a0, addressOfRecipeList
    jal dequeue                     # Dequeue

    lw $a0, 0($v0)
    jal printRecipe                 # Print the removed recipe
    
    li $v0, 4
    la $a0, newLine
    syscall

    li $v0, 4
    la $a0, listSize
    syscall

    # 7. Print Queue Size:
    lw $a0, addressOfRecipeList
    jal queueSize

    move $a0, $v0
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, newLine
    syscall

    # 8. Print Remaining Recipes:
    li $v0, 4
    la $a0, listStr
    syscall

    li $v0, 4
    la $a0, lines
    syscall

    lw $a0, addressOfRecipeList
    la $a1, printRecipe             # This function will use in other function
    jal traverseLinkedList

    li $v0, 4
    la $a0, lines
    syscall

    li $v0, 4
    la $a0, newLine
    syscall

    # 9. Dequeue and Print the Next Recipe:
    lw $a0, addressOfRecipeList     
    jal dequeue                     # Dequeue
    lw $a0, 0($v0)
    jal printRecipe                 # Print the rermoved reciepe.

    li $v0, 4
    la $a0, newLine
    syscall

    # 10. Dequeue and Print when List is Empty:
    lw $a0, addressOfRecipeList
    jal dequeue                     # Try the dequeue in empty list
    
    move $a0, $v0
    jal printRecipe

    li $v0, 4
    la $a0, newLine
    syscall

    li $v0, 4
    la $a0, listSize
    syscall

    # 11. Print Queue Size:
    lw $a0, addressOfRecipeList
    jal queueSize

    move $a0, $v0
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, newLine
    syscall

    # 12. Print Remaining Recipes (Empty List):
    li $v0, 4
    la $a0, listStr
    syscall

    li $v0, 4
    la $a0, lines
    syscall

    lw $a0, addressOfRecipeList
    la $a1, printRecipe
    jal traverseLinkedList

    li $v0, 4
    la $a0, lines
    syscall

    li $v0, 4
    la $a0, newLine
    syscall

    # 13. Create and Add Chicken Stir-Fry Recipe:
    # Create ingredients array
    li $a0, 5                      # 5 elements
    li $a1, 4                      # 4 bytes per element
    jal createArray                # Create ingredients array
    move $s0, $v0                  # Save array address

    # Add ingredients to Chicken Stir-Fry array
    move $a0, $s0
    li $a1, 0
    la $a2, r3i1                   # Chicken breast
    jal putElementToArray

    move $a0, $s0
    li $a1, 1
    la $a2, r3i2                   # Soy sauce
    jal putElementToArray

    move $a0, $s0
    li $a1, 2
    la $a2, r3i3                   # Bell peppers
    jal putElementToArray

    move $a0, $s0
    li $a1, 3
    la $a2, r3i4                   # Broccoli
    jal putElementToArray

    move $a0, $s0
    li $a1, 4
    la $a2, r3i5                   # Garlic
    jal putElementToArray

    # Create Chicken Stir-Fry Recipe
    la $a0, r3                     # Recipe name
    move $a1, $s0                  # Ingredients array
    lw $a2, r3c                    # Cooking time
    lw $a3, r3d                    # Difficulty
    
    # Prepare rating for stack
    addi $sp, $sp, -4
    lw $t1, r3r                    # Rating
    sw $t1, 0($sp)
    jal createRecipe               # Create recipe structure
    add $sp, $sp, 4

    # Enqueue Chicken Stir-Fry Recipe
    lw $a0, addressOfRecipeList    # Linked list address
    move $a1, $v0                  # Recipe structure
    jal enqueue

    li $v0, 4
    la $a0, listSize
    syscall

    # 14. Print Queue Size
    lw $a0, addressOfRecipeList
    jal queueSize


    move $a0, $v0
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, newLine
    syscall

    # 15. Print Current Recipes in the List
    li $v0, 4
    la $a0, listStr
    syscall

    li $v0, 4
    la $a0, lines
    syscall

    lw $a0, addressOfRecipeList
    la $a1, printRecipe
    jal traverseLinkedList

    li $v0, 4
    la $a0, lines
    syscall

    li $v0, 4
    la $a0, newLine
    syscall

    # 16. Create and Add Caesar Salad Recipe:
    # Create ingredients array
    li $a0, 4                      # 4 elements (the warning will take)
    li $a1, 4                      # 4 bytes per element
    jal createArray                # Create ingredients array
    move $s0, $v0                  # Save array address

    # Add ingredients to Caesar Salad array
    move $a0, $s0
    li $a1, 0
    la $a2, r4i1                   # Romaine lettuce
    jal putElementToArray

    move $a0, $s0
    li $a1, 1
    la $a2, r4i2                   # Caesar dressing
    jal putElementToArray

    move $a0, $s0
    li $a1, 2
    la $a2, r4i3                   # Parmesan cheese
    jal putElementToArray

    move $a0, $s0
    li $a1, 3
    la $a2, r4i4                   # Croutons
    jal putElementToArray

    move $a0, $s0
    li $a1, 4
    la $a2, r4i4                   # Added this lines for "index out of bounds" warning
    jal putElementToArray

    # Create Caesar Salad Recipe
    la $a0, r4                     # Recipe name
    move $a1, $s0                  # Ingredients array
    lw $a2, r4c                    # Cooking time
    lw $a3, r4d                    # Difficulty
    
    # Prepare rating for stack:
    addi $sp, $sp, -4
    lw $t1, r4r                    # Rating
    sw $t1, 0($sp)
    jal createRecipe               # The recipe structure creating
    add $sp, $sp, 4

    # Enqueue Caesar Salad Recipe:
    lw $a0, addressOfRecipeList    # Linked list address
    move $a1, $v0                  # Recipe structure
    jal enqueue

    li $v0, 4
    la $a0, listSize
    syscall

    # 17. Print Queue Size
    lw $a0, addressOfRecipeList
    jal queueSize


    move $a0, $v0
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, newLine
    syscall

    # 18. Print Current Recipes in the List:
    li $v0, 4
    la $a0, listStr
    syscall

    li $v0, 4
    la $a0, lines
    syscall

    lw $a0, addressOfRecipeList
    la $a1, printRecipe
    jal traverseLinkedList

    li $v0, 4
    la $a0, lines
    syscall

    li $v0, 4
    la $a0, newLine
    syscall

    # 19. Create and Add Chocolate Chip Cookies Recipe:
    # Create ingredients array
    li $a0, 5                      # 5 elements
    li $a1, 4                      # 4 bytes per element
    jal createArray                # Create ingredients array
    move $s0, $v0                  # Save array address

    # Add ingredients to Chocolate Chip Cookies array
    move $a0, $s0
    li $a1, 0
    la $a2, r5i1                   # Butter
    jal putElementToArray

    move $a0, $s0
    li $a1, 1
    la $a2, r5i2                   # Sugar
    jal putElementToArray

    move $a0, $s0
    li $a1, 2
    la $a2, r5i3                   # Flour
    jal putElementToArray

    move $a0, $s0
    li $a1, 3
    la $a2, r5i4                   # Eggs
    jal putElementToArray

    move $a0, $s0
    li $a1, 4
    la $a2, r5i5                   # Chocolate chips
    jal putElementToArray

    # Create Chocolate Chip Cookies Recipe
    la $a0, r5                     # Recipe name
    move $a1, $s0                  # Ingredients array
    lw $a2, r5c                    # Cooking time
    lw $a3, r5d                    # Difficulty
    
    # Prepare rating for stack
    addi $sp, $sp, -4
    lw $t1, r5r                    # Rating
    sw $t1, 0($sp)
    jal createRecipe               # Create recipe structure
    add $sp, $sp, 4

    # Enqueue Chocolate Chip Cookies Recipe
    lw $a0, addressOfRecipeList    # Linked list address
    move $a1, $v0                  # Recipe structure
    jal enqueue

    li $v0, 4
    la $a0, listSize
    syscall

    # 20. Print Queue Size:
    lw $a0, addressOfRecipeList
    jal queueSize

    move $a0, $v0
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, newLine
    syscall

    # 21. Print Current Recipes in the List:
    li $v0, 4
    la $a0, listStr
    syscall

    li $v0, 4
    la $a0, lines
    syscall

    lw $a0, addressOfRecipeList
    la $a1, printRecipe
    jal traverseLinkedList

    li $v0, 4
    la $a0, lines
    syscall

    li $v0, 4
    la $a0, newLine
    syscall

    # 22. Search for Recipes by Name:
    # First recipe search
    lw $a0, addressOfRecipeList
    la $a1, findRecipe
    la $a2, search1
    jal traverseLinkedList
    
    li $v0, 4
    la $a0, newLine
    syscall

    # Second recipe search
    lw $a0, addressOfRecipeList
    la $a1, findRecipe
    la $a2, search2
    jal traverseLinkedList

mainTerminate:
    li $v0, 10
    syscall

# Generic Functions->

createArray:
    # Create an array
	# Inputs: $a0 - max number of elements (size), $a1 - size of elements
	# Outputs: $v0 - address of array
    
    # Calculate total size needed: 12 bytes for header + (size*elementSize) for data
    addi $t0, $zero, 12         # Add header size (4 for data ptr + 4 for size + 4 for elementSize)
    move $t1, $a0
    
    # Allocate memory
    li $v0, 9
    move $a0, $t0
    syscall
    
    # Save the return address
    move $t0, $v0

    mul $a0, $t1, $a1
    li $v0, 9
    syscall
    
    # Store array metadata
    sw $v0, 0($t0)           # Store data section address
    sw $t1, 4($t0)           # Store size
    sw $a1, 8($t0)           # Store element size
    
    # Return array address
    move $v0, $t0
    jr $ra

putElementToArray:
    # Store an element (recipe) in an array.
	# Inputs: $a0 - address of array, $a1 - element address, $a2 - index
    
    # Check bounds
    lw $t0, 4($a0)           # Load array size
    bge $a1, $t0, arrayIndexOutOfBounds # Call the warning string
    
    # Calculate element address
    lw $t0, 0($a0)           # Load data section address
    lw $t1, 8($a0)           # Load element size
    mul $t2, $a1, $t1        # Calculate offset
    add $t0, $t0, $t2        # Add offset to base address
    
    # Store element
    sw $a2, 0($t0)
    
    jr $ra

# Warning for index out of bounds:
arrayIndexOutOfBounds:
    li $v0, 4
    la $a0, indexBoundWarning 
    syscall
    jr $ra

createLinkedList:
    # Create a linked list.
	# Outputs: $v0 - address of linked List
    
    # Allocate memory (8 bytes: 4 for head pointer + 4 for size)
    li $v0, 9
    li $a0, 8
    syscall
    
    # Initialize list
    sw $zero, 0($v0)         # head = null
    sw $zero, 4($v0)         # size = 0
    
    jr $ra

enqueue:
    # Inputs: $a0 - address of the linked list structure, $a1 - address of data to add
    
    # Allocate new node
    move $t3, $a0
    li $v0, 9
    li $a0, 8                # 8 bytes (4 for data + 4 for next)
    syscall
    
    # Initialize new node
    sw $a1, 0($v0)           # node->data = element (C syntax view)
    sw $zero, 4($v0)         # node->next = null (C syntax view)
    
    # Add to list
    lw $t0, 0($t3)           # Load head
    beqz $t0, enqueueEmpty   # If head is null, this is first element.
    
    # Find last node
    move $t1, $t0
enqueueLoop:
    lw $t2, 4($t1)           # Load next pointer
    beqz $t2, enqueueEnd     # If next is null, we found the end.
    move $t1, $t2            # Move to next node
    j enqueueLoop
    
enqueueEnd:
    sw $v0, 4($t1)           # last->next = new node
    j enqueueFinish
    
enqueueEmpty:
    sw $v0, 0($t3)           # head = new node
    
enqueueFinish:
    lw $t0, 4($t3)           # Load size
    addi $t0, $t0, 1         # Increment size
    sw $t0, 4($t3)           # Store new size
    
    li $v0, 4
    la $a0, recipeAdded      # Print added message
    syscall
    
    jr $ra

dequeue:
    # Inputs: $a0 - address of the linked list structure
	# Outputs: $v0 - removed head node, 0 if empty
    
    # Check if list is empty:
    lw $t0, 0($a0)
    beqz $t0, dequeueEmpty
    
    # Get first node's data
    move $t2, $t0
    
    # Update head
    lw $t1, 4($t0)           # Load next
    sw $t1, 0($a0)           # head = next
    
    # Update size
    lw $t1, 4($a0)           # Load size
    addi $t1, $t1, -1         # Decrement size
    sw $t1, 4($a0)           # Store new size
    
    # Print removed message
    li $v0, 4
    la $a0, recipeRemoved
    syscall

    move $v0, $t2
    jr $ra
    
dequeueEmpty:
    
    li $v0, 4
    la $a0, emptyListWarning
    syscall

    li $v0, 4
    la $a0, recipeRemoved
    syscall    
    
    li $v0, 0                # Return null
    jr $ra

queueSize:
    # Inputs: $a0 - address of the linked list structure
    
    lw $v0, 4($a0)           # Load size
    jr $ra

traverseArray:
    # Traverse and print recipes from array.
	# Inputs: $a0 - address of array, $a1 - called function
    
    # Save registers
    addi $sp, $sp, -32
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)
    sw $s3, 16($sp)
    sw $s4, 20($sp)
    sw $s5, 24($sp)
    sw $s6, 28($sp)
    
    # Initialize
    move $s0, $a0            # Save array address
    move $s1, $a1            # Save function address
    li $s2, 0                # Initialize counter
    
    # Get array size
    lw $s3, 4($s0)           # Load size
    
traverseArrayLoop:
    beq $s2, $s3, traverseArrayEnd
    
    # Calculate element address
    lw $s4, 0($s0)           # Load data section address
    lw $s5, 8($s0)           # Load element size
    mul $s6, $s2, $s5        # Calculate offset
    add $s4, $s4, $s6        # Add offset to base address
    
    # Call function
    lw $a0, 0($s4)           # Load element
    jalr $s1                  # Call function
    
    # Increment counter
    addi $s2, $s2, 1
    j traverseArrayLoop
    
traverseArrayEnd:
    # Restore registers
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp)
    lw $s3, 16($sp)
    lw $s4, 20($sp)
    lw $s5, 24($sp)
    lw $s6, 28($sp)
    add $sp, $sp, 32
    
    jr $ra

traverseLinkedList:
    # Traverse linked list.
	# Inputs: $a0 - head node of linked list, $a1 - called function, $a2 - extra arguments
    
    # Save registers
    addi $sp, $sp, -16
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)
    
    # Initialize
    move $s0, $a0            # Save list address
    move $s1, $a1            # Save function address
    move $s2, $a2            # Save extra argument
    
    # Check if list is empty
    lw $t0, 0($s0)           # Load head
    beqz $t0, traverseListEmpty
    
    move $t1, $t0            # Current node
traverseListLoop:
    beqz $t1, traverseListEnd
    
    # Call function
    lw $a0, 0($t1)           # Load element
    move $a1, $s2            # Load extra argument
    jalr $s1                  # Call function
    
    # Move to next node
    lw $t1, 4($t1)
    j traverseListLoop
    
traverseListEmpty:
    li $v0, 4
    la $a0, emptyListWarning
    syscall
    
traverseListEnd:
    # Restore registers
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp)
    add $sp, $sp, 16
    
    jr $ra

compareString:
    # Compare two strings.
	# Inputs: $a0 - string 1 address, $a1 - string 2 address
	# Outputs: $v0 - 0 found, 1 not found
    
    # Save registers
    addi $sp, $sp, -16
    sw $s0, 0($sp)
    sw $s1, 4($sp)
    sw $s2, 8($sp)
    sw $s3, 12($sp)
    
    # Initialize
    move $s0, $a0
    move $s1, $a1
    
compareLoop:
    # Load characters
    lb $s2, 0($s0)
    lb $s3, 0($s1)
    
    # Check if both are null (end of strings)
    beqz $s2, checkEnd
    beqz $s3, notEqual
    
    # Compare characters
    bne $s2, $s3, notEqual
    
    # Move to next characters
    addi $s0, $s0, 1
    addi $s1, $s1, 1
    j compareLoop
    
checkEnd:
    # First string ended. Check if second also ended
    beqz $s2, equal
    
notEqual:
    li $v0, 1
    j compareStringEnd
    
equal:
    li $v0, 0
    
compareStringEnd:
    # Restore registers
    lw $s0, 0($sp)
    lw $s1, 4($sp)
    lw $s2, 8($sp)
    lw $s3, 12($sp)
    add $sp, $sp, 16
    
    jr $ra

# Recipe-specific functions

createRecipe:
    # Create a recipe and store in the recipe struct.
	# Inputs: $a0 - recipe name, $a1 - address of ingredients array,
	#         $a2 - cooking time, $a3 - difficulty, 0($sp) - rating
	# Outputs: $v0 - recipe address

    move $t2, $a0

    # Allocate memory for recipe structure (20 bytes)
    li $v0, 9
    li $a0, 20
    syscall
    
    # Save recipe address
    move $t0, $v0
    
    # Store recipe data
    sw $t2, 0($t0)           # name
    sw $a1, 4($t0)           # ingredients
    sw $a2, 8($t0)           # cooking time
    sw $a3, 12($t0)          # difficulty
    lw $t1, 0($sp)           # rating
    sw $t1, 16($t0)          # rating
    
    # Return recipe address
    move $v0, $t0
    jr $ra

findRecipe:
    # Compare two recipe names.
	# Inputs: $a0 - recipe struct address, $a1 - searched recipe name
    
    # Compare recipe name with searched name
    addi $sp, $sp, -12
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    move $s1, $a0

    lw $s0, 0($a0)           # Load recipe name address
    move $a0, $s0
    jal compareString
    
    # Print result
    beqz $v0, recipeFound
    
    # Recipe not found
    li $v0, 4
    la $a0, recipeNotMatch
    syscall
    j findRecipeEnd
    
    recipeFound:
    li $v0, 4
    la $a0, recipeMatch
    syscall
    
    # Print recipe details
    move $a0, $s1
    jal printRecipe
    
findRecipeEnd:
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    addi $sp, $sp, 12
    jr $ra

printRecipe:
    # Print recipe details.
	# Inputs: $a0 - address of recipe struct
    
    beq $a0, $zero, noRecipe

    # Save registers
    addi $sp, $sp, -12
    sw $a1, 8($sp)
    sw $s0, 4($sp)
    sw $ra, 0($sp)
    move $s0, $a0
    
    # Print recipe name
    li $v0, 4
    la $a0, recipeName
    syscall
    
    lw $a0, 0($s0)           # Load recipe name
    syscall
    
    li $v0, 4
    la $a0, newLine
    syscall
    
    # Print ingredients header
    li $v0, 4
    la $a0, ingredients
    syscall
    
    la $a0, newLine
    syscall
    
    # Print ingredients
    lw $a0, 4($s0)           # Load ingredients array
    la $a1, printIngredient
    jal traverseArray
    
    # Print cooking time
    li $v0, 4
    la $a0, cookingTime
    syscall
    
    lw $a0, 8($s0)           # Load cooking time
    li $v0, 1
    syscall
    
    li $v0, 4
    la $a0, newLine
    syscall
    
    # Print difficulty
    li $v0, 4
    la $a0, difficulty
    syscall
    
    lw $a0, 12($s0)          # Load difficulty
    li $v0, 1
    syscall
    
    li $v0, 4
    la $a0, newLine
    syscall
    
    # Print rating
    li $v0, 4
    la $a0, rating
    syscall
    
    lw $a0, 16($s0)          # Load rating
    li $v0, 1
    syscall
    
    li $v0, 4
    la $a0, newLine
    syscall
    
    # Restore registers
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $a1, 8($sp)
    addi $sp, $sp, 12
    jr $ra
    noRecipe:
    la $a0, noRecipeWarning
    li $v0, 4
    syscall
    jr $ra

printIngredient:
    # Print ingredient.
	# Inputs: $a0 - address of ingredient

    addi $sp, $sp, -4
    sw $a0, 0($sp)

    la $a0, tab           # Load the chacarter tab
    li $v0, 4
    syscall

    lw $a0 0($sp)           # Load the ingredient
    addi $sp, $sp, 4

    li $v0, 4
    syscall

    la $a0, newLine
    syscall
    
    jr $ra