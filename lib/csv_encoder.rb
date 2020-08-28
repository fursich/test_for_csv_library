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
    super
  end

  def << (*args)
    super
  end
end

require 'csv'
class CSV::Writer
  prepend WriterOverrider
end

default_stringio = $LOADED_FEATURES.grep(/stringio/).first
$LOADED_FEATURES.delete default_stringio
Object.send(:remove_const, :StringIO)
require 'stringio'

class Foo
  def generate
    CSV.generate(encoding: Encoding::Windows_31J) do |csv|
      csv << ["a"]
      csv << ["\u2783\uF941\uF90A"]
    end
  end
end
