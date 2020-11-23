.POSIX:

TARGET=cpp
OBJS=main.o lexer.o parser.o

POSIX_FLAG=-D _POSIX_C_SOURCE=200112L
RELEASE_FLAG=-D NDEBUG=1

CFLAGS+=$(POSIX_FLAG) $(RELEASE_FLAG)
YFLAGS+=-d

all: $(TARGET)

run: $(TARGET)
	./$(TARGET)

clean:
	rm -f $(TARGET)
	rm -f $(OBJS)
	rm -f parser.c parser.h

$(TARGET): $(OBJS)
	$(CC) -o $(TARGET) $(OBJS)

main.o: main.c parser.h
	$(CC) $(CFLAGS) -c main.c

lexer.o: lexer.c lexer.h parser.h
	$(CC) $(CFLAGS) -c lexer.c

parser.o: parser.c parser.h
	$(CC) $(CFLAGS) -c parser.c

parser.c parser.h: parser.y
	$(YACC) $(YFLAGS) parser.y
	mv y.tab.h parser.h
	mv y.tab.c parser.c

