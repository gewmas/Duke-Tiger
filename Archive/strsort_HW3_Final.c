//
//  main.c
//  TestUse
//
//  Created by Yuhua Mai on 10/9/12.
//  Copyright (c) 2012 Yuhua Mai. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>


void strsort(const char ** strarray, int n)
{
    int i;
    int j;
    const char * temp;
    
    for(i=0;i<n-1;i++)
    {
        
        for(j=i+1;j<n;j++)
        {
            if(strcmp(*(strarray+i),*(strarray+j))>0)
            {
                temp = *(strarray+i);
                *(strarray+i) = *(strarray+j);
                *(strarray+j)= temp;
            }
        }
    }
}

void print_array(const char ** strarray, int n) {
    for (int i =0 ; i < n; i++) {
        printf("%d: %s\n", i, strarray[i]);
    }
}

int main(void) {
    const char * array1[8] = {"zucchini", "cake", "bread", "grapes", "french fries", "apples", "diced peaches", "eggplant"};
    strsort(array1,8);
    print_array(array1,8);
    
    return 0;
}

