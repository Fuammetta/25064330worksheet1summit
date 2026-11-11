
# Compiler settings
NASM = nasm
CC = gcc
CFLAGS = -m32
NASMFLAGS = -f elf

# Programs to build
PROGRAMS = first one task2_1 task2_2 task2_3

# Default target
all: $(PROGRAMS)

# Compile assembly files
%.o: %.asm
	$(NASM) $(NASMFLAGS) $< -o $@

# Compile C driver
driver.o: driver.c
	$(CC) $(CFLAGS) -c driver.c -o driver.o

# Compile assembly input/output library
asm_io.o: asm_io.asm
	$(NASM) $(NASMFLAGS) asm_io.asm -o asm_io.o

# Link each program
$(PROGRAMS): %: driver.o %.o asm_io.o
	$(CC) $(CFLAGS) driver.o $*.o asm_io.o -o $@

# Remove generated files
clean:
	rm -f *.o $(PROGRAMS)

.PHONY: all clean
