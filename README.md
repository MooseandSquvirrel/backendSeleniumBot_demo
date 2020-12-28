<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the upComingEventResults_demo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Thanks again! Now go create something AMAZING! :D
***
***
***
*** To avoid retyping too much info. Do a search and replace for the following:
*** github_username, upComingEventResults_demo_name, twitter_handle, email, project_title, project_description
-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->



<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/MooseandSquvirrel/backendSeleniumBot_demo.git">
    <img src="images/analytics.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Fixit!</h3>

  <p align="center">
    A Selenium command-line program to automate data tracking for 1000 events.
    <br />
    <a href="https://github.com/MooseandSquvirrel/backendSeleniumBot_demo.git"><strong>Explore the docs »</strong></a>
  </p>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

<p align="center">
  <a href="https://github.com/MooseandSquvirrel/backendSeleniumBot_demo.git">
    <img src="images/Fixit.png" alt="Fixit Pic" width="640" height="300">
  </a>
</p>

This command-line program was created with Selenium Webdriver inorder to automate
a very time consuming and tedious task for a partnership team. They were asked to track data for a summer campaign of 1000 events using their app. The team had a manual process for using the app's backend tool that was very slow. Often it would take hours to run requests across the globe to servers in Korea just to receive unformated data for just a few events. The solution was to automate this process.

Using Selenium's Ruby version, I created a command-line tool that asked for: 
* employee info for the backend tool authentication login
* a phone number, not required, for twilio API text confirmation that the program finished
* each events info that eventually needed to be written for formatting in a master spreadsheet

The program would then run numerous checks on the events in question, if the dates were within a particular time frame and more. It then did the entire manual process with Selenium WebDriver running headless in a terminal. 

The final output was a parsed, formated, RubyXL spreadsheet with organization and color coding.

This bot ended up saving countless hours of work by not requiring employees to sit and wait for data to return from servers and to then have to manually organize and rewrite the data.

NOTE: It was not meant as an open-source project, and therefore having removed files and lines of code essential to it's functioning for demo purposes, in it's current state it is not functional. However, you are welcome to download and analyze the project and modify the code for use in your own Ruby-based Selenium bots!

### Built With

* [Ruby](https://www.ruby-lang.org/en/)
* [Selenium](https://www.selenium.dev/) / [Selenium WebDriver](https://www.selenium.dev/documentation/en/webdriver/)


<!-- GETTING STARTED -->
## Getting Started

This program was not originally meant for being open-sourced and therefore
is not fully functional in it's current state. However, it can be used as a starting point for Ruby-based Selenium web automation with command-line arguement input. So feel free to download the project and cut it up to meet your personal needs, or simply for reviewing how Selenium can be used. 

* **For a walk-through on how to begin Selenium automation, visit my tutorial <a href="https://medium.com/@andygardnerucla/automate-your-work-with-selenium-2578d5bf61a8">here</a>.**


### Prerequisites

If this were a functioning open-source version of the program, packages required would be:
   ```sh
  gem install rubyXL rubyXL/convenience_methods selenium-webdriver rubygems awesome_print date capybara pp ap rspec/expectations io/console twilio-ruby
   ```

### Installation

1. Git clone.
   ```sh
   git clone https://github.com/MooseandSquvirrel/backendSeleniumBot_demo.git
   ```
2. (If non-demo version, begin program).
   ```sh
   ruby fixit.rb
   ```   

<!-- USAGE EXAMPLES -->
## Usage

This version is mostly for demo/review purposes, not actual usage.
Ideadlly usage would be for ceating Ruby Selenium Bots with command-line interfaces to automate data analysis.

_To view the code: [Documentation](https://github.com/MooseandSquvirrel/backendSeleniumBot_demo.git)_



<!-- CONTACT -->
## Contact

Andy Gardner - web.dev.bud1@gmail.com

Project Link: [https://github.com/MooseandSquvirrel/backendSeleniumBot_demo.git](https://github.com/MooseandSquvirrel/backendSeleniumBot_demo.git)

### Attributes

<div>Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
