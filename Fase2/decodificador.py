operationCodeTypeR = [  #Instrucciones de tipo R
    "ADD", "SUB", "SIT", "AND", "OR", "NOT"
]

operationCodeTypeI=[ #Instrucciones de tipo I
    "ADDI", "ANDI", "ORI", "LW", "SW"
]

functTypeR = { # Funct de las instrucciones tipo R
    "SIT": "101010",
    "ADD": "100000",
    "SUB": "100010",
    "AND": "100100",
    "OR" : "100101",
}

opCodeTypeI = { #OpCode de instrucciones tipo I
    "ADDI": "001000",
    "ANDI": "001100",
    "ORI": "001101",
    "LW": "100011",
    "SW": "101011"
}

operationTypeJ = ["J"]

opCodeTypeJ = {
     "J": "000010"
}


def operationType(word): #Se selecciona de que tipo es la instruccion
    if word[0] in operationCodeTypeR: #Se busca dentro de las operaciones de tipo R
        r = typeR(word)
    elif word[0] in operationCodeTypeI:#Se busca dentro de las operacioness de tipo I
        r = typeI(word)
    elif word[0] in operationTypeJ:
        r = typeJ(word)
    else:
        r = "00000000000000000000000000000000"
    
    return r


def typeR(instruction): #Convertidor de bits para instruccion tipo R
    op = "000000"     #Valor op por defecto
    shampt = "00000"  #Valor de shampt por defecto
    prueba = ""   #Aqui se almacenara toda la operacion ordenada

    ["ADD", "$4", "4", "$2"]
    prueba += op    
    rs = int(instruction[2].replace("$", "")) #Se reemplaza el $ por nada
    rs = bin(rs)[2:].zfill(5)       #Se pasa a binario y se asegura de tener 5 bits
    prueba += str(rs)    #Se concatena

    rt = int(instruction[3].replace("$", ""))#Se reemplaza el $ por nada
    rt = bin(rt)[2:].zfill(5)#Se pasa a binario y se asegura de tener 5 bits
    prueba += str(rt)#Se concatena

    rd = int(instruction[1].replace("$", ""))#Se reemplaza el $ por nada
    rd = bin(rd)[2:].zfill(5)#Se pasa a binario y se asegura de tener 5 bits
    prueba += str(rd)#Se concatena    
    
    prueba += shampt

    prueba+= functTypeR[instruction[0]]#Se busca dentro del diciconario para añadir el funct
    return prueba #Retorna la cadena

def typeI(instruction):
    opcode = opCodeTypeI[instruction[0]]  #Se busca su OP en su diccionario
    rs = int(instruction[2].replace("$", "")) #Se reemplaza el $ por nada
    rs = bin(rs)[2:].zfill(5)#Se pasa a binario y se asegura de tener 5 bits
    rt = int(instruction[1].replace("$", ""))#Se reemplaza el $ por nada
    rt = bin(rt)[2:].zfill(5)#Se pasa a binario y se asegura de tener 5 bits
    immediate = bin(int(instruction[3]))[2:].zfill(16)#convierte el valor a binario, elimina
                                            #'0b' y se asegura que tenga una longitud de 16 bits

    return opcode + str(rs) + str(rt) + immediate  #Se concatena todo lo anterior y se regresa  

def typeJ(instruction):
    opcode = opCodeTypeJ[instruction[0]]  # Se busca su OP en su diccionario
    target_address = bin(int(instruction[1]))[2:].zfill(26)  # Convierte la dirección de destino a binario y asegura una longitud de 26 bits
    return opcode + target_address

condicion = True
print("BIENVENIDO")
while condicion:
    print("Ingrese la opcion a realizar")
    print("1.Leer archivo")
    print("2.Salir")
    opcion = input("Opcion: ")
    
    if(opcion == "1"):
        file_name = input("Ingrese el nombre de su archivo a leer: ")#Se ingresa el nombre del archivo
        with open(file_name, 'r') as asm_file:#Se abre el arcihivo en modo de lectura
            asm_instructions = asm_file.readlines() #Se separan las lineas
        
        with open("prueba.bin", 'w') as bin_file: #Se abre un archivo donde se guardaran los bits
            for instruction in asm_instructions:
                word = instruction.strip().split() #Se separa cada palabra de la instruccion
                bin_instruction = operationType(word) #Llama para identificar el tipo de instruccion
                for i in range(0, len(bin_instruction), 8): #Se separa en 8 bits
                    bin_file.write(bin_instruction[i:i+8] + '\n')
                
    elif(opcion == "2"):
        condicion = False
    else:
        print("OPCION NO VALIDA\n") 

print("HASTA LUEGO")

with open("prueba.bin", "rb") as bin_file:
    binary_content = bin_file.read()
    print(binary_content)


 
  
        


