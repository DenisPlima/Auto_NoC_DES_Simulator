#Readme
-  "NoC_4x4.slx" file is a network on chip model with 16 Conected routers in a mesh topology. The traffic generators Conected routers support the kinds: Uniform, periodic and MMPP.

-  "traffic_generator/sink.slx" file shows the model of the generator/ sink traffic.

-  "router.slx" file presents a high-level router that contains a routing function that implements the XY routing algorthime (file "Aalgorithm XY.slx").

-  "microarchi_router.slx" file has an architectural router includes arbitration functions, control flow and a crossbar.

- "Library.slx" file brings together all the blocks implemented a router

##Note :
 * the developed model"NoC_4x4.slx" uses the high-level router.
 * Routers and generators are configurable: you choose the block and select the suitable parameters.
