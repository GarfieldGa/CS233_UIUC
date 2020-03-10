CC = clang++
FLAGS = -Wall
DEBUG_FLAGS = -O0 $(FLAGS) -g
MIPS = QtSpim

MIPSPP = mips++
ISORT = isort
FWV = fun_with_vtables

ALL_TARGETS = $(MIPSPP) $(ISORT) $(FWV)

.PHONY: mipspp-cpp
mipspp-cpp: main.cpp do_stuff_with_things.cpp print_pet_info.cpp
	$(CC) $(FLAGS) -o $(MIPSPP) $^
	./$(MIPSPP)

.PHONY: mipspp-cpp-debug
mipspp-cpp-debug: main.cpp do_stuff_with_things.cpp print_pet_info.cpp
	$(CC) $(DEBUG_FLAGS) -o $(MIPSPP)-debug $^
	./$(MIPSPP)-debug

.PHONY: mipspp-mips
mipspp-mips: stdio.s animal.s pet.s cat.s dog.s crazy_cat_lady.s print_pet_info.s do_stuff_with_things.s main.s
	$(MIPS) -file $^

.PHONY: isort-cpp
isort-cpp: isort.cpp
	$(CC) $(FLAGS) -o $(ISORT) $^
	./$(ISORT)

.PHONY: isort-cpp-debug
isort-cpp-debug: isort.cpp
	$(CC) $(DEBUG_FLAGS) -o $(ISORT)-debug $^
	./$(ISORT)-debug

.PHONY: isort-mips
isort-mips: isort_main.s isort.s stdio.s
	$(MIPS) -file $^

.PHONY: vtables-cpp
vtables-cpp: vtable_test.cpp vtable_modify.cpp
	$(CC) $(FLAGS) -o $(FWV) $^
	./$(FWV)

.PHONY: vtables-cpp-debug
vtables-cpp-debug: vtable_test.cpp vtable_modify.cpp
	$(CC) $(DEBUG_FLAGS) -o $(FWV)-debug $^
	./$(FWV)-debug

.PHONY: clean
clean:
	rm -rf *-debug*
	rm -f $(ALL_TARGETS)

