return if Bundler::Dsl.instance_methods.include?(:eval_gemfile_original)

class Bundler::Dsl
  alias eval_gemfile_original eval_gemfile

  def eval_gemfile(gemfile, contents = nil)
    expanded_gemfile_path = Pathname.new(gemfile).expand_path(@gemfile&.parent)
    return if @gemfiles.any? { |path| path == expanded_gemfile_path }

    eval_gemfile_original(gemfile, contents)
  end
end
