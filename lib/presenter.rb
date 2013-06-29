class Presenter
  attr_reader :record, :options

  def initialize(record, options={})
    @record  = record
    @options = options
  end

  def as_json(*)
    hash = {}

    self.class.attributes.each do |attr|
      if self.respond_to?(attr)
        hash[attr] = self.send(attr)
      else
        hash[attr] = record.send(attr)
      end
    end

    if options[:include]
      [options[:include]].flatten.each do |attr|
        if self.respond_to?(attr)
          hash[attr] = self.send(attr)
        else
          hash[attr] = record.send(attr)
        end
      end
    end

    hash
  end

  class << self
    attr_reader :attributes
  end

  instance_variable_set('@attributes', [])

  def self.attribute(*keys)
    self.attributes << keys.flatten.map(&:to_s)
    self.attributes.flatten!.uniq!
  end

  def self.inherited(klass)
    super
    klass.instance_variable_set('@attributes', self.attributes.dup)
  end

  def self.class_for(obj)
    if obj.kind_of?(ActiveRecord::Relation)
      "#{obj.first.class}Presenter"
    else
      "#{obj.class}Presenter"
    end
  end
end