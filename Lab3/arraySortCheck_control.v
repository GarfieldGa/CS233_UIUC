
module arraySortCheck_control(sorted, done, load_input, load_index, select_index, go, inversion_found, end_of_array, clock, reset);
	output sorted, done, load_input, load_index, select_index;
	input go, inversion_found, end_of_array;
	input clock, reset;

	wire sGarbage, sStart, sLooping, sDone_sorted, sDone_unsorted;

	wire Garbage_next = (sGarbage & ~go) | reset;
	wire Start_next = ((sGarbage | sDone_sorted | sDone_unsorted | sStart) & go) & ~reset;
	wire Looping_next = ((sStart & ~go) | (sLooping & ~end_of_array & ~inversion_found)) & ~reset;
	wire Done_unsorted_next = ((sLooping & inversion_found) | (sDone_unsorted & ~go)) & ~reset;
	wire Done_sorted_next = ((sLooping & end_of_array) | (sDone_sorted & ~go)) & ~reset;

	dffe fsGarbage(sGarbage, Garbage_next, clock, 1'b1, 1'b0);
	dffe fsStart(sStart, Start_next, clock, 1'b1, 1'b0);
	dffe fsLooping(sLooping, Looping_next, clock, 1'b1, 1'b0);
	dffe fsDone_sorted(sDone_sorted, Done_sorted_next, clock, 1'b1, 1'b0);
	dffe fsDone_unsorted(sDone_unsorted, Done_unsorted_next, clock, 1'b1, 1'b0);

	assign sorted = sDone_sorted;
	assign done = sDone_sorted | sDone_unsorted;
	assign load_input = sStart | sLooping;
	assign load_index = sStart | sLooping;
	assign select_index = sLooping;

endmodule
