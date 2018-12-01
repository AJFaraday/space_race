class Config

  def initialize(data=nil)
    @init_data = data ? data : YAML.load_file('config.yml')
    @init_data.stringify_keys!
    @data = {}
  end

  def method_missing(meth, *args, &block)
    return @data[meth.to_s] if @data[meth.to_s]
    return @data[meth] = get_data(@init_data[meth.to_s]) if @init_data[meth.to_s]
    super if respond_to?(meth)
    nil
  end

  private

  def get_data(source)
    if source.is_a?(Hash)
      Config.new(source)
    elsif source.is_a?(Array)
      source.map { |x| get_data(x) }
    else
      source
    end
  end

end
