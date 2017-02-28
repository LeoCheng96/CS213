#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <fcntl.h>
#include <time.h>
#include <unistd.h>
#include "uthread.h"
#include "uthread_mutex_cond.h"

#ifdef VERBOSE
#define VERBOSE_PRINT(S, ...) printf (S, ##__VA_ARGS__);
#else
#define VERBOSE_PRINT(S, ...) ;
#endif

#define MAX_OCCUPANCY      3
#define NUM_ITERATIONS     100
#define NUM_PEOPLE         20
#define FAIR_WAITING_COUNT 4
#define SWITCHING 1

/**
 * You might find these declarations useful.
 */
enum Sex {MALE = 0, FEMALE = 1};
const static enum Sex otherSex [] = {FEMALE, MALE};

static uthread_t threads[NUM_PEOPLE];
static int num_of_gender[2];

struct Washroom {
  // TODO
  int gender;
  uthread_mutex_t mutex;
  //uthread_cond_t full;
  uthread_cond_t try_enter_male;
  uthread_cond_t try_enter_female;
  int using[2];
  int queue[2];
  int state;
};

struct Washroom* createWashroom() {
  struct Washroom* washroom = malloc (sizeof (struct Washroom));
  // TODO
  washroom->gender = -1;
  washroom->mutex = uthread_mutex_create();
  washroom->try_enter_female = uthread_cond_create (washroom->mutex);
  washroom->try_enter_male = uthread_cond_create (washroom->mutex);
  washroom->using = {0, 0};
  washroom->queue = {0, 0};
  washroom->state = !SWITCHING;
  return washroom;
}

#define WAITING_HISTOGRAM_SIZE (NUM_ITERATIONS * NUM_PEOPLE)
int             entryTicker;  // incremented with each entry
int             waitingHistogram         [WAITING_HISTOGRAM_SIZE];
int             waitingHistogramOverflow;
uthread_mutex_t waitingHistogrammutex;
int             occupancyHistogram       [2] [MAX_OCCUPANCY + 1];

void enterWashroom (struct Washroom* washroom, enum Sex Sex) {
  // TODO
  uthread_mutex_lock(washroom->mutex);
  entryTicker++;
  int start = entryTicker;

  if (washroom->gender = -1) {
    washroom->gender = Sex;
  }

  while(washroom.using[Sex] >= 3 || washroom->gender != Sex || washroom->state == SWITCHING) {
    washroom.queue[Sex]--;
    if (Sex == 1) {
      uthread_cond_wait(try_enter_female);
    } else {
      uthread_cond_wait(try_enter_male);
    }
    washroom.queue[Sex]--;
    if (washroom.using[Sex] + washroom.using[!Sex] == 0) {
        washroom.gender = Sex;
    }
  }

  washroom.using[Sex]++;
  occupancyHistogram[Sex][washroom.using[Sex]-1]++;

  if (entryTicker - start < WAITING_HISTOGRAM_SIZE) {
    waitingHistogram[entryTicker-start]++;
  }
  else {
    waitingHistogramOverflow++;
  }
  uthread_mutex_unlock(washroom->mutex);
}

void leaveWashroom (struct Washroom* washroom) {
  uthread_mutex_lock(washroom->mutex);
  washroom.using[washroom.gender]--;
  if (washroom.state == SWITCHING) {
    if (washroom.using[washroom.gender] == 0) {
      washroom.gender = !washroom.gender;
      washroom.state = !SWITCHING;
      if (washroom.gender == 0) {
        uthread_cond_signal(try_enter_male);
      } else {
        uthread_cond_signal(try_enter_female);
      }
    }
  }
  else {
    if (washroom.using[washroom.gender] == 0) {
      if (washroom.gender == 0) {
        uthread_cond_signal(try_enter_female);
      } else {
        uthread_cond_signal(try_enter_male);
      }
    } 
    else if ((washroom.queue[!washroom.gender] > 0) && rand() % (NUM_PEOPLE - washroom.queue[!washroom.gender]) == 0) {
      washroom.state = SWITCHING;
    }
    if (washroom.gender == 0) {
        uthread_cond_signal(try_enter_male);
    } else {
        uthread_cond_signal(try_enter_female);
    }
    
  }
  uthread_mutex_unlock(washroom->mutex);
}

void recordWaitingTime (int waitingTime) {
  uthread_mutex_lock (waitingHistogrammutex);
  if (waitingTime < WAITING_HISTOGRAM_SIZE)
    waitingHistogram [waitingTime] ++;
  else
    waitingHistogramOverflow ++;
  uthread_mutex_unlock (waitingHistogrammutex);
}

//
// TODO
// You will probably need to create some additional produres etc.
//
void* person(void* gender_vp) {
  const int gender = (intptr_t) gender_vp;
  for (int i=0; i < NUM_ITERATIONS; i++) {
    enterWashroom(gender);
    for (int j=0; j < NUM_PEOPLE; j++) {
      uthread_yield();
    }
    leaveWashroom();
    for (int j=0; j < NUM_PEOPLE; j++) {
      uthread_yield();
    }
  }
  return NULL;  
}

int main (int argc, char** argv) {
  uthread_init (1);
  struct Washroom* washroom = createWashroom();
  uthread_t        pt [NUM_PEOPLE];
  waitingHistogrammutex = uthread_mutex_create ();

  // TODO
  srand(time(NULL));
  num_of_gender[MALE] = rand() % NUM_PEOPLE;
  num_of_gender[FEMALE] = NUM_PEOPLE - otherSex[MALE];

  for (int i=0; i < num_of_gender[MALE]; i++) {
    threads[i] = uthread_create(person, (void*) MALE);
  }

  for (int i=num_of_gender[MALE]; i < NUM_PEOPLE; i++) {
    threads[i] = uthread_create(person, (void*) FEMALE);
  }

  for (int i=0; i < (sizeof threads) / (sizeof threads[0]); i++) {
    uthread_join(threads[i], NULL);
  }

  
  printf ("Times with 1 male    %d\n", occupancyHistogram [MALE]   [1]);
  printf ("Times with 2 males   %d\n", occupancyHistogram [MALE]   [2]);
  printf ("Times with 3 males   %d\n", occupancyHistogram [MALE]   [3]);
  printf ("Times with 1 female  %d\n", occupancyHistogram [FEMALE] [1]);
  printf ("Times with 2 females %d\n", occupancyHistogram [FEMALE] [2]);
  printf ("Times with 3 females %d\n", occupancyHistogram [FEMALE] [3]);
  printf ("Waiting Histogram\n");
  for (int i=0; i<WAITING_HISTOGRAM_SIZE; i++)
    if (waitingHistogram [i])
      printf ("  Number of times people waited for %d %s to enter: %d\n", i, i==1?"person":"people", waitingHistogram [i]);
  if (waitingHistogramOverflow)
    printf ("  Number of times people waited more than %d entries: %d\n", WAITING_HISTOGRAM_SIZE, waitingHistogramOverflow);
}