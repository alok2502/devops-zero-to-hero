# DevOps Notes: Infrastructure as Code (IaC)

This document summarizes key learnings about **Infrastructure as Code (IaC)** and tools like Terraform. It is designed to help streamline revision and provide a strong foundation for practical application.

---

## Day 5: Infrastructure as Code (IaC)

### **Context and Challenges**
As a DevOps engineer, managing infrastructure for a large company comes with unique challenges:
- **Multi-Cloud Hosting**: Companies often host servers across platforms like AWS, Azure, GCP, and on-premises.
- **Scenario**:
  - Initially, automation scripts are created using AWS-specific tools like CloudFormation.
  - If the company switches to Azure or other platforms, existing scripts become unusable, requiring significant effort to recreate automation scripts.
  - Hybrid cloud environments further increase complexity by spreading resources across multiple platforms.

---

### **Solution: Terraform & API as Code**
To overcome these challenges, **Terraform** by HashiCorp emphasizes the concept of _API as Code_:
- **Terraform Overview**:
  - Write infrastructure as code using Terraform's universal language.
  - Manage resources across AWS, Azure, GCP, on-premises, and hybrid environments seamlessly.

- **Key Benefits**:
  - **Provider-Agnostic**: Simplifies infrastructure management by learning just one tool—Terraform.
  - **Automation Flexibility**: Specify the target platform (e.g., `aws`, `azure`) in Terraform scripts, and Terraform handles the interaction with APIs.
  - **Effort Reduction**: Eliminates the need to rewrite scripts for different platforms.

---

### **Terraform Key Features**
Terraform simplifies infrastructure management through the following capabilities:  
- **Infrastructure Management**: Handles provisioning, scaling, and decommissioning resources.  
- **Automation**: Automates repetitive tasks, reducing manual effort and minimizing errors.  
- **Tracking**: Maintains a state file to track the current state of infrastructure, ensuring consistency.  
- **Standardization**: Enforces best practices by allowing reusable templates, improving infrastructure reliability.  
- **Collaboration**: Enables teams to work together effectively on shared infrastructure codebases.

---

### **Terraform Lifecycle**
Terraform follows a structured lifecycle to manage infrastructure across various providers:

1. **Write Configuration Files**:  
   - Start by creating Terraform (`.tf`) files that define the desired infrastructure using HashiCorp Configuration Language (HCL).  
   - Specify the target provider (e.g., AWS, Azure).

2. **Parse Configuration Files**:  
   - Terraform reads the configuration files and converts them into API calls compatible with the target cloud provider.  
   - It ensures the scripts are understood by the provider to create, update, or destroy resources as needed.

3. **Dry Run (Optional)**:  
   - Terraform provides a unique feature called **`terraform plan`**, which allows for a dry run before applying changes.  
   - This feature shows a preview of the actions Terraform will take, ensuring there are no unintended or incorrect changes.  
   - **Benefits**:  
     - Helps identify errors in configuration.  
     - Gives a clear understanding of the changes Terraform will make.  

4. **Apply Changes**:  
   - After reviewing the dry run, use **`terraform apply`** to execute the changes.  
   - Terraform interacts with the provider’s API to create, modify, or delete resources as per the configuration.  

---

### **Terraform Commands**
Terraform primarily works with 4 essential commands:  

1. **`terraform init`**:  
   - Prepares the working directory by downloading provider plugins and initializing the environment.  

2. **`terraform plan`**:  
   - Generates and displays an execution plan for a dry run to preview changes before applying them.  

3. **`terraform apply`**:  
   - Executes the planned actions and provisions the defined resources.  

4. **`terraform destroy`**:  
   - Removes all resources managed by Terraform to clean up the infrastructure.  

---

Happy learning and revising! 🚀
