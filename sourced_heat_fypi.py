from fipy import Grid1D, CellVariable, Viewer, TransientTerm, DiffusionTerm, Variable, ImplicitSourceTerm


nx = 200
Lx = 1
dx = Lx/nx

mesh = Grid1D(nx=nx, Lx=Lx)

t = CellVariable(mesh, "Temperature")
viewer = Viewer(t, limits={"ymin": 0, "ymax": 100})

D = 20 # Heat transfer rate
dt = 1e-7 # Time discriteztion
time_steps = 4000 # One second
x = mesh.cellCenters[0]

# Boundry
# t.constrain(0, where=mesh.facesRight)
t.constrain(0, where=mesh.facesLeft)
t.constrain(50, where= (0.4 < x) & (x < 0.6))
t.setValue(60)

# Equation
eq = TransientTerm() == DiffusionTerm(coeff=D)

# Solve

for i in range(time_steps):
    eq.solve(var=t, dt=dt)

    if i % 1000 == 0:
        viewer.plot()





