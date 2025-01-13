# cs342
![image](img.jpg)
# Code File Structure
This figure illustrates the structure of the code files. The `onlinehospital` directory contains all the core logic of the code. In this project, views such as `ContentView` and `OnlineHospitalApp`, as well as various utility classes required for the development project (e.g., `Medication`), are not utilized.

## Core Components

### Medication
The `Medication` part includes the core components of this code: two `struct` classes and two `enum` classes.

- The `Medication` struct defines a `Medication` class with:
  - **6 properties**
  - **2 methods**:
    - A method for providing a description of the medication.
    - A method for determining whether the medication has been fully consumed.

### Patient
The `Patient` struct employs initializers and contains:

- **8 properties**
- **4 methods**:
  1. A method that returns the patient’s full name and age in years as a string, formatted as:  
     `"Last name, First name (Age in years)"`, as it might appear in a list.
  2. A method that returns a list of medications the patient is currently taking, ordered by the date they were prescribed, excluding any completed medications.
  3. A method for prescribing a new medication to a patient, ensuring no duplicate medications are prescribed. If a duplicate is prescribed, the method throws an appropriate error.
  4. An **extension** method to determine which blood types are compatible for the patient.

  ## Code Tests
  All test code is located in the `OnlineHospitalTests` module. It includes:

- Tests for different blood types.
- Functional tests for all implemented methods.
- Tests for the `Medication` class methods.
