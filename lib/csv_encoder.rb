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

String.prepend(OverrideStringEncodeWithOurDefaultOption)
class Foo
  def generate
    CSV.generate(encoding: Encoding::Windows_31J) do |csv|
      csv << ["\u2783\uF941\uF90A"]
    end
  end
end
