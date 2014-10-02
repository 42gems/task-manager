3.times do |i|
  User.create email: "user#{i}@example.com", password: "password"
end

User.first.projects.create title: 'Project #1'
p = Project.first

User.all[1..-1].each do |u|
  p.invites.create user_id: u.id
end

p.tasks.create title: "test-task"
p.tasks.first.comments.create user_id: p.owner.id, body: 'yo meh'
