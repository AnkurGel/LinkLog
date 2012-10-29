namespace :db do
  desc "Makes your admin account"
  task :createadmin => :environment do

    puts "Enter name:  "
    name = STDIN.gets.chomp
    puts "Enter email: "
    email_id = STDIN.gets.chomp
    puts "Enter password (atleast 6 characters) : "
    pass = STDIN.gets.chomp
    puts "Creating admin account... "

    %w(db:drop db:create db:migrate).each do |db_task|
      Rake::Task[db_task].invoke
    end

    if User.create!(:name => name, :email => email_id, :password => pass, :password_confirmation => pass)
      puts "Successful. Run `rails server` to access. Modify your social links from user_info partial in default_pages."
      puts "Feel free to develop. Send pull requests :). Contact: @AnkurGel"
    end
  end
end
