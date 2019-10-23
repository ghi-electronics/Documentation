OUTPUT_NAME = InteropTest
LINKERSCRIPT_NAME = scatterfile

MCU_FLAGS = -mcpu=cortex-m4 -mthumb
INC_DIRS = -I.

CC = arm-none-eabi-g++.exe
LD = arm-none-eabi-g++.exe
OC = arm-none-eabi-objcopy.exe

CC_FLAGS = $(INC_DIRS) $(MCU_FLAGS) -Os -std=c++11 -xc++ -Wall -Wabi -w -mabi=aapcs -fPIC -fno-exceptions -fno-rtti -fno-use-cxa-atexit -fno-threadsafe-statics
LD_FLAGS = $(MCU_FLAGS) -nostartfiles -lc -lgcc -T $(LINKERSCRIPT_NAME) -Wl,-Map,$(OUTPUT_NAME).map -Wl,--oformat -Wl,elf32-littlearm
OC_FLAGS = -S -O binary

SRC_FILES = $(wildcard *.cpp)
OBJ_FILES = $(patsubst %.cpp, %.obj, $(SRC_FILES))
 
rebuild: clean build

clean:
	del $(OBJ_FILES) $(OUTPUT_NAME).bin $(OUTPUT_NAME).elf $(OUTPUT_NAME).map

build: $(OBJ_FILES)
	$(LD) $(LD_FLAGS) -o $(OUTPUT_NAME).elf $^
	$(OC) $(OC_FLAGS) $(OUTPUT_NAME).elf $(OUTPUT_NAME).bin

%.obj: %.cpp
	$(CC) -c $(CC_FLAGS) -o $@ $^