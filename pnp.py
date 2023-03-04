from fipy import *


# Constants
Lx = 10
nx = 1000
dx = Lx / nx # mm 

D = 1 
epsilon = 1

# FiPy
mesh = Grid1D(dx=dx, Lx=Lx)
x = mesh.cellCenters[0]

Cp = CellVariable(name="$C_p$", mesh=mesh, hasOld=True)
Cn = CellVariable(name="$C_n$", mesh=mesh, hasOld=True)
phi = CellVariable(name="$\phi$", mesh=mesh, hasOld=True)

viewer = Viewer((Cp, Cn, phi), limits={"ymax":5, "ymin":-5})

# Initial
Cn.setValue(0.5*(1+10*numerix.random.rand(len(x))))
Cp.setValue(0.5*(1+10*numerix.random.rand(len(x))))
# Cn.setValue(2*numerix.exp(-(x-Lx/2)**2))
# Cp.setValue(2*numerix.exp(-(x-Lx/2)**2))
phi.setValue(x)

# Boundry
Cp.faceGrad.constrain(0, mesh.facesRight)
Cp.faceGrad.constrain(0, mesh.facesLeft)
Cn.faceGrad.constrain(0, mesh.facesRight)
Cn.faceGrad.constrain(0, mesh.facesLeft)
phi.constrain(4, mesh.facesRight)
phi.constrain(-4, mesh.facesLeft)


# Equations
Cp_diff_eq = TransientTerm(coeff=1, var=Cp) == DiffusionTerm(coeff=D, var=Cp) + DiffusionTerm(coeff=D*Cp, var=phi)
Cn_diff_eq = TransientTerm(coeff=1, var=Cn) == DiffusionTerm(coeff=D, var=Cn) - DiffusionTerm(coeff=D*Cn, var=phi)
poission_eq = DiffusionTerm(coeff=epsilon, var=phi) == (ImplicitSourceTerm(coeff=1, var=Cn) - ImplicitSourceTerm(coeff=1, var=Cp))

equations = poission_eq & Cp_diff_eq & Cn_diff_eq

# Simulation
timestep = 0.01
time_final = 20
desired_residual = 1e-2

time = 0
i = 0
save_frames = False
while time < time_final:
    phi.updateOld()
    Cp.updateOld()
    Cn.updateOld()

    residual = 1e10
    j=0    
    while residual > desired_residual:
        print(f"{i}-{j}")
        residual = equations.sweep(dt=timestep)
        j+=1
    
    if i % 1 == 0 and save_frames:
        viewer.plot(filename=f"./pnp2_frames/frame_{i}.png")
    else:
        viewer.plot()
    
    time_inc = timestep
    time += time_inc
    i += 1