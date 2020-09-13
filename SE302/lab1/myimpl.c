#include "prog1.h"
#include "slp.h"
#include "util.h"
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

int maxargs(A_stm stm);

int maxargsExp(A_exp exp, bool flag)
{
	if (flag)
	{
		if (exp->kind == A_idExp || exp->kind == A_numExp)
			return 1;
		else if (exp->kind == A_opExp)
		{
			int arg1 = maxargsExp(exp->u.op.right, flag);
			int arg2 = maxargsExp(exp->u.op.left, flag);
			if (arg1 > arg2)
				return arg1;
			else
				return arg2;
		}
		else
			return maxargs(exp->u.eseq.stm) + maxargsExp(exp->u.eseq.exp, flag);
	}
	if (exp->kind == A_idExp || exp->kind == A_numExp)
		return 0;
	else if (exp->kind == A_opExp)
		return maxargsExp(exp->u.op.right, flag) + maxargsExp(exp->u.op.left, flag);
	else
		return maxargs(exp->u.eseq.stm) + maxargsExp(exp->u.eseq.exp, flag);
}

int maxargsExplist(A_expList expList, bool flag)
{
	if (expList->kind == A_lastExpList)
		return maxargsExp(expList->u.last, flag);
	else
		return maxargsExp(expList->u.pair.head, flag) + maxargsExplist(expList->u.pair.tail, flag);
}

int maxargs(A_stm stm)
{
	//TODO: put your code here.
	if (stm->kind == A_compoundStm)
	{
		int arg1 = maxargs(stm->u.compound.stm1);
		int arg2 = maxargs(stm->u.compound.stm2);
		if (arg1 > arg2)
			return arg1;
		else
			return arg2;
	}
	else if (stm->kind == A_assignStm)
	{
		return maxargsExp(stm->u.assign.exp, FALSE);
	}
	else
	{
		return maxargsExplist(stm->u.print.exps, TRUE);
	}
}

typedef struct table *Table_;
struct table
{
	string id;
	int value;
	Table_ tail;
};
Table_ Table(string id, int value, struct table *tail)
{
	Table_ t = malloc(sizeof(*t));
	t->id = id;
	t->value = value;
	t->tail = tail;
	return t;
}

typedef struct intAndTable *IntAndTable_;
struct intAndTable
{
	int i;
	Table_ t;
};
IntAndTable_ IntAndTable(int i, Table_ t)
{
	IntAndTable_ it = malloc(sizeof(*it));
	it->i = i;
	it->t = t;
	return it;
}

IntAndTable_ interpExpList(A_expList expList, Table_ t);
IntAndTable_ interpExp(A_exp exp, Table_ t);
Table_ interpStm(A_stm stm, Table_ t)
{
	if (stm->kind == A_compoundStm)
	{
		t = interpStm(stm->u.compound.stm1, t);
		return interpStm(stm->u.compound.stm2, t);
	}
	else if (stm->kind == A_assignStm)
	{
		IntAndTable_ it = interpExp(stm->u.assign.exp, t);
		return Table(stm->u.assign.id, it->i, it->t);
	}
	else
	{
		IntAndTable_ it = interpExpList(stm->u.print.exps, t);
		return it->t;
	}
}

IntAndTable_ interpExpList(A_expList expList, Table_ t)
{
	if (expList->kind == A_pairExpList)
	{
		IntAndTable_ it = interpExp(expList->u.pair.head, t);
		printf("%d ", it->i);
		return interpExpList(expList->u.pair.tail, it->t);
	}
	else
	{
		IntAndTable_ it = interpExp(expList->u.last, t);
		printf("%d\n", it->i);
		return it;
	}
}

int lookupId(Table_ t, string key);

IntAndTable_ interpExp(A_exp exp, Table_ t)
{
	if (exp->kind == A_idExp)
	{
		int v = lookupId(t, exp->u.id);
		return IntAndTable(v, t);
	}
	else if (exp->kind == A_numExp)
	{
		return IntAndTable(exp->u.num, t);
	}
	else if (exp->kind == A_opExp)
	{
		IntAndTable_ it = interpExp(exp->u.op.left, t);
		int v1 = it->i;
		it = interpExp(exp->u.op.right, it->t);
		int v2 = it->i;
		switch (exp->u.op.oper)
		{
		case A_plus:
			return IntAndTable(v1 + v2, it->t);
		case A_minus:
			return IntAndTable(v1 - v2, it->t);
		case A_times:
			return IntAndTable(v1 * v2, it->t);
		default:
			return IntAndTable(v1 / v2, it->t);
		}
	}
	else
	{
		t = interpStm(exp->u.eseq.stm, t);
		return interpExp(exp->u.eseq.exp, t);
	}
}

int lookupId(Table_ t, string key)
{
	while (t && strcmp(t->id, key))
	{
		t = t->tail;
	}
	if (t)
		return t->value;
	return 0;
}

void interp(A_stm stm)
{
	//TODO: put your code here.
	interpStm(stm, NULL);
}