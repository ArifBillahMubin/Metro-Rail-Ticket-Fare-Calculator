; Macro to print a message from a string variable
print_msg macro string
    lea dx, string       ; Load the address of the string into DX
    mov ah, 09h          ; Function 09h: Print string in DOS
    int 21h              ; Call DOS interrupt to print string
endm

; Macro to take input from the user
input MACRO
    mov ah, 01h          ; Function 01h: Read a character from input
    int 21h              ; Call DOS interrupt to read a character
endm

; Macro to print a new line (carriage return and line feed)
new_line MACRO
    mov ah, 02h          ; Function 02h: Print a single character
    mov dl, 0dh          ; Load carriage return (0Dh) into DL
    int 21h              ; Call DOS interrupt to print the carriage return
    mov dl, 0ah          ; Load line feed (0Ah) into DL
    int 21h              ; Call DOS interrupt to print the line feed
endm

; Macro to print a single character using the register
print MACRO n
    mov dl, n            ; Move the character to DL register
    mov ah, 02h          ; Function 02h: Print the character in DL
    int 21h              ; Call DOS interrupt to print the character
endm

; Macro to calculate the total fare based on the number of passengers
calculator MACRO n
    mov bl, n            ; Load fare per passenger into BL
    print_msg passenger_number ; Print the message asking for the number of passengers
    
    input                ; Get the number of passengers as input
    sub al, 48           ; Convert ASCII to integer (subtract '0')
    
    mul bl               ; Multiply AL (number of passengers) by BL (fare per passenger)
    aam                  ; Convert AX (result) into unpacked BCD (Binary-Coded Decimal)

    mov cx, ax           ; Copy AX into CX (since result is in AX)
    add ch, 48           ; Convert the tens place to ASCII ('0' = 48)
    add cl, 48           ; Convert the ones place to ASCII ('0' = 48)
    
    print_msg total_fare_msg  ; Print "Total Fare" message
    print ch             ; Print the tens digit of fare
    print cl             ; Print the ones digit of fare
    print '0'            ; Print the decimal point
    print_msg bdt_msg    ; Print currency message "/- BDT.$"
    print_msg line_msg2  ; Print a line separator
endm

.model small          ; Define the memory model
.stack 100h           ; Set stack size to 100h (256 bytes)

