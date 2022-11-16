# Event-Driven-Architecture

The idea behind the project was to make use of microservices, which inform staff members inside a retail market, immediatly after different events occured.
Each microservice represented a machine inside the retail market which, if a certain condition was met, would push a message to its detector model inside AWS.
If a state change occured, based on the defined function of the detector model, the detector model would inform the staff member immediatly.

General overview over the projects architecture:

![prob_arch](https://user-images.githubusercontent.com/117721348/202292243-18963202-3fb8-4f8a-b02e-6469201e88c4.png)

________________________________________________________________________________________________________________________________

Using Terraform in combination with AWS as infrastructure as Code:

![terraform_struc](https://user-images.githubusercontent.com/117721348/202292962-a17f6a54-51b6-4c9e-9579-ae7e2e2241e5.PNG)

________________________________________________________________________________________________________________________________

Containerization of the indiviual microservices using Dockerfiles:

![devices_docker](https://user-images.githubusercontent.com/117721348/202293001-bc0016df-f0c8-498a-af87-11abcc70c0e1.png)
