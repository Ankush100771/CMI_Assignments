#!/usr/bin/env python
# coding: utf-8

# # Ankush Dey, Roll No: MDS202108  
# 
# # Anjali Pugalia, Roll No: MDS202107
# 
# # Ritirupa Dey, Roll No:MDS202136

# In[111]:


from bs4 import BeautifulSoup
import pathlib
import re
space_output = 0
space_input = 0
tag=re.compile(r".*(address|Address).*")  
address=re.compile(r"Address|address|ADDRESS|CONTACT|Contact(s)|contact")
pincode=re.compile(r"\b\d\d\d(\s)*\d\d\d\b|\b\d\d\d(\s)*\d\d\d[A-Za-z]*")

for x in range(10):
    filename = str(x) + ".html"
    file = pathlib.Path('input/' + filename)
    if (file.exists()):
        #Read each file
        f = open('input/' + filename, 'r', errors="ignore")
        contents = f.read()   
        
        
        #Your code begins  ###############################
        #Remove html tags
        soup = BeautifulSoup(contents,'html.parser')        
        outputs = soup.find_all('address')
        
        ans=''
        text = ''
        for output1 in outputs:
            ans=ans+output1.get_text()
        outputs2 = soup.find_all(class_=tag)
        for output2 in outputs2:
            ans=ans+output2.get_text()
            
        soup = BeautifulSoup(contents, 'lxml')        
        output = soup.get_text()
        output=output.replace("\n",'')
        
        text=''
        for i in re.finditer(address,output):
            text=text+(output[(i.start()):(i.start()+175)]).strip()
        ans=ans.split()
        text=text.split()
        
        if(len(text)>len(ans)):
            for i in range(len(ans)):
                if ans[i] in text:
                    text=[]
        ans=text+ans
            
        #print(ans,'\n\n\n')
        #print(text)    
       # print(text)
         
        text1=''    
        for i in re.finditer(pincode,output):
            text1=text1+(output[(i.start()-150):(i.start()+37)]).strip()
        text1=text1.split()
      #  print(text1,'\n\n\n\n')
        ans=ans+text1
       # print(list(set().union(text1,op)))
      #  print(ans)
        ans=" ".join(ans)
        output=ans
        #Your code ends  ################################# 
         #Write the output variable contents to output/ folder.
        fw = open('output/' + filename, "w")
        fw.write(output)
        fw.close()
        f.close()
        
        #Calculate space savings
        space_input = space_input + len(contents)
        space_output = space_output + len(output)       


space_gained = round((space_input - space_output) * 100 / space_input, 2)

print("\nTotal Space used by input files = " + str(space_input) + " characters.") 
print("Total Space used by output files = " + str(space_output) + " characters.")
print("Total Space Gained = " + str(space_gained) + "%") 

