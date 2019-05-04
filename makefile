DIR_INC = ./def
DIR_SRC = ./asm
DIR_BUILD = ./build
DIR_BIN = ./bin

STCFLASH = ./tool/stcflash.py

CC = sdas8051
PROJ_NAME = led
CFLAGS = -I${DIR_INC}

# 获取源文件列表
SRCS = $(wildcard ${DIR_SRC}/*.asm)  

# 获取目标文件列表,附加了目录
RELS = $(patsubst %.asm,${DIR_BUILD}/%.rel,$(notdir ${SRCS})) 

# 最终目标由.hex生成.bin文件
$(DIR_BIN)/$(PROJ_NAME).bin : $(DIR_BIN)/$(PROJ_NAME).hex
	objcopy -I ihex -O binary $< $@

# 生成.hex文件
$(DIR_BIN)/$(PROJ_NAME).hex : $(DIR_BIN)/$(PROJ_NAME).ihx
	packihx $< > $@

# 链接.rel文件
$(DIR_BIN)/$(PROJ_NAME).ihx : $(RELS) | $(DIR_BIN)
	sdld -i $@ -Y $(RELS) -e
	

# 编译asm文件
${DIR_BUILD}/%.rel : ${DIR_SRC}/%.asm | $(DIR_BUILD)
	sdas8051 -gloaxsff -o $@ $<

# 如果文件夹还没有创建，则建立文件夹
$(DIR_BUILD) :
	mkdir $(DIR_BUILD)

$(DIR_BIN) :
	mkdir $(DIR_BIN)

# ---------辅助构建---------------
.PHONY : flash clean debug

# 下载代码
flash:
	python ${STCFLASH} $(DIR_BIN)/$(PROJ_NAME).bin

# 清除文件
clean :
	rm -f $(DIR_BUILD)/*

debug:
	echo hello



