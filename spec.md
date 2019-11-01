# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
- [x] Use ActiveRecord for storing information in a database
      - ActiveRecord was used to set up and store the tables for Users and Shows.
- [x] Include more than one model class (e.g. User, Post, Category)
      - Users & Shows
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts)
      - User has many Show
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
      - Show belong to User
- [x] Include user accounts with unique login attribute (username or email)
      - User class validates that both username and email are unique
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
- [x] Ensure that users can't modify content created by other users
      - Uses 'if logged_in?' and 'current_user' in methords to ensure shows can only be edited by the user it belongs to
- [x] Include user input validations
      - Checks for empty entries, re-directs if empty
- [ ] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
