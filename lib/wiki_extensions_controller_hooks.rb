class WikiExtensionsControllerHooks < Redmine::Hook::Listener

  def controller_wiki_show_before_render(params)
    WikiExtensionsContentMangler.new(params[:content], params[:format]).update_content
  end

end

