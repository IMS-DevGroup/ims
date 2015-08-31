###Projekt-Konventionen für das Projekt der Gruppe C: Verwaltungssystem für Digitalfunkgeräte 

    Version 1.0 --- 31-08-2015

####1. Ruby Konventionen
  -Worttrennung bei Variablen mit Unterstrich.
  Codebeispiel:
  ```
  this_is_a_variable
  ``` 
  -lokale Variable Codebeispiel:
  ```
  local_variable
  ```
  -Instanzvariable 
  ```
  @instance_variable
  ```
  -Klassenvariable
  ```
  @@class_variable
  ```
  -Konstante
  ```
  EXAMPLE_CONSTANT
  ```
  
  
  -Klassennamen werden im CamelCase geschrieben.
  Codebeispiel:
  ```
  class ExampleClass
  ```
  -Methodennamen werden kleingeschrieben.
  Codebeispiel:
  ```
  def my_method
    puts "hello world"
  end
  ```
  -Sämtliche Bennenungen/Namen/Kommentare etc. müssen auf Englisch sein.
  
####2. Rails und Datenbanken Konventionen
  
  -Tabellennamen im pluralisiertem snake_case
  ```
  devices
  ```
####3. sonstige Konventionen
  
  -für jedes Feature neuen Branch aus dem dev Branch
  
  -Benutzung der RubyMine IDE







