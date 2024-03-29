defprotocol MavuUtils.Blankable do
  @fallback_to_any true
  @moduledoc """
  Elixir implementation of `blank?`, with similar behaviour to ActiveSupport's
  implementation
  fork from  https://github.com/samsondav/blankable/

  ## Examples

      iex> Blankable.blank?(nil)
      true
      iex> Blankable.blank?("")
      true
      iex> Blankable.blank?([])
      true
      iex> Blankable.blank?("Hello")
      false

  """

  def blank?(term)
end

defimpl MavuUtils.Blankable, for: List do
  def blank?([]), do: true
  def blank?(_), do: false
end

defimpl MavuUtils.Blankable, for: Map do
  # Keep in mind we could not pattern match on %{} because it matches on all
  # maps. We can however check if the size is zero (and size is a fast
  # operation).
  def blank?(map), do: map_size(map) == 0
end

defimpl MavuUtils.Blankable, for: Tuple do
  def blank?({}), do: true
  def blank?(_), do: false
end

defimpl MavuUtils.Blankable, for: BitString do
  def blank?(""), do: true
  def blank?(_), do: false
end

defimpl MavuUtils.Blankable, for: Any do
  def blank?(nil), do: true
  def blank?(false), do: true
  def blank?(atom) when is_atom(atom), do: false
  def blank?(function) when is_function(function), do: false
  def blank?(number) when is_number(number), do: false

  def blank?(term) do
    try do
      Enum.empty?(term)
    rescue
      Protocol.UndefinedError -> false
    end
  end
end
