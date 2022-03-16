class ApplicationService
  extend Memoist

  def self.execute(*args, **kwargs, &block)
    service = new(*args, **kwargs)

    service.execute(&block) if service.execute?
  end

  def execute
    raise('Missing #execute method definition')
  end

  def execute?
    true
  end

  def self.private_attr_reader(*names)
    attr_reader(*names)
    private(*names)
  end

  def self.private_attr_writer(*names)
    attr_writer(*names)
    private(*names.map { |name| "#{name}=" })
  end

  def self.private_attr_accessor(*names)
    private_attr_writer(*names)
    private_attr_reader(*names)
  end
end