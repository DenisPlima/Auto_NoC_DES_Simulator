#Readme
-  "NoC_4x4.slx" is a network on chip (NoC) model with 16 Connected routers in a Mesh topology. The traffic generators Connected to routers support traffic's type : Uniform, Periodic and MMPP.

-  "traffic_generator/sink.slx" includes the model of traffic generator/sink.

-  "router.slx" presents a simple router that contains a routing function which implements the XY routing algorithm ("Algorithm XY.m" file).

-  "microarchi_router.slx" presents an architectural router which includes arbitration functions, flow control and a crossbar.

- "Library.slx" brings together all the necessary blocks to implement the architectural router.

##Note :
 * the developed model"NoC_4x4.slx" uses a simple router.
 * Routers and generators are configurable: you choose the block and select the suitable parameters.
