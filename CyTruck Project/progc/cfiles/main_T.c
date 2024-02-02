#include "../headers/header_T.h"

int min(int a, int b) // returns min of the two numbers in arg
{
    return (a < b) ? a : b;
}

int max(int a, int b) // returns max of the two numbers in arg
{
    return (a > b) ? a : b;
}

int min3(int a, int b, int c) // returns min of 3 args
{
    int temp = (a < b) ? a : b;
    return (temp < c) ? temp : c;
}

int max3(int a, int b, int c) // returns max of 3 args
{
    int temp = (a > b) ? a : b;
    return (temp > c) ? temp : c;
}

pAVL CreateAVL(char *town, int start_or_end) // creates avl node with given town name in arg
{
    pAVL node = malloc(sizeof(struct AVL_T));
    if (node == NULL)
    {
        printf("Error while creating AVL node.\n");
        exit(1);
    }
	
	// init values of node
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

pAVL LeftRotate(pAVL root) // function to manage AVL
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

pAVL RightRotate(pAVL root) // function to manage AVL
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

pAVL DoubleLeftRotate(pAVL root) // function to manage AVL
{
    root->right = RightRotate(root->right);
    return LeftRotate(root);
}

pAVL DoubleRightRotate(pAVL root) // function to manage AVL
{ 
    root->left = LeftRotate(root->left);
    return RightRotate(root);
}

pAVL BalanceAVL(pAVL root) // function to manage AVL
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

pAVL InsertInAVL(pAVL root, char *town, int *h, int start_or_end) // Insert in AVL a given town with info if it's start or end.
{
    if (root == NULL) // Towns isnt in AVL
    {
        *h = 1;
        return CreateAVL(town, start_or_end);
    }
    else if (strcmp(town, root->City) < 0)
    {
        root->left = InsertInAVL(root->left, town, h, start_or_end);
        *h = -*h;
    }
    else if (strcmp(town, root->City) > 0)
    {
        root->right = InsertInAVL(root->right, town, h, start_or_end);
    }
    else // Town already exists in AVL
    {
        *h = 0;
        if(start_or_end == 1)
        {
        	root->Start++;
        	root->TotalRouteNumber++;
        }
        else if (start_or_end == 2)
        {
        	root->TotalRouteNumber++;
        }
        
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

pAVL CreateAVLfromCSV(FILE *file, pAVL root, int *h) // Gets data in CSV and create the AVL with
{
	if (root == NULL)
	{
		printf("root NULL in createavlfromcsv.\n");
		exit(1);
	}

    char town1[64], town2[64];

    while (fscanf(file, "%*[^;];%*[^;];%63[^;];%63[^;];%*[^;];%*[^\n]", town1, town2) == 2)
    {
        root = InsertInAVL(root, town1, h, 1);
        root = InsertInAVL(root, town2, h, 2);
    }

    return root;
}

TopCities *GetCityInfo(pAVL root, TopCities *array, int *index) // Fills the array with top cities
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
            int minIndex = 0;                               // index of lowest (totalroutenumber)
            int minTotalRoutes = array[0].TotalRouteNumber; // the lowest is for now the first totalroutenumber of the array

            // Find the lowest by going through array
            for (int i = 1; i < 10; i++)
            {
                int currentTotalRoutes = array[i].TotalRouteNumber;
                if (currentTotalRoutes < minTotalRoutes)
                {
                    minTotalRoutes = currentTotalRoutes;
                    minIndex = i; // Saves index of lower totalroutes
                }
            }

            // Compare the lowest totalroutes of array and the totalroutes of current root
            if (root->TotalRouteNumber > minTotalRoutes)
            {
                // Replace values by new ones
                strcpy(array[minIndex].City, root->City);
                array[minIndex].TotalRouteNumber = root->TotalRouteNumber;
                array[minIndex].Start = root->Start;
            }
        }
    }
    return array;
}

TopCities *CreateTop10CitiesArray(pAVL root) // Creates the array which will be filled
{
	if (root == NULL)
	{
		printf("root NULL in createtop10citiesarray.\n");
		exit(1);
	}    

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

TopCities *SortArray(TopCities *array) // Sorts the top cities array for later gnuplot process
{
    if (array == NULL)
    {
        printf("Array error.\n");
        exit(1);
    }
	
    // Bubble sort
    int i, j;
    TopCities temp;

    for (i = 0; i < 9; i++)
    {
        for (j = 0; j < 9 - i; j++)
        {
            if (strcmp(array[j].City, array[j + 1].City) > 0)
            {
                temp = array[j];
                array[j] = array[j + 1];
                array[j + 1] = temp;
            }
        }
    }

    return array;
}

void PrintDataInCSV(TopCities *array) // Printfs the gathered data in a new file
{
	if (array == NULL)
	{
		printf("root NULL in printdataincsv.\n");
		exit(1);
	}

    array = SortArray(array);
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

int main(int argc, char *argv[])
{
    char town1[64], town2[64];
    char header[256];
    int h = 0;

    FILE *file = fopen(argv[1], "r");
    if (file == NULL)
    {
        printf("Error while trying to open csv file.\n");
        exit(1);
    }

    // Creates the AVL root with first line of csv
    fgets(header, sizeof(header), file); // Skips header line
    if (fscanf(file, "%*[^;];%*[^;];%63[^;];%63[^;];%*[^;];%*[^\n]", town1, town2) != 2)
    {
        printf("Error while gettings varaibles of csv.\n");
        exit(1);
    }
    pAVL root = CreateAVL(town1, 1);
    root = InsertInAVL(root, town2, &h, 2);

    // Create AVL from CSV file
    root = CreateAVLfromCSV(file, root, &h);
    fclose(file);

    // ------------------------------------------------

    TopCities *topCitiesArray = CreateTop10CitiesArray(root);
    PrintDataInCSV(topCitiesArray);

    // No need to free AVL and array because program terminates

    return 0;
}
