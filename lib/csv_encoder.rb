module OverrideStringEncodeWithOurDefaultOption
  def encode(*args)
    option = args.last.is_a?(Hash) ? args.last : {}
    default = { undef: :replace, replace: '_' }
    override = default.merge(option)
    if args.last.is_a? Hash
      args[args.size - 1] = override
    elsif
      args.push(override)
    end
    super(*args)
  end
end

module WriterOverrider
  def prepare_output
    binding.pry
    super
    binding.pry
  end
end

require 'csv'
class CSV::Writer
  prepend WriterOverrider
end


class Foo
  def generate
    binding.pry
    CSV.generate(encoding: Encoding::Windows_31J) do |csv|
      binding.pry
      csv << ["ほげ"]
      binding.pry
      csv << ["\u2783\uF941\uF90A"]
    end
  end
end
