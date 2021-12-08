.POSIX:

RELEASE_CFLAG=-D NDEBUG=1

CFLAGS=-O -D _POSIX_C_SOURCE=200112L $(RELEASE_CFLAG)

TARGET=gancc
YFLAGS=-d

LEX_OUT=scanner.c

YACC_OUT=parser.c
YACC_HEADER=parser.h

SRCS=main.c \
	 $(LEX_OUT) \
	 $(YACC_OUT)

OBJS=$(SRCS:.c=.o)

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) -o $(TARGET) $(OBJS)

main.o: main.c $(YACC_HEADER)
	$(CC) $(CFLAGS) -c -o main.o main.c

$(YACC_OUT) $(YACC_HEADER): parser.y
	$(YACC) $(YFLAGS) parser.y
	mv y.tab.c $(YACC_OUT)
	mv y.tab.h $(YACC_HEADER)

$(LEX_OUT:.c=.o): $(LEX_OUT) $(YACC_HEADER)
	$(CC) $(CFLAGS) -c -o $(LEX_OUT:.c=.o) $(LEX_OUT)

run: $(TARGET)
	./$(TARGET)

clean:
	rm -f $(TARGET)
	rm -f $(OBJS)
	rm -f $(LEX_OUT) $(YACC_OUT) $(YACC_HEADER)

