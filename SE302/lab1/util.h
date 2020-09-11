#ifndef UTIL_H
#define UTIL_H
#include <assert.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

typedef char *string;
typedef char bool;

#define TRUE 1
#define FALSE 0

void *checked_malloc(int);
string String(char *);

typedef struct U_boolList_ *U_boolList;
struct U_boolList_ 
{
	bool head; 
	U_boolList tail;
};

U_boolList U_BoolList(bool head, U_boolList tail);

void *checked_malloc(int len)
{
	void *p = malloc(len);
	if (!p) {
		printf("\nRan out of memory!\n");
		exit(1);
	}
	return p;
}

string String(char *s)
{
	string p = checked_malloc(strlen(s)+1);
	strcpy(p,s);
	return p;
}

U_boolList U_BoolList(bool head, U_boolList tail)
{ 
	U_boolList list = checked_malloc(sizeof(*list));
	list->head = head;
	list->tail = tail;
	return list;
}
#endif
