#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include "list.h"
#include "list.c"
#include <stdbool.h>
//#include "test.c"


int main (int argc, char *argv[])  {
	struct list* originalList = list_create();
	for(int i=1; i < argc ; i++) {
		list_append (originalList, (element_t) argv[i]);		
	}

	void printchar (element_t ev) {
  		printf(ev);
  		printf("\n");
	}

	void printint_t (element_t ev) {

	}


	//list_foreach (printchar , originalList);

	struct list* nums = list_create();
	struct list* alph = list_create();

	/*void findints(element_t ev) {
		long ret;
		char* ptr;
		ret = strtol((char) ev, ptr,10);
		list_append(nums,(element_t) ret);
		list_append(alph,(element_t) ptr);
	}

*/	
	list_foreach (printchar , originalList);
	
	//list_foreach (printchar , alph);
	//list_foreach (printchar , nums);


// from TAs in LAB
	void findInt(element_t* rpv, element_t av) {
		intptr_t* rp = (intptr_t*) rpv;
		char* a = (char*) av;
		char* ep;
		*rp = strtol(a, &ep, 0);
		if (*ep) {
			*rp = -1;
		} 
	}
	
	
	struct list* numList = list_create();
	list_map1(findInt,numList,originalList);


	//printf(numList->data[1]);
	//list_foreach (printchar, numList);


	void findString(element_t* ret, element_t l0, element_t l1) {
		if(l0 != -1) {
			ret = l1;	
		} else {
			ret = NULL;
		}
	}

	struct list* filtNumList = list_create();
	list_map2(findString,filtNumList,numList,originalList);

	int num_filt(element_t ele) {
		if (ele > 0){
			return 1;
		} else {
			return 0;
		}
	}

	struct list* filt_StrList = list_create();
	list_filter(num_filt,filt_StrList,numList);

/*
	void findString(element_t* rpv, element_t av) {
		char* rp = 
		if (av = -1) {
		rp = 
*/

// From TA Labs
	void trunc (element_t* rpv, element_t sv, element_t iv) {
		char** rp = (char**) rpv;
		char* s = sv;
		intptr_t i = (intptr_t) iv;
		*rp =strdup(s);
		if (strlen(*rp) > i) {
			(*rp)[i] = 0;
		}
	}

	struct list* truncList = list_create();
	list_map2(trunc, truncList, filt_StrList,filtNumList);

	list_foreach (printchar, truncList);


	void findMax (element_t* ret , element_t acc, element_t ele) {
		acc=0;
		if(ele>acc){
			ret = ele;
		}
	}

	element_t MAX;
	list_foldl(findMax, MAX, filtNumList);
	printf(MAX);

	return 0;


}