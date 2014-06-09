class Hash
  def stringify_keys!
    hash = {}
    self.keys.each do |k|
      self[k.to_s] = self[k]
      self.delete(k)
    end
  end
end