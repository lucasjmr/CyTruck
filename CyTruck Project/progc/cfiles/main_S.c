#include "../headers/header_S.h"

int min(int a, int b) // returns min value of 2 args
{
    return (a < b) ? a : b;
}

int max(int a, int b) // returns max value of 2 args
{
    return (a > b) ? a : b;
}

int min3(int a, int b, int c) // returns min values of 3 args
{
    int temp = (a < b) ? a : b;
    return (temp < c) ? temp : c;
}

int max3(int a, int b, int c) // returns max values of 3 args
{
    int temp = (a > b) ? a : b;
    return (temp > c) ? temp : c;
}

pAVL CreateAVL(int RouteID, float distance) // create avl node with routeid and distance
{
    pAVL node = malloc(sizeof(struct AVL_S));
    if (node == NULL)
    {
        printf("Error while creating AVL node.\n");
        exit(1);
    }
	
	// init node values
    node->state = 0;
    node->RouteID = RouteID;
    node->sum = distance;
    node->MaxStepDistance = distance;
    node->MinStepDistance = distance;
    node->NumberOfSteps = 1;
    node->left = NULL;
    node->right = NULL;
    return node;
}

pAVL LeftRotate(pAVL root) // Function to manage AVL
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

pAVL RightRotate(pAVL root) // Function to manage AVL
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

pAVL DoubleLeftRotate(pAVL root) // Function to manage AVL
{
    root->right = RightRotate(root->right);
    return LeftRotate(root);
}

pAVL DoubleRightRotate(pAVL root) // Function to manage AVL
{
    root->left = LeftRotate(root->left);
    return RightRotate(root);
}

pAVL BalanceAVL(pAVL root) // Function to manage AVL
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

pAVL InsertInAVL(pAVL root, int RouteID, float distance, int *h) // Inserts in AVL 
{
    if (root == NULL)
    {
        *h = 1;
        return CreateAVL(RouteID, distance);
    }
    else if (RouteID < root->RouteID)
    {
        root->left = InsertInAVL(root->left, RouteID, distance, h);
        *h = -*h;
    }
    else if (RouteID > root->RouteID)
    {
        root->right = InsertInAVL(root->right, RouteID, distance, h);
    }
    else // RouteID already exists
    {
        *h = 0;
        // UPDATE INFOS
        root->sum += distance;
        root->NumberOfSteps++;
        if (root->MaxStepDistance < distance)
        {
            root->MaxStepDistance = distance;
        }
        else if (root->MinStepDistance > distance)
        {
            root->MinStepDistance = distance;
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

pAVL CreateAVLfromCSV(FILE *file, pAVL root, int *h) // Creates avl from values gathered in csv file
{
	if (root == NULL)
	{
		printf("root NULL in createavlfromcsv.\n");
		exit(1);
	}

    int RouteID;
    float distance;

    while (fscanf(file, "%d;%*d;%*[^;];%*[^;];%f;%*[^\n]", &RouteID, &distance) == 2)
    {
        root = InsertInAVL(root, RouteID, distance, h);
    }

    return root;
}

TopRouteID *GetRouteInfo(pAVL root, TopRouteID *array, int *index) // FILLS the array of top max-min distances
{
    if (root != NULL)
    {
        array = GetRouteInfo(root->left, array, index);
        array = GetRouteInfo(root->right, array, index);
        
        if (*index < 50) // array not full
        {
            array[*index].RouteID = root->RouteID;
            array[*index].average = ((root->sum) / (root->NumberOfSteps));
            array[*index].MinStepDistance = root->MinStepDistance;
            array[*index].MaxStepDistance = root->MaxStepDistance;
            (*index)++;
        }
        else // array is full -> compare lowest value of array and replace if root->max-min is greater
        {
            int minIndex = 0;                                                  // index of lowest (max-min)
            int minDiff = array[0].MaxStepDistance - array[0].MinStepDistance; // the lowest is for now the first max-min of the array

            // Find the lowest by going through array
            for (int i = 1; i < 50; i++)
            {
                int currentDiff = array[i].MaxStepDistance - array[i].MinStepDistance;
                if (currentDiff < minDiff)
                {
                    minDiff = currentDiff;
                    minIndex = i; // Saves index of lower max-min
                }
            }

            // Compare the lowest max-min of array and the max-min of current root
            int rootDiff = root->MaxStepDistance - root->MinStepDistance;
            if (rootDiff > minDiff)
            {
                // Replace values by new ones
                array[minIndex].RouteID = root->RouteID;
                array[minIndex].average = ((root->sum) / (root->NumberOfSteps));
                array[minIndex].MinStepDistance = root->MinStepDistance;
                array[minIndex].MaxStepDistance = root->MaxStepDistance;
            }
        }
    }
    return array;
}

TopRouteID *CreateTop50RoutesArray(pAVL root) // creates the array of top distances max-min
{
	if (root == NULL)
	{
		printf("root NULL in createtop50routesarray.\n");
		exit(1);
	}

    // Create Array
    TopRouteID *array = malloc(50 * sizeof(TopRouteID));
    if (array == NULL)
    {
        printf("Error while trying to create topRoutesId.\n");
        exit(1);
    }

    int index = 0;
    return GetRouteInfo(root, array, &index);
}

TopRouteID *SortArray(TopRouteID *array) // Sort the array for gnuplot process later
{
    if (array == NULL)
    {
        printf("Array error.\n");
        exit(1);
    }
    
    // Bubble sort
    int i, j;
    TopRouteID temp;

    for (i = 0; i < 49; i++)
    {
        for (j = 0; j < 49 - i; j++)
        {
            float diff1 = array[j].MaxStepDistance - array[j].MinStepDistance;
            float diff2 = array[j + 1].MaxStepDistance - array[j + 1].MinStepDistance;

            if (diff1 < diff2)
            {
                temp = array[j];
                array[j] = array[j + 1];
                array[j + 1] = temp;
            }
        }
    }

    return array;
}

void PrintDataInCSV(TopRouteID *array) // Prints the sorted data in a new csv
{
	if (array == NULL)
	{
		printf("array NULL in printdataincsv.\n");
		exit(1);
	}

    FILE *file = fopen("temp/dataS.csv", "w");
    if (file == NULL)
    {
        printf("Error while trying to create dataS.csv\n");
        exit(1);
    }
    array = SortArray(array);
    for (int i = 0; i < 50; i++)
    {
        fprintf(file, "%d;%d;%g;%g;%g;%g\n", i+1, array[i].RouteID, array[i].MinStepDistance, array[i].average, array[i].MaxStepDistance, array[i].MaxStepDistance - array[i].MinStepDistance);
        // %g prints best format for the number (example : removes 0 at the end of floats).
    }
    fclose(file);
}

void freeAVL(pAVL root) // free AVL
{
	if (root != NULL) 
	{
		freeAVL(root->left);
		freeAVL(root->right);
		free(root);
	}
}

int main(int argc, char *argv[])
{
    int RouteID;
    float distance;
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

    if (fscanf(file, "%d;%*d;%*[^;];%*[^;];%f;%*[^\n]", &RouteID, &distance) != 2)
    {
        printf("Error while gettings variables of csv.\n");
        exit(1);
    }
    pAVL root = CreateAVL(RouteID, distance);

    // Create AVL from CSV file
    root = CreateAVLfromCSV(file, root, &h);
    fclose(file);

    //  ------------------------------------------------

    TopRouteID *topRoutesIdArray = CreateTop50RoutesArray(root);
    PrintDataInCSV(topRoutesIdArray);

    free(topRoutesIdArray);
	freeAVL(root);
    return 0;
}
