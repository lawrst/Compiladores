valida: valida.y valida.l
	bison -d valida.y
	flex valida.l
	gcc valida.tab.c lex.yy.c -o valida

clean:
	rm -f valida valida.tab.c valida.tab.h lex.yy.c valida.exe