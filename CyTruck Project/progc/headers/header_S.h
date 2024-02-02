#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct AVL_S
{
    int state;
    int RouteID;
    float sum;
    float MaxStepDistance;
    float MinStepDistance;
    unsigned short NumberOfSteps;
    struct AVL_S *left;
    struct AVL_S *right;
};

typedef struct AVL_S *pAVL;

typedef struct TopRouteID
{
    int RouteID;
    float average;
    float MinStepDistance;
    float MaxStepDistance;
} TopRouteID;

int min(int a, int b);
int max(int a, int b);
int min3(int a, int b, int c);
int max3(int a, int b, int c);
pAVL CreateAVL(int RouteID, float distance);
pAVL LeftRotate(pAVL root);
pAVL RightRotate(pAVL root);
pAVL DoubleLeftRotate(pAVL root);
pAVL DoubleRightRotate(pAVL root);
pAVL BalanceAVL(pAVL root);
pAVL InsertInAVL(pAVL root, int RouteID, float distance, int *h);
pAVL CreateAVLfromCSV(FILE *file, pAVL root, int *h);
TopRouteID *GetRouteInfo(pAVL root, TopRouteID *array, int *index);
TopRouteID *CreateTop50RoutesArray(pAVL root);
TopRouteID *SortArray(TopRouteID *array);
void PrintDataInCSV(TopRouteID *array);
void freeAVL(pAVL root);
