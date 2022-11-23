require 'database_connection'
require 'user_account'

class UserAccountRepository
  def all
    # Executes the SQL query:
    sql = 'SELECT * FROM user_accounts;'
    results = DatabaseConnection.exec_params(sql,[])

    user_accounts = []
    results.each {|entry| 
      user = UserAccount.new
      user.id = entry["id"].to_i
      user.email_address = entry["email_address"]
      user.username = entry["username"]

      user_accounts << user
    }
    return user_accounts
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    sql = 'SELECT * FROM user_accounts WHERE id = $1;'
    params = [id]

    result = DatabaseConnection.exec_params(sql,params)

    user = UserAccount.new
    user.id = result[0]["id"].to_i
    user.email_address = result[0]["email_address"]
    user.username = result[0]["username"]

    return user
  end

  # Add more methods below for each operation you'd like to implement.

  def create(user_account)
    # Executes the SQL query:
    sql = 'INSERT INTO user_accounts (email_address, username) VALUES($1, $2);'
    params = [user_account.email_address,user_account.username]

    DatabaseConnection.exec_params(sql,params)

    return nil
  end

  def update(user_account)
    # Executes the SQL query:
    sql = 'UPDATE user_accounts SET email_address = $1, username = $2 WHERE id = $3;'
    params = [user_account.email_address, user_account.username, user_account.id]

    DatabaseConnection.exec_params(sql,params)

    return nil
  end

  def delete(id)
    # Executes the SQL query:
    sql = 'DELETE FROM user_accounts WHERE id = $1;'
    params = [id]

    DatabaseConnection.exec_params(sql,params)

    return nil
  end
end