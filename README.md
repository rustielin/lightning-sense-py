# Lightning Sense 

Rough prototyping for a SeNsors-as-a-Service (SNaaS) platform on top of the Lightning Network. (Not sure if there's already an acronym for it, SNaaS looks kinda gross imo).

Micropayments for quantized (streaming) high velocity data, though data velocity can be used as a metric to calculate micropayment value in real time.

Uses a python gRPC client to talk to local instance of lnd.

## Install

Clone `lnd` and `lightning-sense-py` into the same parent directory. 

Create a symlink in `lnd/sense` that points to `lightning-sense-py`. 
