from fipy import Grid1D, CellVariable, TransientTerm, DiffusionTerm, Viewer

m = Grid1D(nx=100, Lx=1.)

# Creating the functions we will solve for
v0 = CellVariable(mesh=m, hasOld=True, value=0.5)
v1 = CellVariable(mesh=m, hasOld=True, value=0.5)

# Setting left boundary conditions
v0.constrain(0, m.facesLeft)
v1.constrain(1, m.facesLeft)

# Setting right boundary conditions
v0.constrain(1, m.facesRight)
v1.constrain(0, m.facesRight)


# Set viewer
vi = Viewer((v0, v1))

# Uncoupled method

# Defining equations
# eq0 = TransientTerm() == DiffusionTerm(coeff=0.01) - v1.faceGrad.divergence
# eq1 = TransientTerm() == v0.faceGrad.divergence + DiffusionTerm(coeff=0.01)
# for t in range(100):
#     v0.updateOld()
#     v1.updateOld()
#     res0 = res1 = 1e100
#     while max(res0, res1) > 0.05:
#         res0 = eq0.sweep(var=v0, dt=1e-5)
#         res1 = eq1.sweep(var=v1, dt=1e-5)
#     vi.plot()


eq0 = TransientTerm(var=v0) == DiffusionTerm(coeff=0.01, var=v0) - DiffusionTerm(coeff=1, var=v1)
eq1 = TransientTerm(var=v1) == DiffusionTerm(coeff=1, var=v0) + DiffusionTerm(coeff=0.01, var=v1)
eqn = eq0 & eq1

for t in range(1000):
    v0.updateOld()
    v1.updateOld()
    eqn.solve(dt=1.e-3)
    vi.plot()