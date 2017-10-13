# Wave Software Development Challenge

## Project Description

https://github.com/wvchallenges/se-challenge-payroll

## Documentation:

### Instructions on how to build/run your application

Built using Rails 4.2.6
Clone the repo and run `bundle install`. 
Run `bundle exec rake db:migrate` to setup the database.
Use `bundle exec rails server` to test the web app.
At the root page, under _import data_, click on _Choose File_ to select file (e.g. sample.csv) and click on _Import CSV_ to import the selected file. the report should appear just below under _Payroll Report_.

### A paragraph or two about what you are particularly proud of in your implementation, and why.

A simple and scalable solution with clear separation of concerns.

The Job model contains the raw data to be processed as required. The separation and references to Report and Employee models ensures the uniqueness of each of their ids.
For the sake of this project, the job group rate table is hardcoded, but it can easily be turned into its own model if required.

The Reports controller and view take care of displaying the webpage as well as importing. The import function in Report model check the footer's report id first to see if is a duplicate before processing the csv file line by line. Separating report into its own model also gives the extra information of when a report is uploaded (created_at).

The Employee model processes the amount_per_pay_period so that information is readily available for specific employees. The data are processed into nested hash structure for quick retrival and easy sorting.
