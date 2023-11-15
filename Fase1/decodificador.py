operationCodeTypeR = [  #Instrucciones de tipo R
    "ADD", "SUB", "SIT", "AND", "OR"
]

functType = { # Funct de las operaciones
    "SIT": "101010",
    "ADD": "100000",
    "SUB": "100010",
    "AND": "100100",
    "OR" : "100101"
}


def operationType(word): #Se selecciona de que tipo es la instruccion
    if word[0] in operationCodeTypeR: #Se busca dentro de las operaciones de tipo R
        r = typeR(word)
    
    return r


def typeR(instruction): #Convertidor de bits para instruccion tipo R
    op = "000000"     
    shampt = "00000"
    prueba = ""   #Aqui se almacenara toda la operacion ordenada

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

    prueba+= functType[instruction[0]]#Se busca dentro del diciconario para añadir el funct
    return prueba #Retorna la cadena

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




 
  
        


