module WikiExtensionsNotifiablePatch
  def self.apply
    Redmine::Notifiable.singleton_class.prepend self
  end

  def all
    notifications = super
    notifications << Redmine::Notifiable.new('wiki_comment_added')
    notifications
  end
end
