#include <stdlib.h>
#include <stdio.h>
#include <string.h>
/*
 * Class Person
 */

struct Person_Class {
	void* super;
	void* (* toString) (void*,char*,int);
};

struct Person {
	struct Person_Class* class;
	char* name;
};

void Person_toString (void* thisVP, char* bufr, int bufr_size) {
  struct Person* person = thisVP;
  snprintf (bufr, bufr_size, "Name: %s", person->name);
}

struct Person_Class Person_Class_obj = {NULL, Person_toString};

struct Person* new_Person(char* name){
	struct Person* person = malloc (sizeof(struct Person));
	person->class = &Person_Class_obj;
	person->name = strdup(name);
	return person;
}

void delete_Person(void *this) {
	struct Person* tobedelted = this;
	free(tobedelted->name);
	free(tobedelted);
}

/*
 * Class Student extends Person
 */

struct Student_class {
	struct Person_Class* super;
	void*	(*toString) (void*,char*,int);
};

struct Student {
	struct Student_class* class;
	char* name;
	int sid;
};

void Student_toString(void* thisVP, char* bufr, int bufr_size) {
  struct Student* student = thisVP;

  char super_string[bufr_size];
  student->class->super->toString(student, super_string, bufr_size);

  snprintf(bufr, bufr_size, "%s, SID: %i", super_string, student->sid);
}

struct Student_class Student_class_obj = 
	{&Person_Class_obj, Student_toString};

struct Student* new_Student(char* name, int sid) {
	struct Student* student = malloc (sizeof (struct Student));
	student->class = &Student_class_obj;
	student->name = strdup(name);
	student->sid = sid;
	return student;
}

void delete_Student(void *this) {
	struct Student* tobedelted = this;
	//free(tobedelted->sid);
	free(tobedelted->name);
	free(tobedelted);
}


void print(void* p) {
  struct Person* person = p;
  char bufr[128];
  person->class->toString(person, bufr, sizeof bufr);
  printf("%s\n", bufr);
}

int main (int argc, char** argv) {
  struct Person *plp[2] = {new_Person("Alex"),
                              (struct Person *) new_Student("Alice", 300)};
  
  for (int i = 0; i < (sizeof plp)/(sizeof plp[0]); i++) {
    print(plp[i]);
  }

	 
  delete_Person(plp[0]);
  delete_Student(plp[1]);
}

