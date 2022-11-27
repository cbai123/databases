require 'user_account'
require 'user_account_repository'

def reset_user_account_table
  seed_sql = File.read('spec/seeds_user_accounts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

RSpec.describe UserAccountRepository do
  before(:each) do 
    reset_user_account_table
  end
  # 1
  it "Gets all user_accounts" do

    repo = UserAccountRepository.new

    user_accounts = repo.all

    expect(user_accounts.length).to eq 2

    expect(user_accounts[0].id).to eq 1
    expect(user_accounts[0].email_address).to eq 'user.1@hotmail.com'
    expect(user_accounts[0].username).to eq 'username_1'

    expect(user_accounts[1].id).to eq 2
    expect(user_accounts[1].email_address).to eq 'user.2@hotmail.com'
    expect(user_accounts[1].username).to eq 'username_2'
  end

  # 2
  it "Gets a single user_account" do
    repo = UserAccountRepository.new

    user_account = repo.find(1)

    expect(user_account.id).to eq 1
    expect(user_account.email_address).to eq 'user.1@hotmail.com'
    expect(user_account.username).to eq 'username_1'
  end

  # 3
  it "Create a new user_account" do
    repo = UserAccountRepository.new

    new_user = UserAccount.new
    new_user.email_address = 'user.3@hotmail.com'
    new_user.username = 'username_3'

    repo.create(new_user)

    users = repo.all

    expect(users.length).to eq 3
    expect(users[2].username).to eq 'username_3'
  end

  # 4
  it "Update a user_account" do
    repo = UserAccountRepository.new

    updated_user = repo.find(1)
    updated_user.email_address = 'update.1@hotmail.com'
    updated_user.username = 'updatename'

    repo.update(updated_user)

    user = repo.find(1)

    expect(user.id).to eq 1
    expect(user.email_address).to eq 'update.1@hotmail.com'
    expect(user.username).to eq 'updatename'
  end

  # 5
  it "Delete a user_account" do
    repo = UserAccountRepository.new

    repo.delete(1)

    users = repo.all

    expect(users.length).to eq 1
    expect(users[0].id).to eq 2
  end

  # 6
  it "Delete all user accounts" do
    repo = UserAccountRepository.new

    repo.delete(1)
    repo.delete(2)

    users = repo.all

    expect(users.length).to eq 0
  end
end