class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :account, :questions

  def account
    account_user = @instance_options[:account_user]
    account_user.account
  end
end
