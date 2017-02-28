#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include "spinlock.h"
#include "uthread.h"

#define MAX_ITEMS 10

int items = 0;

const int NUM_ITERATIONS = 200;
const int NUM_CONSUMERS  = 2;
const int NUM_PRODUCERS  = 2;

int producer_wait_count = 0;     // # of times producer had to wait
int consumer_wait_count = 0;     // # of times consumer had to wait
int histogram [MAX_ITEMS+1]; // histogram [i] == # of times list stored i items

spinlock_t lock;
spinlock_t producer_lock;
spinlock_t consumer_lock;



void produce() {
  // TODO ensure proper synchronization

  while(1) {
    while (items >= MAX_ITEMS) {
      spinlock_lock(&producer_lock);
      producer_wait_count++;
      spinlock_unlock(&producer_lock);
      //spinlock_lock(&lock);
    }
    //spinlock_lock(&lock);
      spinlock_lock(&lock);
    if (items < MAX_ITEMS) {
      break;
    }
      spinlock_lock(&producer_lock);
      producer_wait_count++;
      spinlock_unlock(&producer_lock);

      spinlock_unlock(&lock);
    //spinlock_lock(&lock);

  }  

  assert (items < MAX_ITEMS);
  items++;
  histogram [items] += 1;
  spinlock_unlock(&lock);
}

void consume() {
  // TODO ensure proper synchronization
  while(1) {
    while (items <= 0) {
      spinlock_lock(&consumer_lock);
      consumer_wait_count++;
      spinlock_unlock(&consumer_lock);
      //spinlock_lock(&lock);
    }
    //spinlock_lock(&lock);
    spinlock_lock(&lock);
    if (items > 0) {

      break;
    } 
    spinlock_lock(&consumer_lock);
    consumer_wait_count++;
    spinlock_unlock(&consumer_lock);

    spinlock_unlock(&lock);
    //spinlock_lock(&lock);
  }  

  assert (items > 0);
  items--;
  histogram [items] += 1;
  spinlock_unlock(&lock);
}

void* producer() {
  // TODO - You might have to change this procedure slightly
  
  for (int i=0; i < NUM_ITERATIONS; i++) {

    produce();
  
  }
  return NULL;
}

void* consumer() {
  // TODO - You might have to change this procedure slightly
  
  for (int i=0; i< NUM_ITERATIONS; i++) {
    consume();
  }
  return NULL;
}

int main (int argc, char** argv) {
  // TODO create threads to run the producers and consumers
  spinlock_create (&lock);
  spinlock_create(&producer_lock);
  spinlock_create(&consumer_lock);

  uthread_init(4);
  uthread_t producers[NUM_PRODUCERS];
  uthread_t consumers[NUM_CONSUMERS];

  for (int i=0; i<2; i++) {
    
    producers[i] = uthread_create(producer, NULL);
    consumers[i] = uthread_create(consumer, NULL);
  }

  for (int j=0; j<2; j++) {
    uthread_join(consumers[j], NULL);
    uthread_join(producers[j], NULL);
  }

  printf("Producer wait: %d\nConsumer wait: %d\n",
         producer_wait_count, consumer_wait_count);
  for(int i=0;i<MAX_ITEMS+1;i++){
    printf("items %d count %d\n", i, histogram[i]);
  }
}
