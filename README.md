Email-Predictor
===============

A ruby program to predict the email address of an employee at a given company.

##Dependencies
The only gem needed is that ultra sexy Rspec.
```bash
$ gem install rspec
```
Run the tests using the rspec command while in the project root.

## Directions
Running the predictor_interface.rb file from the root directory should start the program.
```bash
$ ruby lib/predictor_interface.rb
```
Once started, just follow the prompts! To predict emails enter a full name, followed by a domain.
```bash
Enter a name to predict an email (ex. 'kiran surdhar'):
$ ricky bobby
Now enter a domain (ex. 'alphasights.com'):
$ talladega.com
```
If given proper input, the application will return an array of one or more addresses.
```bash
["r.b@talladega.com", "r.bobby@talladega.com", "ricky.b@talladega.com", "ricky.bobby@talladega.com"]
```
