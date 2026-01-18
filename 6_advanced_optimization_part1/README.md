# Pre-assignment 6 

In this session, we will be exploring tools for solving linear and integer optimization problems in Julia and JuMP. Julia is a high-level, high-performance dynamic programming language for technical computing. JuMP is a library that enables us to formulate and solve mathematical programs in Julia using state-of-the-art solvers. We will be using the Gurobi solver to solve linear optimimization problems. 

This session consists of three parts:
- Part 1: Introduction to Julia and tips/tricks 
- Part 2: Introduction to JumP and mixed-integer problems
- Part 3: Integer optimization 

In this pre-assignment, we will help you install Julia, the relevant packages, and Gurobi if you don't have them installed already. If you already have the tools installed, you may skip Tasks #1 and #2 and submit the pre-assignment to Canvas, which is due on January 21st at 11:59 p.m.

## Task 1: Install Julia and packages

Please download Julia if you do not have it downloaded already. As of January 2026, the current stable release is v1.12.3. You can download Julia [here](https://julialang.org/downloads/). To open Julia, navigate to your applications folder and select the Julia 1.12 icon. You can also open it by navigating to a terminal and typing "julia".

Note: You can update to the latest version of Julia through `juliaup`, the Julia version manager! `juliaup` allows you to maintain separate Julia installations.

### Julia packages

We will be running a few Jupyter notebooks in this session. IJulia basically hijacks Python's Jupyter notebook, allowing us to run Julia code in line with text, math, and visualizations. You can add IJulia (if you do not have it already) by running the following commands in a Julia session.
```
julia> using Pkg
julia> Pkg.add("IJulia")
```
The package manager using the `]` symbol provides a less verbose installation alternative.
```
julia> ]
(@v1.12) pkg> add IJulia
```
You can exit the package manager by pressing delete/backspace.

While you're there, please install the following packages if you do not have them already:
* DataFrames
* JuMP
* CSV
* Plots
* Random
* LinearAlgebra
* Printf
* Distances
* StatsBase

## Task 2: Install Gurobi

Gurobi is a commercial solver with free academic licenses. Please follow these steps to download and install Gurobi if you have not already. 

1. Go to [Gurobi's website](https://www.gurobi.com/) and sign up for a free account.
2. The downloads page is [here](https://www.gurobi.com/downloads/gurobi-optimizer-eula/). Accept the license agreement and download the most recent version of the Gurobi optimizer (v13.0.0). Follow the installation instructions as prompted.
3. You will need an MIT IP address for step 4. If you are off campus, you can use the [MIT VPN](https://ist.mit.edu/vpn) to connect to the network. (I would recommend only trying this after step 4 fails to work for you.)
4. After you have downloaded the optimizer software, you must obtain an Academic license. The license eventually expires (usually after a year), so you will have to repeat these steps every so often. Julia will notify you when your Gurobi license is about to expire or if it has already expired--you won't be able to solve your models until it has been renewed. Navigate [here](https://www.gurobi.com/downloads/end-user-license-agreement-academic/) and accept the conditions. Scroll to the bottom of the page and you should see something like this:
```
grbgetkey xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
```
Copy the command and replace the `xxxxxx...` with the license key at the bottom of your page. Paste the command into a terminal, not a Julia REPL. Follow the default installation instructions as prompted. Now your computer is allowed to use Gurobi.

5.  Install the Gurobi wrapper in Julia. Before adding Gurobi to our Julia environment, we must point the wrapper to the location of the Gurobi Optimizer's installation. Open a Julia REPL and type the following. If you are on a Mac:
```
julia> ENV["GUROBI_HOME"] = "/Library/gurobi1100/macos_universal2/"
```
Windows:
```
julia> ENV["GUROBI_HOME"] = "C:\\Program Files\\gurobi1100\\win64\\"
```
Linux/Unix:
```
ENV["GUROBI_HOME"] = "/opt/gurobi1100/linux64/"
```
Now, regardless of operating system, run the following commands.
```
julia> using Pkg
julia> Pkg.add("Gurobi")
julia> Pkg.build("Gurobi")
```
A very common error is that the GUROBI_HOME parameter is not properly configured. Feel free to reach out with any difficulties /questions.

## Preassignment (due on January 21st at 11:59 p.m.)

To ensure your installation environment works, please do the following. In a terminal, open Julia. Then run the following commands.
```
julia> using IJulia
julia> notebook()
```
Create a new notebook by selecting New > Julia 1.12.0 (or whatever version of Julia you have). Run the following command in a cell:
```
using CSV, DataFrames, JuMP, Gurobi, LinearAlgebra, Plots, Random, Printf, Distances, StatsBase
```
The installation is successful if the cell does not return any errors (warnings are ok). On Canvas, submit a screenshot of the full web browser page depicting the notebook outputs and the Julia kernel in use.

## Questions?

For any other installation questions regarding Julia, JuMP, Gurobi, or any of the required packages, email Shriya Karam (karam809@mit.edu). 
