class User < ActiveRecord::Base

  validates_presence_of :login, :password
  validates_uniqueness_of :login
  validates_confirmation_of :password

  has_many :statuses, :dependent => :destroy

  before_create :generate_permalink

  def to_param
    self.permalink
  end

  protected
  def generate_permalink
    self.permalink = self.login.parameterize
  end

end
