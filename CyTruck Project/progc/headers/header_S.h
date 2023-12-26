#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct AVL_S
{
    int state;
    unsigned int RouteID; 
    unsigned short NumberOfSteps;
    unsigned short MaxStepDistance;
    unsigned short MinStepDistance;
    unsigned int sum;
    struct AVL_S *left;
    struct AVL_S *right;
}AVL_S;
