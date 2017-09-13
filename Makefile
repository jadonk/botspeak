SRCS = botspeak-pru-lexer.c botspeak-pru-parser.c
CC = gcc

test: all
	cat sample.asm | ./botspeak-pru-parser

all: $(SRCS)
	$(CC) $(SRCS) -o botspeak-pru-parser

botspeak-pru-lexer.c: botspeak-pru-lexer.l
	flex botspeak-pru-lexer.l

botspeak-pru-parser.c: botspeak-pru-parser.y botspeak-pru-lexer.l
	bison botspeak-pru-parser.y --output botspeak-pru-parser.c --defines=botspeak-pru-parser.h

clean:
	rm -rf *.o botspeak-pru-lexer.c botspeak-pru-lexer.h botspeak-pru-parser.c botspeak-pru-parser.h botspeak-pru-parser

