from fipy import Grid1D, CellVariable, Viewer, TransientTerm, DiffusionTerm, ImplicitSourceTerm, ConvectionTerm

# Simulation Constants
Lx = 1
nx = 1000
dx = Lx/nx

# Physics constants
Dp = 1e-8
Dn = Dp
Du = 0.5*Dp
zeta = 2
beta = 3
lambda_ = 3
epsilon = 1e-2
gamma = 1

# Functions
a = 1
b = 2
w = lambda u: a*u**4 - b*u**2
W_prime = lambda u: 4*a*u**3 - 2*b*u
W_double_prime = lambda u: 12*a*u**2 - 2*b

# Grid
mesh = Grid1D(nx=nx, Lx=Lx)

# Variables
p = CellVariable(mesh, name="p", value=0.5, hasOld=True)
n = CellVariable(mesh, name="n", value=0.5, hasOld=True)
u = CellVariable(mesh, name="u", value=0.1, hasOld=True)
psi = CellVariable(mesh, name="psi", value=0.3, hasOld=True)
phi = CellVariable(mesh, name="\phi", value=0.5, hasOld=True)

# Viewer
viewer = Viewer(u, limits={"ymax": 1, "ymin": 0})


# Initial
x = mesh.cellCenters[0]
u.setValue(0.5, where = x > Lx/2)

# Boundry
p.constrain(0.9, mesh.facesRight)
p.constrain(0.2, mesh.facesLeft)
for var in [n, u, phi]:
    var.constrain(0, mesh.facesRight)
    var.constrain(0, mesh.facesLeft)

#Equations
eq0 = ImplicitSourceTerm(coeff=1., var=psi) == DiffusionTerm(coeff=1., var=u)

eq1 = TransientTerm(var=p) == DiffusionTerm(coeff = Dp*zeta*p*(1+u), var=u) + ConvectionTerm(coeff=phi.faceGrad, var=p) + DiffusionTerm(coeff = 1, var=p) - ImplicitSourceTerm(coeff=gamma*n, var=p)
eq2 = TransientTerm(var=n) == DiffusionTerm(coeff = -Dn*zeta*n*(1-u), var=u) - ConvectionTerm(coeff=phi.faceGrad, var=n) + DiffusionTerm(coeff = 1, var=n) - ImplicitSourceTerm(coeff=gamma*p, var=n)
eq3 = TransientTerm(var=u) == DiffusionTerm(coeff=Du*beta*(1-u**2)*W_double_prime(u), var=u) - DiffusionTerm(coeff=Du*(1-u**2)* lambda_, var=u) \
    + DiffusionTerm(coeff=Du*zeta*(1-u**2)*(p+n), var=u) + DiffusionTerm(coeff=Du*zeta*(1-u**2)*(u+1), var=p) + DiffusionTerm(coeff=Du*zeta*(1-u**2)*(u-1), var=n) \
    + DiffusionTerm(coeff=Du, var=u)
eq4 = 0 == ImplicitSourceTerm(1., var=p) - ImplicitSourceTerm(1., var=n) + DiffusionTerm(coeff=epsilon, var=phi)

equations = eq0 & eq1 & eq2 & eq3 & eq4

# Simulation
dt = 5e-2
desired_residual = 0.001
sweep = 5
steps = 1000

for i in range(steps):
    print(i)
    u.updateOld()
    psi.updateOld()
    phi.updateOld()
    n.updateOld()
    p.updateOld()

    residual = 1e100
    j = 0
    while residual > desired_residual:
        j+=1
        residual = equations.sweep(dt = dt)
        print(f"{i}-{j}")
        print(residual)

    viewer.plot()