.data
    ; General messages
    bdt_msg DB "/- BDT.$" ; Currency message (Bangladeshi Taka)

    ; Home/Main Menu Page
    wlc_line DB 13, 10, " *****************************************************************$"
    wlc_msg DB 13, 10, " **         Welcome to Metro Rail Ticket Fare Calculator        **$"
    intro_msg DB 13, 10, " **           Welcome to Shewrapara Metro Rail Station          **$"
    course_name DB 13, 10, " **           Microprocessor and Microcontrollers Project       **$"                                         
    developer_name DB 13, 10, " **           Develop by Md.Shajalal [223002088]         **$"                                         

    menu_msg DB 13, 10, 13, 10, "                 *        MAIN MENU         ***$" ; Main menu message
    menu_item1 DB 13, 10, "                 [1] North Bound.$" ; North bound menu option
    menu_item2 DB 13, 10, "                 [2] South Bound.$" ; South bound menu option
    exit_msg DB 13, 10, "                 [3] Exit.$" ; Exit menu option

    line_msg DB 13, 10, "                 ---------------------------------$" ; Separator line
    menu_choose_msg DB 13, 10, "                 Which side do you want to go: $" ; Prompt message to choose side

    line_msg2 DB 13, 10, " ---------------------------------$" ; Separator line for the station selection

    ; North Bound Page Messages
    north_intro_msg DB 13, 10, " **                   Welcome to North Side                     **$"
    north_bound_station_list DB 13, 10, " **                 North Bound Station List                    **$"
    north_station_fare DB 13, 10, " **               Northbound Station and Fare                   **$"

    ; North bound station names and fares
    kazipara DB 13, 10, " [1] Kazipara        ------------------------------------   20 BDT$"
    mirpur10 DB 13, 10, " [2] Mirpur-10       ------------------------------------   20 BDT$"
    mirpur11 DB 13, 10, " [3] Mirpur 11       ------------------------------------   20 BDT$"
    pallabi DB 13, 10, " [4] Pallabi         ------------------------------------   30 BDT$"
    uttara_south DB 13, 10," [5] Uttara South    ------------------------------------   40 BDT$"
    uttara_center DB 13, 10," [6] Uttara Center   ------------------------------------   40 BDT$"
    uttara_north DB 13, 10," [7] Uttara North    ------------------------------------   50 BDT$"

    north_station_select DB 13, 10, " Which Station you wanna travel: $" ; Prompt for station selection
    passenger_number DB 13, 10, " Enter Passengers Number: $" ; Prompt for number of passengers
    total_fare_msg DB 13, 10, " Total Fare: $" ; Total fare message

    ; South Bound Page Messages
    south_intro_msg DB 13, 10, " **                   Welcome to South Side                     **$"
    south_bound_station_list DB 13, 10, " **                 South Bound Station List                    **$"
    south_station_fare DB 13, 10, " **               Southbound Station and Fare                   **$"

    ; South bound station names and fares
    agargaon DB 13, 10," [1] Agargaon                ----------------------------   20 BDT$"
    bijoy_sarani DB 13, 10," [2] Bijoy Sarani            ----------------------------   20 BDT$"
    farmgate DB 13, 10," [3] Farmgate                ----------------------------   20 BDT$"
    kawran_bazar DB 13, 10," [4] Kawran Bazar            ----------------------------   30 BDT$"
    shahbagh DB 13, 10," [5] Shahbagh                ----------------------------   40 BDT$"
    dhaka_niversity DB 13, 10," [6] Dhaka University        ----------------------------   40 BDT$"
    bangladesh_secretariat DB 13, 10," [7] Bangladesh Secretariat  ----------------------------   50 BDT$"
    motijheel DB 13, 10," [8] Motijheel               ----------------------------   50 BDT$"
    kamlapur DB 13, 10," [9] Kamlapur                ----------------------------   60 BDT$"

.code
main proc
    mov ax, @data        ; Set up the data segment
    mov ds, ax           ; Load the data segment into DS register

    ; Reset all registers
    sub ax, ax           ; Clear AX register
    sub bx, bx           ; Clear BX register
    sub cx, cx           ; Clear CX register
    sub dx, dx           ; Clear DX register

Home:
    print_msg wlc_line    ; Print the welcome line
    print_msg wlc_msg     ; Print the welcome message
    print_msg intro_msg   ; Print the introduction message
    print_msg course_name ; Print the course name message
    print_msg developer_name ; Print the developer's name message
    print_msg wlc_line    ; Print the welcome line again

    print_msg menu_msg    ; Print the main menu message
    print_msg line_msg    ; Print the separator line
    print_msg menu_item1  ; Print North Bound option
    print_msg menu_item2  ; Print South Bound option
    print_msg exit_msg    ; Print Exit option

    print_msg line_msg    ; Print the separator line
    print_msg menu_choose_msg ; Print the prompt to choose side
    input                 ; Take input from the user (1, 2, or 3)
    mov bl, al            ; Move input (user choice) into BL register

    print_msg line_msg    ; Print the separator line
    new_line              ; Print a new line

    sub bl, 48            ; Convert ASCII value to integer (0-2)

    cmp bl, 1             ; Compare input with 1 (North Bound)
    je CALL northbound    ; Jump to northbound if input is 1

    cmp bl, 2             ; Compare input with 2 (South Bound)
    je CALL southbound    ; Jump to southbound if input is 2

    cmp bl, 3             ; Compare input with 3 (Exit)
    je Exit               ; Jump to Exit if input is 3

    jmp Home              ; Jump to Home if input is invalid
