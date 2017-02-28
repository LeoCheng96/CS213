#include <stdlib.h>
#include <stdio.h>

//
// A binary tree node with value and left and right children
struct Node {
  // TODO
	int val;
	struct Node* left;
	struct Node* right;
};

//
// Insert node n into tree rooted at toNode
//
void insertNode (struct Node* toNode, struct Node* n) {	
  // TODO

	if(n->val <= toNode->val){
		if(toNode->left==NULL)
			toNode->left = n;
		else 
			insertNode(toNode->left, n);
	} else {
		if (toNode->right==NULL)
			toNode->right = n;
		else 
			insertNode(toNode->right, n);
	}
}

//
// Insert new node with specified value into tree rooted at toNode
//
void insert (struct Node* toNode, int value) {
  // TODO
	
	struct Node* node = (struct Node*)malloc(sizeof (struct Node));
	node->val = value;
	node->left = NULL;
	node->right = NULL;
	insertNode(toNode,node);
}


//
// Print values of tree rooted at node in ascending order
//
void printInOrder (struct Node* node) {
  // TODO
	if(node->left != NULL)
		printInOrder(node->left);
	printf("%d\n", node->val);
	if (node->right != NULL)
		printInOrder(node->right);
}


struct Node* newNode(int value) {
	struct Node* node = (struct Node*)malloc(sizeof (struct Node));
	node->val = value;
	node->left = NULL;
	node->right = NULL;
};
//
// Create root node, insert some values, and print tree in order
//
int main (int argc, char* argv[]) {
  // TODO
	struct Node* node = newNode(100);
	insert(node,10);
	insert(node,120);
	insert(node,130);
	insert(node,90);
	insert(node,5);
	insert(node,95);
	insert(node,121);
	insert(node,131);
	insert(node,1);
	printInOrder(node);
}
