class Session < ApplicationRecord
  include JsonWebToken

  def session_token
    jwt_encode({ id: id, exp: updated_at })
  end
end
