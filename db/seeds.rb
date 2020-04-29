kakashi = User.create(full_name: "Kakashi Hatake", email: "kakashi@leaf.com", role: 1, password: ENV["USER_SEED_PWD1"], profile_image: File.open(File.join(Rails.root, '/app/assets/images/kakashi.jpg')))
naruto = User.create(full_name: "Naruto Uzumaki", email: "naruto@leaf.com", password: ENV["USER_SEED_PWD2"], profile_image: File.open(File.join(Rails.root, '/app/assets/images/naruto.png')))
sakura = User.create(full_name: "Sakura Haruno", email: "sakura@leaf.com", password: ENV["USER_SEED_PWD3"], profile_image: File.open(File.join(Rails.root, '/app/assets/images/sakura.png')))
sasuke = User.create(full_name: "Sasuke Uchiha", email: "sasuke@leaf.com", password: ENV["USER_SEED_PWD4"], profile_image: File.open(File.join(Rails.root, '/app/assets/images/sasuke.png')))

mission1 = Mission.create(title: "Save the cat", description: "Tora the cat is missing again", user: naruto)
mission2 = Mission.create(title: "Escort the Bridge Builder", description: "Tazuna needs assistance to safely return to the Land of Waves", user: sasuke)
mission3 = Mission.create(title: "Find Sasuke", description: "Sasuke has left the Hidden Leaf Village, we need to bring him home!", user: sakura)
mission4 = Mission.create(title: "Locate Orochimaru's hideout", description: "Orochimaru is on the move and has several hideouts, track down his most recent activity", user: kakashi)
