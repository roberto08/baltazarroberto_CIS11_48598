programs = prog7a prog7b

#if we've supplied a goal on the command line
#then add this to the list of programs we
#already know about
ifneq ($(makecmdgoals),)
programs = $(makedcmdgoals)
endif

#the default rule if none specified on the 
#command line
all: $(programs)

#make knows how to compile .s files, so all
#we need to do is link them.
$(programs): % : %.o
		ld -o $@ $<
		
clean:
		rm -f *.o $(programs)
		