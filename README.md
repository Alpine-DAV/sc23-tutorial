# In Situ Analysis and Visualization with Ascent and ParaView Catalyst
## SC23 Tutorial 

https://sc23.supercomputing.org/presentation/?id=tut133&sess=sess211

Presenters: 

* Cyrus Harrison (LLNL)
* Jean Favre (CSCS)
* Corey Wetterer-Neslon (Kitware)
* Nicole Marsaglia (LLNL)


Date + Time:

* Monday 11/13, 1:30 - 5:00pm


This repo hosts slides and extra materials supporting our SC23 tutorial.


### Tutorial Abstract

Scientific visualization and analysis are key ingredients in HPC simulation workflows. For decades, the dominant paradigm has been post-hoc visualization; simulation codes iterate and save files to disk, giving the domain scientists the opportunity to read the data back at a later time for analysis. In recent years though, this paradigm has been stressed by an ever-diverging rate of growth between I/O and compute speeds. In-situ processing helps mitigate these I/O bottlenecks, enabling simulation and visualization calculations to run in-memory, at higher spatial and temporal resolution, avoiding the transfer of raw data to disks. Even in cases where I/O bottlenecks do not dominate, in-situ processing is well suited for batch-focused analysis, allowing simulation users to obtain distilled results without additional workflow steps.

This half-day tutorial introduces the in-situ visualization paradigm along with Ascent and ParaView Catalyst, two open-source in-situ processing libraries. Both libraries leverage a common interface, Conduit, which provides an intuitive model for describing hierarchical scientific data in C++, C, Fortran, and Python. Attendees will gain hands-on experience learning how to describe simulation data with Conduit and how to use Ascent and Catalyst to transform data, render images, and export results.