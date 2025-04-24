# frozen_string_literal: true

module UsersHelper
  def masked_username(username)
    if username.length > 3
      "#{username[0..-4]}***"
    else
      '*' * username.length
    end
  end
end
