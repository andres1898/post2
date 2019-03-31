Andres Ordoñez Casadiego - Biología Comparada I 2018-02
this is a scripts to develop my post 2 "Can you recuperate the monophyly?"
http://elecsist.blogspot.com/

You have to be sure to have installed R, seq-gen, RaxML-ng, TNT, MrBayes.

Follow the step to get all my results:

1) run generate_topo.R to get topologies
2) run seq-gen.sh for generate the matrices in phylyp format
3) run phy2Nexus.sh and phy2TNT.sh to convert format phy to Nex and to TNT
4) run pars_conc.sh and pars_defa.sh to get the parsimony reconstruction
5) run raxml_sefault.sh and raxml_model.sh to get the ML reconstruction
6) run bayes.sh to get Bayesian recontruction
7) run RF_and_plot.R to get the graph and comparations

at the end you should have the figures of my post 2
