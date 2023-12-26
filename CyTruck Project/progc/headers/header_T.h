#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

struct AVL_T
{
    int state;
    char City[64]; // City name <= 63 caracters
    unsigned short TotalRouteNumber;
    unsigned short Start;
    struct AVL_T *left;
    struct AVL_T *right;
};

typedef struct AVL_T *pAVL;

typedef struct TopCities
{
    char City[64];
    unsigned short TotalRouteNumber;
    unsigned short Start;
} TopCities;

int min(int a, int b);
int max(int a, int b);
int min3(int a, int b, int c);
int max3(int a, int b, int c);
int DoesLeftExist(pAVL root);
int DoesRightExist(pAVL root);
pAVL CreateAVL(char *town, int start_or_end);
pAVL LeftRotate(pAVL root);
pAVL RightRotate(pAVL root);
pAVL DoubleLeftRotate(pAVL root);
pAVL DoubleRightRotate(pAVL root);
pAVL BalanceAVL(pAVL root);
pAVL InsertInAVL(pAVL root, char *town, int *h, int start_or_end);
pAVL CreateAVLfromCSV(FILE *file, pAVL root, int *h);
TopCities *GetCityInfo(pAVL root, TopCities *array, int *index);
TopCities *CreateTop10CitiesArray(pAVL root);
void PrintDataInCSV(TopCities *array);
void printCityInfo(pAVL root);
