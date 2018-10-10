# nova_security_api

Going to a user's or team's url without an email, id, or auth_token will result in a 403 status code.\
https://novasecurity.herokuapp.com/api/teams/1 \
https://novasecurity.herokuapp.com/api/users 


Getting user credentials without a registered email will create a new user, as well as an auth token for the user. You will get back the user's email, id, and token only the first time. Visiting the page again after that will only give you back the users email and id. \
`https://novasecurity.herokuapp.com/api/users?email={enterarandomemail}` \
try again after a second and the auth token won't appear anymore. \
`https://novasecurity.herokuapp.com/api/users?email={enterarandomemail}`


You can now access this user by auth_token, id, or email, and once accessed credentials are no longer needed since
the session_token is stored locally on the users side through rail's session object. \
https://novasecurity.herokuapp.com/api/users \
`https://novasecurity.herokuapp.com/api/users?email={email}` \
`https://novasecurity.herokuapp.com/api/users?id={id}` \
`https://novasecurity.herokuapp.com/api/users?auth_token={auth_token}`


Access to a team is still denied unless you are part of it. \
`https://novasecurity.herokuapp.com/api/teams/1?email={email}`


If you are part of the team you can view the teams name, id, and member's email addresses. \
https://novasecurity.herokuapp.com/api/teams/1?email=alex@mail.com


If you are part of the team you can also update the teams name. \
`curl -X PUT -d name=ATeam https://novasecurity.herokuapp.com/api/teams/1?email=alex@mail.com`


Every object also has timestamps for when they were created and last updated.


Some problems with storing the session token locally could be if someone uses that person's computer
they will be able to access the token without credentials. Usually you can logout to clear the token, but
in this case the user has no way of clearing the token other than requesting data with a new email. If something is
stored locally on localStorage it is also pretty easy to see which doesn't make it that secure. This would be a lot
more secure if a user had to enter a password to create an account and get their token, and then I could verify
everything through that.
