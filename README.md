GERun
=====

GERun is a simple, extensible wrapper for different versions of mpirun such that users don't need to know the implementation specfic options when running MPI programs on Legion.

The code is licensed under a 4-clause, BSD-style license, see LICENSE.txt for details.

Overview:
---------

GERun replaces mpirun with a single "gerun" command and autofills in options based on the GE environment.

The intitial version is described in this blog-post:

http://blogs.ucl.ac.uk/research-computing/2013/05/16/easier-parallel-launcher-for-mpi-jobs-gerun/

This version is the public, tidied up version of the code.

GERun allows users to replace complicated formulations like:

```
mpirun -m $TMPDIR/machines -np $NSLOTS $HOME/src/madscience/mad
```

or

```
mpirun --rsh=ssh -machinefile $TMPDIR/machines -np $NSLOTS $HOME/src/madscience/mad
```

depending on their MPI implementation with:

```
gerun $HOME/src/madscience/mad
```

Installation:
-------------

On Legion we use environment modules and so the instructions will be written assuming this.

1) Unpack the code somewhere.

2) Add the path to the code into $PATH (on Legion this is done as part of the "sge" module), and set the $GERUN_PATH to the same location.

3) Inside the module for each MPI implementation set $GERUN_LAUNCHER to the appropriate version for that MPI.

Provided with the code are:

| MPI              | $GERUN_LANUCHER | Wrapper file       |
|:---------------- |:--------------- |:------------------ |
| Qlogic           | qlc             | gerun-qlc          |
| Intel            | intel           | gerun-intel        |
| OpenMPI          | openmpi         | gerun-openmpi      |
| OpenMPI with SGE | openmpi-sge     | genrun-openmpi-sge |

To add a new MPI implementation, you simply need to create a new gerun-<whatver> wrapper and set $GERUN_LAUNCHER appropriately.
