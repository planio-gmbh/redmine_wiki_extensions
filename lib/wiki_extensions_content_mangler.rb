class WikiExtensionsContentMangler
  def initialize(content, format = nil)
    @content = content
    @page = content.page
    @wiki = @page.wiki
    @format = format
  end

  def update_content
    is_txt = @format == 'txt'
    include_header !is_txt
    add_fnlist
    include_footer !is_txt
    @content
  end

  private

  def add_fnlist
    # do not do that for formats without macro expansion
    return if %w(pdf txt).include? @format
    text = @content.text
    text << "\n\n{{fnlist}}\n"
    @content.text = text
  end

  def include_header(render_html = true)
    return if @page.title == 'Header' || @page.title == 'Footer'
    header = @wiki.find_page('Header')
    return unless header
    text = "\n"
    text << '<div id="wiki_extentions_header">' if render_html
    text << "\n\n"
    text << header.content.text
    text << "\n\n</div>" if render_html
    text << "\n\n"
    text << @content.text
    @content.text = text
  end

  def include_footer(render_html = true)
    return if @page.title == 'Footer' || @page.title == 'Header'
    footer = @wiki.find_page('Footer')
    return unless footer
    text = @content.text
    text << "\n"
    text << '<div id="wiki_extentions_footer">' if render_html
    text << "\n\n"
    text << footer.content.text
    text << "\n\n</div>" if render_html
    @content.text = text
  end
end
