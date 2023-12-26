#include "../headers/header_T.h"

int min(int a, int b)
{
    return (a < b) ? a : b;
}

int max(int a, int b)
{
    return (a > b) ? a : b;
}

int min3(int a, int b, int c)
{
    int temp = (a < b) ? a : b;
    return (temp < c) ? temp : c;
}

int max3(int a, int b, int c)
{
    int temp = (a > b) ? a : b;
    return (temp > c) ? temp : c;
}

int DoesLeftExist(pAVL root)
{
    if (root == NULL)
    {
        return 0;
    }
    else if (root->left != NULL)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

int DoesRightExist(pAVL root)
{
    if (root == NULL)
    {
        return 0;
    }
    else if (root->right != NULL)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

pAVL CreateAVL(char *town, int start_or_end)
{
    pAVL node = malloc(sizeof(struct AVL_T));
    if (node == NULL)
    {
        printf("Error while creating AVL node.\n");
        exit(1);
    }

    strcpy(node->City, town);
    node->Start = 0;
    if (start_or_end == 1)
    {
        node->Start++;
    }
    node->TotalRouteNumber = 1;
    node->state = 0;
    node->left = NULL;
    node->right = NULL;
    return node;
}

pAVL LeftRotate(pAVL root)
{
    pAVL pivot;
    int root_state, pivot_state;

    pivot = root->right;
    root->right = pivot->left;
    pivot->left = root;

    root_state = root->state;
    pivot_state = pivot->state;

    root->state = root_state - max(pivot_state, 0) - 1;
    pivot->state = min3(root_state - 2, root_state + pivot_state - 2, pivot_state - 1);
    root = pivot;

    return root;
}

pAVL RightRotate(pAVL root)
{
    pAVL pivot;
    int root_state, pivot_state;

    pivot = root->left;
    root->left = pivot->right;
    pivot->right = root;

    root_state = root->state;
    pivot_state = root->state;

    root->state = root_state - min(pivot_state, 0) + 1;
    pivot->state = max3(root_state + 2, root_state + pivot_state + 2, pivot_state + 1);
    root = pivot;

    return root;
}

pAVL DoubleLeftRotate(pAVL root)
{
    root->right = RightRotate(root->right);
    return LeftRotate(root);
}

pAVL DoubleRightRotate(pAVL root)
{
    root->left = LeftRotate(root->left);
    return RightRotate(root);
}

pAVL BalanceAVL(pAVL root)
{
    pAVL temp;

    if (root->state >= 2)
    {
        temp = root->right;
        if (temp->state >= 0)
        {
            return LeftRotate(root);
        }
        else
        {
            return DoubleLeftRotate(root);
        }
    }
    else if (root->state <= -2)
    {
        temp = root->left;
        if (temp->state <= 0)
        {
            return RightRotate(root);
        }
        else
        {
            return DoubleRightRotate(root);
        }
    }
    return root;
}

pAVL InsertInAVL(pAVL root, char *town, int *h, int start_or_end)
{
    if (root == NULL)
    {
        *h = 1;
        return CreateAVL(town, start_or_end);
    }
    else if (strcmp(town, root->City) < 0) // var < root->var
    {
        root->left = InsertInAVL(root->left, town, h, start_or_end);
        *h = -*h;
    }
    else if (strcmp(town, root->City) > 0)
    {
        root->right = InsertInAVL(root->right, town, h, start_or_end);
    }
    else // Town already exists
    {
        *h = 0;
        // UPDATE INFOS
        root->TotalRouteNumber++;
        if (start_or_end == 1)
        {
            root->Start++;
        }
        return root;
    }

    if (*h != 0)
    {
        root->state += *h;
        root = BalanceAVL(root);
        if (root->state == 0)
        {
            *h = 0;
        }
        else
        {
            *h = 1;
        }
    }
    return root;
}

pAVL CreateAVLfromCSV(FILE *file, pAVL root, int *h)
{

    char town1[64], town2[64];

    while (fscanf(file, "%*[^;];%*[^;];%63[^;];%63[^;];%*[^;];%*[^\n]", town1, town2) == 2)
    {
        root = InsertInAVL(root, town1, h, 1);
        root = InsertInAVL(root, town2, h, 2);
    }

    return root;
}

TopCities *GetCityInfo(pAVL root, TopCities *array, int *index)
{
    if (root != NULL)
    {
        array = GetCityInfo(root->left, array, index);
        array = GetCityInfo(root->right, array, index);
        if (*index < 10) // array not full
        {
            strcpy(array[*index].City, root->City);
            array[*index].TotalRouteNumber = root->TotalRouteNumber;
            array[*index].Start = root->Start;
            (*index)++;
        }
        else
        {
            for (int i = 0; i < 10; i++)
            {
                if (array[i].TotalRouteNumber < root->TotalRouteNumber)
                {
                    strcpy(array[i].City, root->City);
                    array[i].TotalRouteNumber = root->TotalRouteNumber;
                    array[i].Start = root->Start;
                    break;
                }
            }
        }
    }
    return array;
}

TopCities *CreateTop10CitiesArray(pAVL root)
{
    // Create Array
    TopCities *array = malloc(10 * sizeof(TopCities));
    if (array == NULL)
    {
        printf("Error while trying to create TopCitiesArray.\n");
        exit(1);
    }

    int index = 0;
    return GetCityInfo(root, array, &index);
}

void printStructArray(TopCities *array)
{
    for (int i = 0; i < 10; i++)
    {
        printf("Name: %s, Total: %d, Start : %d\n", array[i].City, array[i].TotalRouteNumber, array[i].Start);
    }
}

void PrintDataInCSV(TopCities *array)
{
    FILE *file = fopen("temp/dataT.csv", "w");
    if (file == NULL)
    {
        printf("Error while trying to create dataT.csv\n");
        exit(1);
    }
    for (int i = 0; i < 10; i++)
    {
        fprintf(file, "%s;%d;%d\n", array[i].City, array[i].TotalRouteNumber, array[i].Start);
    }
    fclose(file);
}

int main()
{
    char town1[64], town2[64];
    char header[256];
    int h = 0;

    FILE *file = fopen("data/data.csv", "r");
    if (file == NULL)
    {
        printf("Error while trying to open data/data.csv\n");
        exit(1);
    }

    // Creates the AVL root with first line of csv
    fgets(header, sizeof(header), file); // Skips header line
    if (fscanf(file, "%*[^;];%*[^;];%63[^;];%63[^;];%*[^;];%*[^\n]", town1, town2) != 2)
    {
        printf("Error while gettings varaibles of csv.\n");
        exit(1);
    }

    // ------------------------------------------------

    pAVL root = CreateAVL(town1, 1);
    root = InsertInAVL(root, town2, &h, 2);
    // Create AVL from CSV file
    root = CreateAVLfromCSV(file, root, &h);
    fclose(file);

    // ------------------------------------------------

    TopCities *topCitiesArray = CreateTop10CitiesArray(root);
    PrintDataInCSV(topCitiesArray);

    free(topCitiesArray);
    free(root);
    return 0;
}
