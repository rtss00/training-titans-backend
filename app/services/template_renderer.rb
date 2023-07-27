class TemplateRenderer
  attr_accessor :content

  def initialize(template, runner_binding)
    path = File.join(Dir.pwd, 'app', 'services', 'templates', "#{template}.erb")
    file = File.read(path)
    @content = ERB.new(file).result(runner_binding)
  end
end
