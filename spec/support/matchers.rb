RSpec::Matchers.define :inherit_from do |parent|
  match do |klass|
    klass.ancestors.include?(parent)
  end
end