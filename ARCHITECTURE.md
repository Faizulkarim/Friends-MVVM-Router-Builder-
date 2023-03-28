
# Friends - App Architecture 

#### MVVM / Combine

Friends makes use of a MVVM+Router+Builder for its architecture using Combine functional reactive pattern. 

#### Dependency Injection

Friends encapsulates object creation - including injection of its dependencies - in an object called `OTDependencyManager`. The `OTDependencyManager` defines functions for each object that is to be build; the functions obfuscate what the concrete instance of the object is as well as if the instance is shared (i.e. a singleton).

Smaller dependency injection objects called `Builders` are used to product fully-formed `Views`. These break out into smaller chunks the responsibility of setting up the `MVVM` stack for each view.


