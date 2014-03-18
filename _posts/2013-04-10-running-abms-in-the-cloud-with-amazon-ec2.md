---
layout: post
title: "Running ABMs in the Cloud with Amazon EC2"
description: "Introduction to potential for using Amazon EC2 to run ABMs in the cloud"
category: articles
tags: [python, pyabm, high performance computing]
comments: true
share: true
---

PyABM can be installed on an Amazon Elastic Computing Core (EC2) instance to 
allow you to run agent-based models (ABMs) in the cloud. If you are new to 
Amazon EC2, see the [EC2 overview](http://aws.amazon.com/ec2/)
before you get started. Amazon also has a special page on [high performance 
computing (HPC) with EC2](http://aws.amazon.com/hpc-applications/). You will 
also probably want to look at the available [Amazon EC2 instance 
types](http://aws.amazon.com/ec2/instance-types/), and of course the 
[pricing](http://aws.amazon.com/ec2/pricing/)
information before you get started.

A basic cluster with a manager node and two worker nodes will run you about 
$1.50 - $2.00 per hour, depending on the options you choose. You can vary the 
number of CPU cores and the memory in your worker nodes depending on the needs 
of your modeling. In general my models are CPU limited (not requiring large 
amounts of memory) so I will create a small cluster of three Amazon EC2 
instances, with one "Large Standard On-Demand" (m1.large) instance to manage 
the cluster, and two "Extra Large High-CPU On-Demand" (c1.xlarge) instances as 
worker nodes.This configuration gives me a total of 16 processor cores to work 
with (8 per worker node), so I can run 16 model runs at the same time.

The cost to run this cluster is $1.58 per hour with current Amazon EC2 pricing.  
Note that pricing varies depending on the region you choose to place your 
clusters in - the cheapest region is currently in northern Virginia in the 
United States.

The easiest way I have found to get Amazon EC2 clusters up and running is using 
[StarCluster]("http://star.mit.edu/cluster/) - a python program that makes 
setting up, running, and managing Amazon EC2 clusters much easier.