main endp

; Procedure for North Bound options
northbound proc
    new_line new_line    ; Print two new lines
    print_msg wlc_line   ; Print welcome line
    print_msg north_intro_msg ; Print North Bound introduction message
    print_msg north_bound_station_list ; Print station list
    print_msg north_station_fare ; Print fare information
    print_msg wlc_line   ; Print line separator

    new_line
    print_msg kazipara   ; Print Kazipara station info
    print_msg mirpur10    ; Print Mirpur-10 station info
    print_msg mirpur11    ; Print Mirpur 11 station info
    print_msg pallabi     ; Print Pallabi station info
    print_msg uttara_south ; Print Uttara South station info
    print_msg uttara_center ; Print Uttara Center station info
    print_msg uttara_north ; Print Uttara North station info
    new_line
    print_msg line_msg2  ; Print separator line

    print_msg north_station_select ; Prompt to select station
    input                 ; Take input for station selection
    mov bl, al            ; Move input to BL register
    sub bl, 48            ; Convert ASCII to integer

    ; Check station selection and jump to appropriate fare calculation
    cmp bl, 1
    je Twenty
    cmp bl, 2
    je Twenty
    cmp bl, 3
    je Twenty
    cmp bl, 4
    je Thirty
    cmp bl, 5
    je Forty
    cmp bl, 6
    je Forty
    cmp bl, 7
    je Fifty
northbound endp

; Procedure for South Bound options
southbound proc
    new_line new_line    ; Print two new lines
    print_msg wlc_line   ; Print welcome line
    print_msg south_intro_msg ; Print South Bound introduction message
    print_msg south_bound_station_list ; Print station list
    print_msg south_station_fare ; Print fare information
    print_msg wlc_line   ; Print line separator

    new_line
    print_msg agargaon    ; Print Agargaon station info
    print_msg bijoy_sarani ; Print Bijoy Sarani station info
    print_msg farmgate    ; Print Farmgate station info
    print_msg kawran_bazar ; Print Kawran Bazar station info
    print_msg shahbagh    ; Print Shahbagh station info
    print_msg dhaka_niversity ; Print Dhaka University station info
    print_msg bangladesh_secretariat ; Print Bangladesh Secretariat info
    print_msg motijheel   ; Print Motijheel station info
    print_msg kamlapur    ; Print Kamlapur station info
    new_line
    print_msg line_msg2   ; Print separator line

    print_msg north_station_select ; Prompt to select station
    input                 ; Take input for station selection

    mov bl, al            ; Move input to BL register
    sub bl, 48            ; Convert ASCII to integer

    ; Check station selection and jump to appropriate fare calculation
    cmp bl, 1
    je Twenty
    cmp bl, 2
    je Twenty
    cmp bl, 3
    je Twenty
    cmp bl, 4
    je Thirty
    cmp bl, 5
    je Forty
    cmp bl, 6
    je Forty
    cmp bl, 7
    je Fifty
    cmp bl, 8
    je Fifty
    cmp bl, 9
    je Sixty
southbound endp

; Fare calculation based on station selection
digit_calculate proc
    ; Calculate fare based on selected station
    Twenty:
        calculator 2
        jmp Call_Home_Page

    Thirty:
        calculator 3
        jmp Call_Home_Page

    Forty:
        calculator 4
        jmp Call_Home_Page

    Fifty:
        calculator 5
        jmp Call_Home_Page

    Sixty:
        calculator 6
        jmp Call_Home_Page

    Seventy:
        calculator 7
        jmp Call_Home_Page
digit_calculate endp

; Return to the home menu
Call_Home_Page:
    new_line new_line new_line  ; Print new lines
    jmp Home                    ; Jump back to Home procedure

; Exit the program
Exit:
    mov ah, 4ch          ; Function 4Ch: Terminate the program
    int 21h              ; Call DOS interrupt to exit the program

end main
