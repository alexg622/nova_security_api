team1 = Team.create(name: "Xspeed")

u1 = User.create(email: "alex@mail.com", team_id: team1.id)
u2 = User.create(email: "bill@mail.com", team_id: team1.id)
u3 = User.create(email: "jill@mail.com", team_id: team1.id)
