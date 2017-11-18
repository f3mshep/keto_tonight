User.create!([
  {admin: false, email: "superbiscuit2@gmail.com", password: "password", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 9, current_sign_in_at: "2017-11-15 00:22:33", last_sign_in_at: "2017-11-14 19:09:44", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", provider: "facebook", uid: "10155794879368895"},
  {admin: false, email: "acw313@humboldt.edu", password: "password", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2017-11-09 01:08:01", last_sign_in_at: "2017-11-09 01:08:01", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", provider: nil, uid: nil},
  {admin: false, email: "e.svensson42@gmail.com", password: "password", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2017-11-09 04:06:30", last_sign_in_at: "2017-11-09 04:06:30", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", provider: nil, uid: nil},
  {admin: true, email: "admin@admin.com", password: "password", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2017-11-14 18:53:59", last_sign_in_at: "2017-11-14 18:53:59", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", provider: nil, uid: nil},
  {admin: false, email: "just_desserts@gmail.com", password: "password", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 2, current_sign_in_at: "2017-11-15 00:09:19", last_sign_in_at: "2017-11-14 19:03:20", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", provider: nil, uid: nil}
])
Category.create!([
  {name: "Dinner"},
  {name: "Lunch"},
  {name: "Breakfast"},
  {name: "Dessert"},
  {name: "Side Dish"}
])


