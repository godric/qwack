# frozen_string_literal: true

def stub_class(name, *args, &block)
  stub_const(name, Class.new(*args, &block))
end
