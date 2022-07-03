# Welcome to Hasura + FHIR simple Example!

**I've created this POC to show how we can use [Hasura](https://hasura.io/) for FHIR concepts.**

*I am showing below problem in this example.*
> [Patient FHIR resource](https://www.hl7.org/fhir/patient.html#resource). I should be able to query for a patient node and traverse through the telecom field to 0 to many ContactPoint nodes to retrieve related ContactPoint data.

# Query
    {
      patient {
        id
        patient_telecom {
          system
          use
          value
        }
      }
    }
