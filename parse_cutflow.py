import sys

if len(sys.argv)<3:
  print("Not enough arguments - exitting")
  exit(3)


input_log         = sys.argv[1]
benchmark_cutflow = sys.argv[2]


# get the current cutflow
fin = open(input_log,"r")

cutflow=[]
for line in fin.readlines():
#  print(line)
#  print('pass' in line)
#  print('all' in line)
  if ("pass" in line) and ("all" in line):
    cut    = line.split(":")[0].strip().replace(' ','_')
    n_pass = int(line.split("pass=")[1].split()[0])
    n_all  = int(line.split("all=")[1].split()[0])
    cutflow.append([cut,n_pass,n_all])
    
fin.close()    
    
# get the previous cutflow
fin = open(benchmark_cutflow,"r")

cutflow_benchmark=[]
for line in fin.readlines():
  cut    = line.split()[0]
  n_pass = int(line.split()[1])
  n_all  = int(line.split()[2])
  cutflow_benchmark.append([cut,n_pass,n_all])
    
fin.close()    

print(cutflow_benchmark)
print(cutflow)

# compare the two
if len(cutflow_benchmark) != len(cutflow):
  print("You don't have the same number of cuts! Is this correct?")
  exit(3)
  
for i in range(len(cutflow)):
  match_flag = "SAME"
  if cutflow_benchmark[i][0]!=cutflow[i][0]:
    match_flag = "FAILURE cut name"
  elif cutflow_benchmark[i][1]!=cutflow[i][1]:
    match_flag = "FAILURE post cut yield"
  elif cutflow_benchmark[i][2]!=cutflow[i][2]:
    match_flag = "FAILURE pre cut yield"
  
  # print the benchmark numbers
  printline = "{0:3} {1:30} {2:10} {3:10}".format(i,cutflow_benchmark[i][0],cutflow_benchmark[i][1],cutflow_benchmark[i][2])
  print(printline)
  
  # print the numbers of this run
  printline = "{0:3} {1:30} {2:10} {3:10}".format(i,cutflow_benchmark[i][0],cutflow_benchmark[i][1],cutflow_benchmark[i][2])
  print(printline)
  
  # print if they are the same or not and take an action
  print(match_flag)
  if match_flag!="SAME":
    exit(3)
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  

    
    