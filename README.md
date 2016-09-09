## About

This repository contains the finished [EventReporter](https://github.com/turingschool/curriculum/blob/master/source/projects/event_reporter.markdown) project from the Turing School curriculum.

## Purpose

The purpose of the Event Reporter is to create a REPL based program that will continue to run until the user types in exit commands, such as 'exit' or 'quit'. The program uses a combination of command line input (CLI), seperation of classes and inheritance as well as an introduction to API calls and CSS stylesheets. 

## Functionality

The Event Reporter has four basic commands
- Load - This will load data from a .csv file into the system
- Find - This within the data for a specific criteria
- Queue - This is the data of the most recent find results. Within the Queue you command you can:
  - Count
  - Clear
  - Print
  - Print By attribute
  - Save to csv file
  - Export Html
- Help - This will display details about all the possible commands

## Methods

A loop is used to continue the program until an exit command is entered. Until then, the program will parse the user's input into commands and parameters. Using these parsed variables, a set of case statements dictate where the program will head to. CSV functions are used to save and load files, API calls are used to gather district information, and a separate Messages module contains all display and help messages sent to the user. Most of the decision making occurs in the Session class, which holds all the case statements and inheritance. 

In order to create .html files, a specific .erb template file is used that contains .html markdown. The template allows for ruby variables to be stored in the template itself using erb syntax.

```
<td><%= "#{attendee.first_name.upcase} #{attendee.last_name.upcase}" %></td>
```

The .erb template in addidtion to a separate CSS stylesheet help generate the report that is created when the user enters to export html files from the program.
