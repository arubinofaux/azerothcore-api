class AccountController < ApplicationController
  before_action :authorize_request, only: [:account]

  def login
    username = params["account"]["username"].upcase
    password = params["account"]["password"].upcase
    status = 201

    account = Auth::Account.find_by_username(username)

    if account
      hashed_password = Digest::SHA1.hexdigest("#{username}:#{password}").upcase

      if account.sha_pass_hash == hashed_password

      else
        status = 401
        result = "wrong password"
      end
    else
      status = 404
      result = "no account found with that username"
    end
    
    if status == 201
      token = JsonWebToken.encode(user_id: account.id)
      time = Time.now + 24.hours.to_i

      json_response({ 
        token: token, 
        exp: time.strftime("%m-%d-%Y %H:%M"),
        username: account.username 
      })
    else
      json_response({error: result}, status)
    end
  end

  def register
    username = params["account"]["username"].upcase
    email = params["account"]["email"]
    password = params["account"]["password"].upcase
    status = 201

    check_username = Auth::Account.find_by_username(username)
    
    check_email = Auth::Account.find_by_reg_mail(email)

    if check_username or check_email
      if check_username
        status = 403
        result = "username is taken"
      end

      if check_email
        status = 404
        result = "email is taken"
      end
    else
      hashed_password = Digest::SHA1.hexdigest("#{username}:#{password}").upcase

      new_account = Auth::Account.create(
        username: username,
        sha_pass_hash: hashed_password,
        reg_mail: email
      )

      if new_account
        token = JsonWebToken.encode(user_id: new_account.id)
        time = Time.now + 24.hours.to_i

        json_response({ 
          token: token, 
          exp: time.strftime("%m-%d-%Y %H:%M"),
          username: new_account.username 
        }, 201)
      else
        json_response({error: result}, status)
      end
    end
  end

  def account
    characters = Characters::Characters.where(account: @current_user.id)

    json_response(characters)
  end

end
