Answers:


1.
	a. Size of node Standard_D4s_v3 , with approx 5 nodes , will use 3 diff nodepools we want to differnt the db from the appliactions and monitoring
	b. Price for monthly static pods:
	* East US $70.08
	* West US $85.41
	c. cpu in 10% growth in 3 months is  approx 35 CPUs 
	memory in 10% growth in 3 months is approx 96 GB


2.


	tools used to calculate:

	https://azure.microsoft.com/en-us/pricing/calculator/?service=kubernetes-service

	https://learnk8s.io/kubernetes-instance-calculator#what-s-the-maximum-number-of-pods-in-aks-
------------------------------------------------------------------------------ 
  
	Calculations provided:
	number of pods*CPUs/Ram
	
	Backend:
	total CPU Req : 1*2 = 2 CPUs
	Total Memory Req :  1*10 GB = 10GB
	
	Frontend:
	total CPU Req : 1*0.5 = 0.5 CPUs
	Total Memory Req :  1*3 GB = 3GB
	
	Db:
	total CPU Req : 1*16 = 16 CPUs
	Total Memory Req :  1*32 GB = 32GB
	
	Object storage
	total CPU Req : 1*3 = 3 CPUs
	Total Memory Req :  1*16 GB = 16GB
	
	Monitoring
	total CPU Req : 1*1.5 = 1.5 CPUs
	Total Memory Req :  1*1 GB = 1GB
	
	Executioners
	total CPU Req : 1*2 = 2 CPUs
	Total Memory Req :  1*4 GB = 4GB
	
	
	Total CPU : 24 CPUs
	Total Memory : 66 GB RAM 
	
	Calculation after overhead limit:
	Assuming  10%  for k8s components
	
	
	Overhead CPU: 24 * 0.1 = 2.4
	Overhead Memory :  66 * 0.1 = 6.6 
	
	Total CPU with overhead = 24 + 2.4 = 26.4 CPUs
	Total Ram with overhead  = 66 + 6.2 = 72.2
	
	
	Number of nodes needed for Cpu  26.4/16 = 1.5
	Number of nodes needed for ram 72.2/16 = 4.5 
	
	Calculate the approx grwoth of cpu and ram
	n=3 
	CPU month = 26.4 * (1 + 0.10)**n
	Ram  = 26.4 * (1 + 0.10)**n  
	
	
