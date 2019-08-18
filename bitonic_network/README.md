# Bitonic network
Bitonic sorter networks implement a parallel sorting algorithm known as the
[bitonic mergesort](https://en.wikipedia.org/wiki/Bitonic_sorter). It utilize
the special ascending-descending property of _bitonic_ sequences. To guarantee
this property for every subsequence we use two types of comparators (or a
switchable comparator in our case). One that outputs the smaller then the larger
one of its inputs and one that works in the opposite way.

![Switchable comparator interface](./images/comparator)

The core of the bitonic network is the connection structure. An easily
generalizable pattern of such sorter networks can be seen on the
[bitonic sorter](https://en.wikipedia.org/wiki/Bitonic_sorter) Wikipedia page.
In this VHDL implementation we build a network capable of sorting a sequence
of eight numbers.

The `sort_test.vhd` file contains an example unsorted sequence for testing and,
of course, the necessary test entity.
