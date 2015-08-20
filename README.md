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

```bash
mpirun -m $TMPDIR/machines -np $NSLOTS $HOME/src/madscience/mad
```

or

```bash
mpirun --rsh=ssh -machinefile $TMPDIR/machines -np $NSLOTS $HOME/src/madscience/mad
```

depending on their MPI implementation with:

```bash
gerun $HOME/src/madscience/mad
```

GERun version iii supports mixed mode codes in some MPI environments (Intel MPI, OpenMPI *without SGE integration*) by running $NSLOTS/$OMP\_NUM\_THREADS MPI processes, and provides a tool "ppn" which calculates the number of processors per node.  This means that on the new Research Computing OS software stack you can portably (over the node types in the cluster) run with OpenMP threads within a node, MPI between a node should you desire by doing this:

```bash
export OMP_NUM_THREADS=`ppn`
gerun $HOME/src/madscience/mad
```

Alternatively, if you always want to run 2 threads per MPI task you can do this:

```bash
export OMP_NUM_THREADS=2
gerun $HOME/src/madscience/mad
```

Gerun will then run $NSLOTS/2 MPI processes with 2 OpenMP threads each.

Installation:
-------------

On Legion we use environment modules and so the instructions will be written assuming this.

1) Unpack the code somewhere.

2) Add the path to the code into $PATH (on Legion this is done as part of the "sge" module), and set the $GERUN\_PATH to the same location.

3) Inside the module for each MPI implementation set $GERUN\_LAUNCHER to the appropriate version for that MPI.

Provided with the code are:

| MPI              | $GERUN\_LAUNCHER | Wrapper file       |
|:---------------- |:--------------- |:------------------ |
| Qlogic           | qlc             | gerun-qlc          |
| Intel            | intel           | gerun-intel        |
| OpenMPI          | openmpi         | gerun-openmpi      |
| OpenMPI with SGE | openmpi-sge     | genrun-openmpi-sge |

To add a new MPI implementation, you simply need to create a new gerun-<whatver> wrapper and set $GERUN\_LAUNCHER appropriately.
